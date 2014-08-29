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
    color_prompt="\[[32m\]"
    color_reset="\[[0m\]"
  else
    color_user="\[[1;32m\]"
    color_host="\[[36m\]"
    color_cal="\[[33m\]"
    color_time="\[[35m\]"
    color_path="\[[34m\]"
    color_jobs="\[[33m\]"
    color_prompt="\[[32m\]"
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

PS1="${cuser}\u${crst}@${chost}\h${crst} [${ccal}\D{%m-%d}${crst} ${ctime}\D{%H:%M:%S}${crst}] ${cpath}\w${crst}\n[${cjobs}\j${crst} jobs]${cprompt}\$${crst} "

export PS1 CLICOLOR
