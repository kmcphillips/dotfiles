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

  def initialize(filename, resume_filename: nil, cop:)
    @filename = filename
    @lines = File.readlines(@filename)
    @resume_filename = resume_filename.presence
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
            success = yield(filename, line_number)
            if success
              @lines[line_number] = "##{ line }"
              write_file
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
#     RubocopRefactorRunner.new(:name, cop: "Cop/Name").run do |filename, line_number|
class RubocopRefactorRunner < BaseRefactorRunner
  attr_reader :cop

  def initialize(project_name, cop:)
    super(project_name)
    @cop = cop
  end

  protected

  def run_file
    raise "Rubocop todo file does not exist #{ rubocop_todo_file }" unless File.exist?(rubocop_todo_file)

    RubocopTodoFile.new(rubocop_todo_file, resume_filename: ARGV[0], cop: cop).process_file do |filename, line_number|
      yield(filename, line_number)
    end
  end

  def rubocop_todo_file = "#{ project_root }/.rubocop_todo.yml"
end

# Usage
#     FileListRefactorRunner.new(:name, files: ARGV).run do |filename|
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
        message = yield(filename)
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
