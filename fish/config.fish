# Aliases
alias p 'git pull'
alias gpr 'git pull --rebase'
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
alias rt 'be ruby -Itest -I.'
alias srt 'be spring testunit'
alias rmorig 'find . -iname "*.orig" -exec rm -v "{}" \;'
alias flushmc 'echo "flush_all" | nc  127.0.0.1 21211'
alias shupdate 'git checkout master ; git pull ; bundle install ; lineman clean ; bundle exec rake db:migrate db:test:prepare'
alias gitflush 'git branch --merged master | grep -v master | xargs git branch -d ; git remote prune origin'
alias vu 'pushd ~/vagrant ; vagrant up ; popd'
alias vh 'pushd ~/vagrant ; vagrant halt ; popd'
alias vd 'pushd ~/vagrant ; vagrant halt ; popd'
alias vs 'pushd ~/vagrant ; vagrant ssh ; popd'

# Environment variables
set -x PATH $PATH /usr/local/sbin
set -x PATH $PATH /Users/kevinmcphillips/bin
set -x PATH /usr/local/bin $PATH
set -x EDITOR /usr/bin/vi
set -x BUNDLER_EDITOR /Users/kevinmcphillips/bin/subl
set -x GIT_MERGE_AUTOEDIT no

# rbenv shims
set PATH $HOME/.rbenv/bin $PATH
set PATH $HOME/.rbenv/shims $PATH
rbenv rehash >/dev/null ^&1



# Prompt (depends on the git_current_branch function)
set fish_greeting ''
function fish_prompt
    printf '%s%s%s%s$ ' (set_color $fish_color_cwd) (prompt_pwd) (set_color normal) (git_current_branch)
end

