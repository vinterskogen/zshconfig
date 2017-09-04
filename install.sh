#!/bin/sh

# Use colors, but only if connected to a terminal, and that terminal
# supports them.
if which tput >/dev/null 2>&1; then
  ncolors=$(tput colors)
fi

if [ -t 1 ] && [ -n "$ncolors" ] && [ "$ncolors" -ge 8 ]; then
  RED="$(tput setaf 1)"
  GREEN="$(tput setaf 2)"
  YELLOW="$(tput setaf 3)"
  BLUE="$(tput setaf 4)"
  BOLD="$(tput bold)"
  NORMAL="$(tput sgr0)"
else
  RED=""
  GREEN=""
  YELLOW=""
  BLUE=""
  BOLD=""
  NORMAL=""
fi

echo "Installing Oh My Zsh with configuration... \n"

# Test current shell
TEST_CURRENT_SHELL=$(expr "$SHELL" : '.*/\(.*\)')
if [ "$TEST_CURRENT_SHELL" != "zsh" ]; then
  echo "${RED}Make sure you are using ZSH shell!${NORMAL}\n"
fi;

# ZSH configuration directory
ZSH_CONFIG_DIR=$(dirname "$(readlink -f "$0")")

# Check minimal requirements
if ! [ -x "$(command -v git)" ]; then
  echo "Error: git is not installed." >&2
  exit 1
fi

# Goto user's home directory
cd $HOME

OH_MY_ZSH_DIR="$HOME/.oh-my-zsh"

echo -n "- Cheching for existing installation... "

# Download Oh My Zsh
if [ ! -e $OH_MY_ZSH_DIR ]; then
  echo "${GREEN}not found!${NORMAL}"
  echo -n "- Downloading Oh My Zsh... "
  git clone --depth=1 --quiet https://github.com/robbyrussell/oh-my-zsh.git "$OH_MY_ZSH_DIR"
  echo "${GREEN}done!${NORMAL}"
else
  echo "${BOLD}found.${NORMAL}"
  echo "  ${YELLOW}Notice: Oh My Zsh is already installed.${NORMAL}"
  echo "  ${YELLOW}(You'll need to remove $OH_MY_ZSH_DIR if you want to re-install it.)${NORMAL}\n"
fi

# Moving old ZSH configuration files
if [ -e $HOME/.zshrc ]; then
  mv "$HOME/.zshrc" "$HOME/.oh-my-zsh/.zshrc.old"
fi
if [ -e $HOME/.zsh_aliases ]; then
  mv "$HOME/.zsh_aliases" "$HOME/.oh-my-zsh/.zsh_aliases.old"
fi

# Linking ZSH configuration files
echo -n "- Setting up configuration... "
ln -s "$ZSH_CONFIG_DIR/zshrc" "$HOME/.zshrc"
ln -s "$ZSH_CONFIG_DIR/zsh_aliases" "$HOME/.zsh_aliases"
echo "${GREEN}done!${NORMAL}"

echo
echo "  All done."
echo "  Learn more - https://github.com/vinterskogen/zshconfig\n"

echo "  Enjoy using it! ;)\n"
