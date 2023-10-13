#!/bin/bash

sudo -n true
test $? -eq 0 || exit 1 "should run this as sudo"

echo installing the must-have pre-reqs
while read -r p ; do sudo apt install -y $p ; done < <(cat << "EOF"
  curl
  vim
  zsh
EOF
)

# Check if oh-my-zsh is installed
OMZDIR="$HOME/.oh-my-zsh"
if [ ! -d "$OMZDIR" ]; then
  echo 'Installing oh-my-zsh'
  /bin/bash -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
else
  echo 'Updating oh-my-zsh'
  omz update
fi

# Change default shell
if [ ! $SHELL == "/bin/zsh" ]; then
  echo 'Changing default shell to zsh'
  chsh -s /bin/zsh
else
  echo 'Already using zsh'
fi
