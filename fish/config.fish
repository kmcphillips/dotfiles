# Aliases
alias p 'git pull'
alias gst 'git status'
alias gcm 'git checkout master'
alias gcp 'git checkout production'
alias gc 'git commit'
alias ga 'git add -A'
alias be 'bundle exec'
alias psg 'ps ax | grep -i'
alias rc 'bundle exec rails console'
alias rs 'bundle exec rails server'
alias h 'history | grep'
alias g 'bundle exec guard start'
alias rmorig 'find . -iname "*.orig" -exec rm -v "{}" \;'
alias flushmc 'echo "flush_all" | nc  127.0.0.1 11211'
alias shupdate 'git checkout master ; git pull ; bundle install ; lineman clean ; bundle exec rake db:migrate db:test:prepare'
alias gitflush 'git branch --merged master | grep -v master | xargs git branch -d ; git remote prune origin'

# Environment variables
set -x EDITOR /usr/bin/vi
set -x GIT_MERGE_AUTOEDIT no

# Prompt (depends on the git_current_branch function)
set fish_greeting ''
function fish_prompt
    printf '%sv/%s%s%s$ ' (set_color $fish_color_cwd) (prompt_pwd) (set_color normal) (git_current_branch)
end
