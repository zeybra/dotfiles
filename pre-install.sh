#!/bin/bash

sudo -n true
test $? -eq 0 || exit 1 "should run this as sudo"

echo installing the must-have pre-reqs
while read -r p ; do sudo apt install -y $p ; done < <(cat << "EOF"
  curl
  vim
  zsh
  bsdmainutils
  bsdmainutils
EOF
)

# Check if oh-my-zsh is installed
OMZDIR="$HOME/.oh-my-zsh"
if [ ! -d "$OMZDIR" ]; then
  echo 'Installing oh-my-zsh'
  /bin/bash -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
else
  echo 'Updating oh-my-zsh'
  #omz update
  env ZSH=$OMZDIR sh $OMZDIR/tools/upgrade.sh
fi

# Install zsh-autosuggestions plugin
AUTOSUGGESTIONS_DIR="${ZSH_CUSTOM:-$OMZDIR/custom}/plugins/zsh-autosuggestions"
if [ ! -d "$AUTOSUGGESTIONS_DIR" ]; then
  echo 'Installing zsh-autosuggestions'
  git clone https://github.com/zsh-users/zsh-autosuggestions $AUTOSUGGESTIONS_DIR
else
  echo 'zsh-autosuggestions already installed'
fi

# Install zsh-syntax-highlighting plugin
SYNTAX_HIGHLIGHTING_DIR="${ZSH_CUSTOM:-$OMZDIR/custom}/plugins/zsh-syntax-highlighting"
if [ ! -d "$SYNTAX_HIGHLIGHTING_DIR" ]; then
  echo 'Installing zsh-syntax-highlighting'
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $SYNTAX_HIGHLIGHTING_DIR
else
  echo 'zsh-syntax-highlighting already installed'
fi

# Enable zsh-autosuggestions and zsh-syntax-highlighting plugins in .zshrc
PLUGINS_TO_ENABLE=("zsh-autosuggestions" "zsh-syntax-highlighting")
for PLUGIN in "${PLUGINS_TO_ENABLE[@]}"; do
  if ! grep -q "$PLUGIN" "$HOME/.zshrc"; then
    echo "Enabling $PLUGIN in .zshrc"
    echo "plugins=(\$plugins $PLUGIN)" >> "$HOME/.zshrc"
  else
    echo "$PLUGIN already enabled in .zshrc"
  fi
done

# Change default shell
if [ ! $SHELL == "/bin/zsh" ]; then
  echo 'Changing default shell to zsh'
  chsh -s /bin/zsh
else
  echo 'Already using zsh'
fi

