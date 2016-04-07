#!/bin/bash

rootd=${HOME}/.journeylee

if [ ! -d "${HOME}/.oh-my-zsh" ]
then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh \
    | sed -e '/env zsh/d')"
fi

ln -snf ${rootd}/vimrc ${HOME}/.vimrc
ln -snf ${rootd}/vim ${HOME}/.vim
ln -snf ${rootd}/bashrc ${HOME}/.bashrc
ln -snf ${rootd}/bash_profile ${HOME}/.bash_profile
ln -snf ${rootd}/ohmyzsh/custom/themes ${HOME}/.oh-my-zsh/custom/

temp=`mktemp -t jpsi` || (
  echo "Error: cant make temp file." >&2
  exit 2
)

sed -e 's@ZSH_THEME="[^"]\{1,\}"@ZSH_THEME="ys.custom"@g'  \
    -e 's@plugins=([^)]\{1,\})@plugins=(git osx bundler brew encode64 redis-cli sudo tmux urltools web-search)@g' \
    ${HOME}/.zshrc > $temp

cat >> $temp <<EOF
export HOMEBREW_GITHUB_API_TOKEN="f1b82f8b4605730becfb6eaf27837ffeb6887f82"

export GOPATH=\$HOME/Documents/go
export PATH=\$PATH:/usr/local/texlive/2015basic/bin/x86_64-darwin:\$GOPATH/bin
EOF

mv -f $temp ${HOME}/.zshrc

env zsh
