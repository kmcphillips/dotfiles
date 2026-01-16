# cd if the command is not found and is a directory
setopt AUTO_CD

# If a pattern for filename generation has no matches, print an error, instead
# of leaving it unchanged in the argument  list. This also applies to file
# expansion of an initial ‘~’ or ‘=’.
setopt NOMATCH

# Remove any right prompt from display when accepting a command line. This may
# be useful with terminals with other cut/paste methods.
setopt TRANSIENT_RPROMPT

# If unset, the cursor is set to the end of the word if completion is started.
# Otherwise it stays there and completion is done from both ends.
setopt COMPLETE_IN_WORD

setopt NO_BEEP
setopt auto_pushd
setopt append_history

unsetopt MULTIOS

# Initialize zsh completion system
autoload -Uz compinit
compinit

autoload colors
colors

# Enable ..<TAB> -> ../
zstyle ':completion:*' special-dirs true

typeset WORDCHARS="*?_-.[]~=&;!#$%^(){}<>"

HISTFILE=~/.zsh_history
SAVEHIST=50000
HISTSIZE=50000

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=6'

# Personal aliases
alias p="git pull"
alias gpr="git pull --rebase"
alias gst="git status"
alias gcm="git checkout main"
alias ga="git add -A"
alias gca="git commit --amend --reuse-message=HEAD"
alias grm="git rebase main"
alias grc="GIT_EDITOR=true git rebase --continue"
alias psg="ps ax | grep -i"
alias be="bundle exec"
alias h="history | grep"
alias rmorig="find . -iname '*.orig' -exec rm -v '{}' \;"

export EDITOR=vim
export BUNDLER_EDITOR="$(which cursor)"
export GIT_MERGE_AUTOEDIT=no
export MINITEST_DIFF="git diff --color"

# starship
eval "$(starship init zsh)"

# mise
eval "$(~/.local/bin/mise activate zsh)"

# atuin
. "$HOME/.atuin/bin/env"
eval "$(atuin init zsh)"
