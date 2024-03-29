#!/bin/bash

set -eu

REPOSITORY=https://github.com/tqer39/dotfiles

main() {
  detect_os
  if [ "$PLATFORM" == 'linux' ] || [ "$PLATFORM" == 'mac' ]; then
    setup_dotfiles
  else
    abort 'このOSは対応していません'
  fi

  exit 0
}

abort() {
  printf "%s\n" "$@"
  exit 1
}

detect_os() {
  if [ "$(uname)" == "Darwin" ]; then
    PLATFORM=mac
  elif [ "$(uname -s)" == "MINGW" ]; then
    PLATFORM=windows
  elif [ "$(uname -s)" == "Linux" ]; then
    PLATFORM=linux
  else
    PLATFORM="Unknown OS"
    abort "Your platform ($(uname -a)) is not supported."
  fi
}

is_exists() {
  which "$1" >/dev/null 2>&1
  return $?
}

setup_dotfiles() {
  if [ ! -e "$HOME/dotfiles" ]; then
    if is_exists "git"; then
      git clone "${REPOSITORY}.git" "$HOME/dotfiles"
    else
      cd "$HOME/Downloads"
      wget -O ./dotfiles.zip "${REPOSITORY}/archive/main.zip"
      unzip ./dotfiles.zip
      rm -rf ./dotfiles.zip
      mv ./dotfiles-main "$HOME/dotfiles"
      cd
    fi
  fi

  mkdir -p "$HOME/.config/terminator"
  mkdir -p "$HOME/.config/fish"
  mkdir -p ./tmp

  cd "$HOME/dotfiles"

  # common
  find ./common -type f > ./tmp/dotfiles.txt
  sed -i.org "s/\.\/common\///g" ./tmp/dotfiles.txt
  mapfile -t DOTFILES < ./tmp/dotfiles.txt

  for f in "${DOTFILES[@]}"; do
    ln -sf "$PWD/common/$f" "$HOME/$f"
  done

  # platform
  find "./$PLATFORM" -type f -name '.*' > "./tmp/dotfiles-$PLATFORM.txt"
  sed -i.org "s/\.\/$PLATFORM\///g" "./tmp/dotfiles-$PLATFORM.txt"
  mapfile -t DOTFILES < "./tmp/dotfiles-$PLATFORM.txt"

  for f in "${DOTFILES[@]}"; do
    ln -sf "$HOME/dotfiles/$PLATFORM/$f" "$HOME/$f"
  done

  rm -rf ./tmp
}

main
