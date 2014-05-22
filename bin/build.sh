#!/bin/bash

PDF=$1.pdf

mod() {
  if [[ -e $1 ]]; then
    stat -c %Y $1
  fi
}

MOD=$(mod $PDF)

$(dirname "$0")/latexmk -silent -pdf "$1" &>/dev/null \
     || (bin/parse-latex-log.py "$1.log"; exit 1)

# notify if newly created
if [[ $MOD != $(mod $PDF) ]]; then
  echo "$PDF built @$(date)"
else
  echo "$PDF is up to date"
fi