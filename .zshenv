export EDITOR=$(command -v zile || command -v nano || command -v vim)
export PAGER=$(command -v most || command -v less || command -v more)
export READNULLCMD=$PAGER

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

if [ -f /usr/libexec/java_home ]; then
	export JAVA_HOME=$(/usr/libexec/java_home)
fi

#path=(/usr/bin /bin /usr/sbin /sbin $path)
path=(/usr/local/bin /usr/local/sbin /usr/texbin $path)
path=(~/bin ~/Scripts $path)
# brew
path=(/usr/local/share/npm/bin $path)
# Added by the Heroku Toolbelt
path=(/usr/local/heroku/bin $path)
# rbenv
path=(~/.rbenv/bin $path)
# Add RVM to PATH for scripting
path=($path ~/.rvm/bin)

# alias ssh="assh wrapper ssh"
