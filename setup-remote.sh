#!/usr/bin/env zsh

REMOTE_HOST=${1:?Need SSH host name}

SCRIPT_DIR=${0:A:h}

# ZSH
rsync -pav ${SCRIPT_DIR} $REMOTE_HOST: --delete
ssh $REMOTE_HOST <<EOF
ln -sf oh-my-zgen/.zshrc
ln -sf oh-my-zgen/.zshenv
rm -rf .zgen
EOF

# Screen
ssh $REMOTE_HOST "cat > .screenrc" <<EOF
escape "^Xx"
startup_message off
hardstatus off
EOF
