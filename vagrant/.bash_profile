export GITAWAREPROMPT=~/.bash/git-aware-prompt
source $GITAWAREPROMPT/main.sh
export PS1="\[$txtred\]\u\[$txtrst\]\w\[$txtcyn\]\$git_branch\[$txtred\]\$git_dirty\[$txtrst\]\$ "


alias p='git pull'
alias gpr='git pull --rebase'
alias gst='git status'
alias gcm='git checkout master'
alias gcp='git checkout production'
alias gc='git commit'
alias ga='git add -A'
alias be='bundle exec'
alias psg='ps ax | grep -i'
alias rc='bundle exec rails console'
alias rs='bundle exec rails server'
alias rsg='bundle exec rails server | grep -v -E "^(\[(Redis|StatsD|kafka))|(Kafka)"'
alias h='history | grep'
alias rt='be ruby -Itest -I. -r /Users/kevinmcphillips/lib/blank.rb'
alias srt='be spring testunit'
alias rmorig='find . -iname "*.orig" -exec rm -v "{}" \;'
alias flushmc='echo "flush_all" | nc 127.0.0.1 11211'
alias shupdate='git checkout master && git pull && bundle install && lineman clean && bundle exec rake db:migrate db:test:prepare'
