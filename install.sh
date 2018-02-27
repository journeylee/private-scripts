#!/bin/bash

rootd=${HOME}/.${USER}
cwd=${PWD}

set -x
if [ -d $rootd ]
then
  cd $rootd
  echo "update install env..."
  git pull -r
else
  git clone https://github.com/journeylee/private-scripts.git $rootd
fi

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

case `uname -s` in
  "Darwin" )
    temp=`mktemp -t jpsi` || (
      echo "Error: cant make temp file." >&2
      exit 2
    )
    ;;
  "Linux" )
    temp=`mktemp -t jpsi.XXXXXX` || (
      echo "Error: cant make temp file." >&2
      exit 2
    )
    ;;
  *)
    echo "Error: unsupported OS, only OS X and Linux supported currently."
    ;;
esac

sed -e 's@ZSH_THEME="[^"]\{1,\}"@ZSH_THEME="ys.custom"@g'  \
    -e 's@plugins=([^)]\{1,\})@plugins=(git bundler encode64 jsontools redis-cli sudo tmux urltools web-search)@g' \
    ${HOME}/.zshrc > $temp

if [[ `uname -s` == "Darwin" ]]
then
  echo "plugins+=(osx brew)" >> $temp
fi

cat >> $temp <<EOF
export HOMEBREW_GITHUB_API_TOKEN="f1b82f8b4605730becfb6eaf27837ffeb6887f82"

export GOPATH=\$HOME/Documents/go
export PATH=\$PATH:/usr/local/texlive/2015basic/bin/x86_64-darwin:\$GOPATH/bin
EOF

mv -f $temp ${HOME}/.zshrc

vim +PlugInstall +qall
env zsh
