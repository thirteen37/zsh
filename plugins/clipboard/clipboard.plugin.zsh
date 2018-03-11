if which xclip > /dev/null; then
    alias -g copy="xclip -in"
    alias -g paste="xclip -out"
elif which pbcopy > /dev/null; then
    alias -g copy="pbcopy"
    alias -g paste="pbpaste"
fi
