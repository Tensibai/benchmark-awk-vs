#!/bin/bash
set -ev
out="./results/table.md"
if [ "${TRAVIS_PULL_REQUEST}" = "false" ]; then
  echo "Lang|script name|Validation status|real|user|sys" > $out
  echo "---|:---|:---:|:---:|:---:|:---:" >> $out
  for d in ./tests/*; do
    if [ -d $d ]; then 
      tlang=${d##./tests/}
      if [[ ! -x ./tests/launcher-${tlang}.sh ]]; then echo "No launcher for $tlang, skipping"; continue; fi
      for t in $d/*; do
        echo -n "${tlang}|${t##*/}|" >> $out
        echo -n "$(./scripts/validate.sh ./tests/launcher-${tlang}.sh $t)" >> $out
        /usr/bin/time -ao $out -f "|%E|%U|%S" ./tests/launcher-${tlang}.sh $t > /dev/null 
      done
    fi 
  done   
  cat $out
else
 echo "Pull request"
fi
