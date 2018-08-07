# Emacs Tramp bailout
[[ $TERM == "dumb" ]] && unsetopt zle && PS1='$ ' && return

local SCRIPT_PATH
command -v realpath &> /dev/null

if [ $? -eq 0 ]; then
    SCRIPT_PATH=$(realpath ~/.zshrc)
else
    SCRIPT_PATH=$(readlink -f ~/.zshrc)
fi

local ZSH_DIR="${SCRIPT_PATH:h}"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to disable command auto-correction.
# DISABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

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

#ZSH_TMUX_AUTOSTART=true
ZSH_TMUX_ITERM2=true

autoload zmv

source ${ZSH_DIR}/zgen/zgen.zsh

if ! zgen saved; then

	zgen loadall <<EOBUNDLE
zsh-users/zsh-completions src
zsh-users/zsh-syntax-highlighting
EOBUNDLE

	zgen oh-my-zsh

	zgen oh-my-zsh plugins/extract
	zgen oh-my-zsh plugins/cp
	zgen oh-my-zsh plugins/history-substring-search
	zgen oh-my-zsh plugins/safe-paste
	zgen oh-my-zsh plugins/catimg
	zgen oh-my-zsh plugins/common-aliases
	zgen oh-my-zsh plugins/colorize
	zgen oh-my-zsh plugins/fasd
	zgen load supercrabtree/k
    zgen load MichaelAquilina/zsh-you-should-use
    zgen load zdharma/fast-syntax-highlighting

	# terminal
	zgen oh-my-zsh plugins/tmux
	zgen oh-my-zsh plugins/tmuxinator
	zgen oh-my-zsh plugins/screen

	# git
	zgen oh-my-zsh plugins/git
	zgen oh-my-zsh plugins/git-extras
	#zgen oh-my-zsh plugins/git-prompt
	zgen oh-my-zsh plugins/git-flow
	zgen load unixorn/git-extra-commands
    if [ -z "$SSH_CLIENT" ] && [ -z "$SSH_TTY" ]; then
	    zgen oh-my-zsh plugins/github
        zgen oh-my-zsh plugins/tig
    fi

	# ruby
	zgen oh-my-zsh plugins/ruby
    if [ -z "$SSH_CLIENT" ] && [ -z "$SSH_TTY" ]; then
	    #zgen oh-my-zsh plugins/rails
	    zgen oh-my-zsh plugins/rbenv
	    zgen oh-my-zsh plugins/bundler
	    zgen oh-my-zsh plugins/gem
	    zgen oh-my-zsh plugins/zeus
    fi

	# python
	zgen oh-my-zsh plugins/python
	zgen oh-my-zsh plugins/pip
    if [ -z "$SSH_CLIENT" ] && [ -z "$SSH_TTY" ]; then
	    zgen oh-my-zsh plugins/pep8
	    zgen oh-my-zsh plugins/pylint
	    #zgen oh-my-zsh plugins/virtualenv
	    #zgen oh-my-zsh plugins/virtualenvwrapper
    fi

	# javascript
	zgen oh-my-zsh plugins/node
	zgen oh-my-zsh plugins/npm
    if [ -z "$SSH_CLIENT" ] && [ -z "$SSH_TTY" ]; then
	    zgen oh-my-zsh plugins/nvm
	    zgen oh-my-zsh plugins/coffee
	    zgen oh-my-zsh plugins/cake
	    zgen oh-my-zsh plugins/bower
    fi

	# clojure
	zgen oh-my-zsh plugins/lein

	# scala
	zgen oh-my-zsh plugins/sbt
	zgen oh-my-zsh plugins/scala

	# databases
	zgen oh-my-zsh plugins/postgres

	# devops
	zgen oh-my-zsh plugins/docker
	zgen oh-my-zsh plugins/aws
    zgen oh-my-zsh plugins/terraform
    if [ -z "$SSH_CLIENT" ] && [ -z "$SSH_TTY" ]; then
	    zgen oh-my-zsh plugins/vagrant
	    zgen oh-my-zsh plugins/heroku
	    zgen oh-my-zsh plugins/knife
    fi

	# editors
	zgen oh-my-zsh plugins/emacs
	
	if [[ $(uname) == "Darwin" ]]; then
		zgen oh-my-zsh plugins/osx
		zgen oh-my-zsh plugins/brew
		zgen oh-my-zsh plugins/xcode
        zgen load iam4x/zsh-iterm-touchbar
	fi

	if command -v pacman &> /dev/null ; then
		zgen oh-my-zsh plugins/archlinux
	fi

	if command -v apt-get &> /dev/null ; then
		zgen oh-my-zsh plugins/ubuntu
	fi

    if command -v systemctl &> /dev/null ; then
        zgen oh-my-zsh plugins/systemd
    fi

	for bundle in ${ZSH_DIR}/plugins/*(D); do
		zgen load $bundle
	done

	# zgen oh-my-zsh themes/arrow
	zgen load nojhan/liquidprompt liquidprompt.plugin.zsh

	zgen save
fi

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# OPAM configuration
. $HOME/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

# Emacs terminal configuration
if [[ "$TERMINFO" =~ ".*emacs.*" ]]; then
	export TERM=xterm-256color
fi

# iTerm2 shell integration
[ -f "~/.iterm2_shell_integration.zsh" ] && source "~/.iterm2_shell_integration.zsh"

# "zsh history substring search" additional bindings
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down

alias T="todo.sh"

# less
function viless () {
    VIMRUNTIME=$(ls -d /usr/share/vim/vim*/)
    "$VIMRUNTIME/macros/less.sh" $*
}

export LESS='--quit-if-one-screen --ignore-case --status-column --LONG-PROMPT --RAW-CONTROL-CHARS --HILITE-UNREAD --tabs=4 --no-init --window=-4'
