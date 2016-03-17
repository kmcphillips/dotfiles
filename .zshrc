# Path to your oh-my-zsh installation.
export ZSH=/Users/kevin/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="simple" # "fishy" "macovsky" "muse"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions)

# User configuration

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/sbin:/Users/kevin/bin"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"


# ZSH options and features {{{
# If a command is issued that can’t be executed as a normal command, and the
# command is the name of a directory, perform the cd command to that directory.
setopt AUTO_CD

# Treat  the ‘#’, ‘~’ and ‘^’ characters as part of patterns for filename
# generation, etc.  (An initial unquoted ‘~’ always produces named directory
# expansion.)
# setopt EXTENDED_GLOB

# If a pattern for filename generation has no matches, print an error, instead
# of leaving it unchanged in the argument  list. This also applies to file
# expansion of an initial ‘~’ or ‘=’.
setopt NOMATCH

# no Beep on error in ZLE.
setopt NO_BEEP

# Remove any right prompt from display when accepting a command line. This may
# be useful with terminals with other cut/paste methods.
setopt TRANSIENT_RPROMPT

# If unset, the cursor is set to the end of the word if completion is started.
# Otherwise it stays there and completion is done from both ends.
setopt COMPLETE_IN_WORD

setopt auto_pushd
setopt append_history

unsetopt MULTIOS

# autoload -U compinit promptinit zcalc zsh-mime-setup
# compinit
# promptinit
# zsh-mime-setup
autoload colors
colors
# autoload  -Uz zmv # move function
# autoload  -Uz zed # edit functions within zle
# zle_highlight=(isearch:underline)

# Enable ..<TAB> -> ../
zstyle ':completion:*' special-dirs true

typeset WORDCHARS="*?_-.[]~=&;!#$%^(){}<>"

HISTFILE=~/.zsh_history
SAVEHIST=50000
HISTSIZE=50000
# }}}

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=6'

# Personal aliases
alias p="git pull"
alias gpr="git pull --rebase"
alias gst="git status"
alias gcm="git checkout master"
alias gc="git commit"
alias ga="git add -A"
alias gca="git commit -a --amend --reuse-message=HEAD"
alias be="bundle exec"
alias psg="ps ax | grep -i"
alias rc="bundle exec rails console"
alias rs="bundle exec rails server"
alias h="history | grep"
alias rmorig="find . -iname '*.orig' -exec rm -v '{}' \;"
alias shupdate="git checkout master && git pull && dev up && git checkout -"

# alias rt 'be ruby -Itest -I.'
# alias srt 'be spring testunit'
# alias flushmc 'echo "flush_all" | nc 127.0.0.1 11211'

export EDITOR=vim
export BUNDLER_EDITOR=/Users/kevin/bin/subl
export GIT_MERGE_AUTOEDIT=no
export PRY=ohyes

[ -f /opt/dev/dev.sh ] && source /opt/dev/dev.sh

chruby ruby-2.2.4

