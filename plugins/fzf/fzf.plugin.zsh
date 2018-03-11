if [ -f ~/.fzf.zsh ]; then
    source ~/.fzf.zsh
else
    echo "Run $(brew --prefix)/opt/fzf/install to set up"
fi
