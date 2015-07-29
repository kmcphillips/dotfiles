export GITAWAREPROMPT=~/.bash/git-aware-prompt
source $GITAWAREPROMPT/main.sh
export PS1="\[$txtred\]\u\[$txtrst\]\w\[$txtcyn\]\$git_branch\[$txtrst\]\$ "

export IM_ALREADY_PRO_THANKS=1
export IM_ALRDY_PR0_AT_WALRUSES_THX=1
export PRY=1

alias p='git pull'
alias gpr='git pull --rebase'
alias gst='git status'
alias gcm='git checkout master'
alias ga='git add -A'
alias be='bundle exec'
alias psg='ps ax | grep -i'
alias rc='bin/rails console'
alias rs='bin/rails server'
alias h='history | grep'
alias rt='be ruby -Itest -I.'
alias srt='be spring testunit'
alias rmorig='find . -iname "*.orig" -exec rm -v "{}" \;'
alias flushmc='echo "flush_all" | nc 127.0.0.1 11211'
alias shupdate='git checkout master && git pull && bundle install && bundle exec rake db:migrate db:test:prepare && git checkout -'
alias fuck='$(thefuck $(fc -ln -1))'
