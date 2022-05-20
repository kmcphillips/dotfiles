# frozen_string_literal: true

require "bundler/inline"

gemfile do
  source "https://rubygems.org"
  gem "activesupport", "< 7.0"
  gem "rainbow"
end

require "active_support"
require "active_support/core_ext"
require "logger"
require "open3"

class Failure < StandardError ; end

class RubocopTodoFile
  attr_reader :lines, :cop

  def initialize(filename, resume_filename: nil, only_filenames: nil, cop:)
    @filename = filename
    @lines = File.readlines(@filename)
    @resume_filename = resume_filename.presence
    @only_filenames = Array(only_filenames)
    @cop = cop
  end

  def process_file
    parse_state = :before

    (0..(@lines.length)).each do |line_number|
      line = @lines[line_number]

      case parse_state
      when :before
        if line.start_with?(cop)
          parse_state = if @resume_filename
            :resuming
          else
            :processing
          end
        end
      when :processing, :resuming
        if line.blank?
          parse_state = :done
        elsif match_data = line.match(/^    - '(.+)'/)
          filename = match_data[1]
          parse_state = :processing if parse_state == :resuming && filename == @resume_filename
          if parse_state == :processing
            if @only_filenames.empty? || @only_filenames.include?(filename)
              success = yield(filename, line_number)
              if success
                @lines[line_number] = "##{ line }"
                write_file
              end
            end
          end
        end
      when :done
        # just consume and finish
      end
    end

    puts Rainbow("Warning: Resume file not found.").red if parse_state == :resuming
  end

  private

  def write_file
    File.open(@filename, "w") { |f| f.write(@lines.join("")) }
  end
end

class Context
  attr_reader :line_number, :logger, :cop

  def initialize(line_number: nil, cop: nil, logger: nil)
    @line_number = line_number
    @cop = cop
    @logger = logger
  end
end

class BaseRefactorRunner
  attr_reader :project_name

  def initialize(project_name)
    @project_name = project_name
  end

  def run(&block)
    logger.info("Starting #{ project_name }")
    puts Rainbow("Starting #{ project_name }").aqua

    raise "Project root does not exist #{ project_root }" unless File.exist?(project_root)
    raise "No block passed to `run_file`" unless block_given?

    run_file(&block)

    logger.info("Finished #{ project_name }")
    puts Rainbow("Finished #{ project_name }").aqua
  end

  protected

  def run_file
    raise NotImplementedError
  end

  def project_root = "#{ Dir.home }/src/github.com/Shopify/shopify"
  def log_file = "#{ project_root }/#{ project_name }.log"

  def logger
    @logger ||= begin
      logger_file = File.open(log_file, File::WRONLY | File::APPEND | File::CREAT)
      logger_file.sync = true
      Logger.new(logger_file, level: Logger::INFO)
    end
  end
end

# Usage
#     RubocopRefactorRunner.new(:name, cop: "Cop/Name").run do |filename, context|
class RubocopRefactorRunner < BaseRefactorRunner
  attr_reader :cop, :resume_filename, :only_filenames

  def initialize(project_name, cop:, resume_filename: nil, only_filenames: nil)
    super(project_name)
    @resume_filename = resume_filename
    @only_filenames = only_filenames
    @cop = cop
  end

  protected

  def run_file
    raise "Rubocop todo file does not exist #{ rubocop_todo_file }" unless File.exist?(rubocop_todo_file)

    starting_message = if only_filenames.empty?
      "Processing #{ cop } on all files"
    else
      "Processing #{ cop } on only #{ only_filenames.count } files"
    end

    logger.info(starting_message)
    puts Rainbow(starting_message).aqua

    RubocopTodoFile.new(rubocop_todo_file, cop: cop, resume_filename: resume_filename, only_filenames: only_filenames).process_file do |filename, line_number|
      context = Context.new(
        line_number: line_number,
        logger: logger,
        cop: cop,
      )

      yield(filename, context)
    end
  end

  def rubocop_todo_file = "#{ project_root }/.rubocop_todo.yml"
end

# Usage
#     FileListRefactorRunner.new(:name, files: ARGV).run do |filename, context|
#       if do_something(filename)
#         "the success message"
#       else
#         raise Failure, "the failure message"
#       end
class FileListRefactorRunner < BaseRefactorRunner
  attr_reader :files

  def initialize(project_name, files:)
    super(project_name)
    @files = files
  end

  protected

  def run_file
    files.each do |filename|
      success = false
      message = nil

      print "#{ filename } "

      begin
        message = yield(filename, Context.new(logger: logger))
        success = true
      rescue Failure => e
        success = false
        message = e.message
      end

      if success
        puts Rainbow(message.presence || "success").green
        logger.info("#{ filename } #{ message.presence || "success" }")
      else
        puts Rainbow(message.presence || "failure").red
        logger.info("#{ filename } #{ message.presence || "failure" }")
      end

      success
    end
  end
end
