#!/bin/bash
esc=$'\033'
for row in {0..15} ; 
do
    rowtext=
    for col in {0..15}; 
    do
        color=$(( $row * 16 + $col))
        BG="${esc}[48;5;${color}m"
        rowtext=${rowtext}$BG\ 
        if [[ $color -lt 100 ]]; then rowtext=${rowtext}$BG\   ;fi 
        if [[ $color -lt 10 ]]; then rowtext=${rowtext}$BG\   ;fi 
        rowtext=${rowtext}$BG${color}
        rowtext=${rowtext}$BG\ 
    done
    echo "${rowtext}${esc}[00m "
done
