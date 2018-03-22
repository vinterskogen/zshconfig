#!/bin/sh

# Use colors, but only if connected to a terminal, and that terminal supports them.
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

# Asking for user's confirmation
echo " ${YELLOW}Oh My Zsh and additional configuration installer${NORMAL} "
echo
echo " This will pull the latest version of Oh My Zsh as well as an additional"
echo " configuration set to tune your zsh to be a perfect shell."
echo
echo " More - ${BLUE}https://github.com/vinterskogen/zshconfig${NORMAL}"
echo
echo -n "${GREEN} Do you wish to continue? (yes/no) [no]${NORMAL}: "
read answer

if ! echo "$answer" | grep -iq "^y" ; then
    exit 1
else
    echo
fi

# Test current shell
TEST_CURRENT_SHELL=$(expr "$SHELL" : '.*/\(.*\)')
if [ "$TEST_CURRENT_SHELL" != "zsh" ]; then
  echo "${YELLOW}Notice: make sure you are using ZSH!${NORMAL}"
  echo
fi;

# ZSH configuration directory
ZSH_CONFIG_DIR=$(dirname "$(readlink -f "$0")")

# Check minimal requirements
if ! [ -x "$(command -v git)" ]; then
  echo "${RED}Error: git is not installed.${NORMAL}" >&2
  exit 1
fi

# Goto user's home directory
cd $HOME

OH_MY_ZSH_DIR="$HOME/.oh-my-zsh"

echo -n " - Checking for existing installation... "

# Download Oh My Zsh
if [ ! -e $OH_MY_ZSH_DIR ]; then
  echo "${BLUE}missing.${NORMAL}"
  echo -n " - Pulling Oh My Zsh from GitHub... "
  git clone --depth=1 --quiet https://github.com/robbyrussell/oh-my-zsh.git "$OH_MY_ZSH_DIR"
  if [ ! $? -eq 0 ] ; then
    echo "${RED}failed!${NORMAL}"
    exit 1
  fi
  echo "${GREEN}done!${NORMAL}"
else
  echo "${BLUE}found!${NORMAL}"
fi

# Backup old ZSH configuration files
if [ -e $HOME/.zshrc ]; then
  mv "$HOME/.zshrc" "$HOME/.zshrc.old"
fi
if [ -e $HOME/.zsh_aliases ]; then
  mv "$HOME/.zsh_aliases" "$HOME/.zsh_aliases.old"
fi

# Linking ZSH configuration files
echo -n " - Setting up additional configuration... "
ln -s "$ZSH_CONFIG_DIR/zshrc" "$HOME/.zshrc"
ln -s "$ZSH_CONFIG_DIR/zsh_aliases" "$HOME/.zsh_aliases"
echo "${GREEN}done!${NORMAL}"

echo
echo " ${GREEN}Installed.${NORMAL}"
echo " Enjoy using it! ;)"
echo
