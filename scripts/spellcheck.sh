#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
SCRS="${SCRIPT_DIR}/../src"

function spellcheck-interactive {
    local file=$1

    aspell -t -l en \
       --dont-tex-check-comments \
       --add-tex-command='lettrine opp' \
       --add-tex-command='thispagestyle p' \
       --add-tex-command='usetikzlibrary p' \
       --add-tex-command='setmainfont pp' \
       --add-tex-command='definecolor ppp' \
       --add-tex-command='setmystyle op' \
       --add-tex-command='RequirePackage op' \
       --add-tex-command='usetheme op' \
       --add-tex-command='setcvcontact op' \
       --add-tex-command='hypersetup p' \
       -c $file
}

export -f spellcheck-interactive

find $SRCS -type f -name "*.tex" -exec bash -c 'spellcheck-interactive {}' \;
# todo telco companies
