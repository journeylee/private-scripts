#!/bin/bash

PWD=${PWD:-${HOME}/.journeylee}

ln -svnf ${PWD}/vimrc ${HOME}/.vimrc
ln -svnf ${PWD}/vim ${HOME}/.vim
ln -svnf ${PWD}/bashrc ${HOME}/.bashrc
ln -svnf ${PWD}/bash_profile ${HOME}/.bash_profile
