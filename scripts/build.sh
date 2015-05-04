#!/bin/bash
#set -ev
set -e
out="./results/$(date +"%Y-%m-%d")-result-${TRAVIS_BUILD_NUMBER}.md"
echo "---\nlayout: post\nauthor: Travis CI\ntitle: Results for build ${TRAVIS_BUILD_NUMBER}\n---\n\n"
if [ "${TRAVIS_PULL_REQUEST}" = "false" ]; then
  echo "Lang|version|script name|Validation status|real|user|sys" > $out
  echo "---|:---|:---|:---:|:---:|:---:|:---:" >> $out
  for d in ./tests/*; do
    if [ -d $d ]; then 
      tlang=${d##./tests/}
      echo "Testing $tlang scripts"
      if [[ ! -x ./tests/launcher-${tlang}.sh ]]; then echo "No launcher for $tlang, skipping"; continue; fi
      for t in $d/*; do
        echo -n " - Testing $t"
        echo -n "${tlang}|$($tlang --version)|${t##*/}|" >> $out
        echo -n "$(./scripts/validate.sh ./tests/launcher-${tlang}.sh $t)" >> $out
        /usr/bin/time -ao $out -f "|%E|%U|%S" ./tests/launcher-${tlang}.sh $t > /dev/null 
        echo " done."
      done
    fi 
  done   
  echo "Final result matrix:"
  cat $out
  git clone --branch gh-pages "https://github.com/${TRAVIS_REPO_SLUG}"  site
  cp $out site/_posts
  cd site
  git config user.name 'Tensibai'
  git config user.email ${GIT_EMAIL}
  git config credential.helper "store --file=.git/credentials"
  git config push.default simple
  echo "https://${GH_TOKEN}:@github.com" >> .git/credentials
  git add .
  git commit -m "Updating pages from travis build ${TRAVIS_BUILD_NUMBER}"
  git push origin
  rm .git/credentials
else
 echo "Pull request"
fi
