function rvm-init {
    [[ -s ~/.rvm/scripts/rvm ]] && . ~/.rvm/scripts/rvm
    # path=(~/.rvm/gems/ruby-**/bin $path)
    path=(~/.rvm/bin $path)
    which antigen-bundle > /dev/null && antigen-bundle rvm
}
