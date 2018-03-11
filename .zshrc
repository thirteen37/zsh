# Emacs Tramp bailout
[[ $TERM == "dumb" ]] && unsetopt zle && PS1='$ ' && return

local ZSH_DIR="${0:A:h}"

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
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

autoload zmv

source ${HOME}/zgen/zgen.zsh

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
	zgen oh-my-zsh plugins/thefuck
	zgen oh-my-zsh plugins/colorize
	zgen oh-my-zsh plugins/fasd
	zgen load supercrabtree/k

	# terminal
	zgen oh-my-zsh plugins/tmux
	zgen oh-my-zsh plugins/tmuxinator
	zgen oh-my-zsh plugins/screen

	# git
	zgen oh-my-zsh plugins/git
	zgen oh-my-zsh plugins/git-extras
	#zgen oh-my-zsh plugins/git-prompt
	zgen oh-my-zsh plugins/git-flow
	zgen oh-my-zsh plugins/github
	zgen load unixorn/git-extra-commands

	# ruby
	zgen oh-my-zsh plugins/ruby
	#zgen oh-my-zsh plugins/rails
	zgen oh-my-zsh plugins/rbenv
	zgen oh-my-zsh plugins/bundler
	zgen oh-my-zsh plugins/gem
	zgen oh-my-zsh plugins/zeus

	# python
	zgen oh-my-zsh plugins/python
	zgen oh-my-zsh plugins/pip
	zgen oh-my-zsh plugins/pep8
	zgen oh-my-zsh plugins/pylint
	#zgen oh-my-zsh plugins/virtualenv
	#zgen oh-my-zsh plugins/virtualenvwrapper

	# javascript
	zgen oh-my-zsh plugins/node
	zgen oh-my-zsh plugins/npm
	zgen oh-my-zsh plugins/nvm
	zgen oh-my-zsh plugins/coffee
	zgen oh-my-zsh plugins/cake
	zgen oh-my-zsh plugins/bower

	# clojure
	zgen oh-my-zsh plugins/lein

	# scala
	zgen oh-my-zsh plugins/sbt
	zgen oh-my-zsh plugins/scala

	# databases
	zgen oh-my-zsh plugins/postgres

	# devops
	zgen oh-my-zsh plugins/knife
	zgen oh-my-zsh plugins/docker
	zgen oh-my-zsh plugins/heroku
	zgen oh-my-zsh plugins/vagrant
	zgen oh-my-zsh plugins/aws

	# editors
	zgen oh-my-zsh plugins/emacs
	
	if [[ $(uname) == "Darwin" ]]; then
		zgen oh-my-zsh plugins/osx
		zgen oh-my-zsh plugins/brew
		zgen oh-my-zsh plugins/xcode
	fi

	if command -v pacman &> /dev/null ; then
		zgen oh-my-zsh plugins/archlinux
		zgen oh-my-zsh plugins/systemd
	fi

	if command -v apt-get &> /dev/null ; then
		zgen oh-my-zsh plugins/debian
	fi

	for bundle in $ZSH_DIR/plugins/*(D); do
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

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# iTerm2 shell integration
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# "zsh history substring search" additional bindings
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down

which hub > /dev/null && alias git=hub
which direnv > /dev/null && eval "$(direnv hook zsh)"