#!/bin/bash

# term color detect and settings
is_color_term=`tput colors`
if [[ $? == 0 ]] && [[ "${is_color_term}x" != "x" ]]
then

  CLICOLOR=1
  
  if [[ ${UID:-500} == 0 ]]
  then
    color_user="\[[1;31m\]"
    color_host="\[[36m\]"
    color_cal="\[[33m\]"
    color_time="\[[35m\]"
    color_path="\[[34m\]"
    color_jobs="\[[33m\]"
    color_prompt="\[[38;05;124m\]"
    color_reset="\[[0m\]"
  else
    color_user="\[[38;05;65m\]"
    color_host="\[[38;05;103m\]"
    color_cal="\[[38;05;102m\]"
    color_time="\[[38;05;143m\]"
    color_path="\[[38;05;141m\]"
    color_jobs="\[[38;05;37m\]"
    color_prompt="\[[38;05;72m\]"
    color_reset="\[[0m\]"
  fi
fi

cuser=${color_user:-}
chost=${color_host:-}
ccal=${color_cal:-}
ctime=${color_time:-}
cpath=${color_path:-}
cjobs=${color_jobs:-}
cprompt=${color_prompt:-}
crst=${color_reset:-}

PS1="${cuser}\u${crst}@${chost}\h${crst} [${ccal}\D{%m-%d}${crst} ${ctime}\D{%H:%M:%S}${crst}] ${cpath}\w${crst}\n[${cjobs}\j${crst} jobs]${cprompt}\\\$${crst} "

export PS1 CLICOLOR

if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi
