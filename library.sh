# public scripts
CURDIR=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$CURDIR"

#Sends a webhook to infra-system-messages with the inc. argument as the text
webhook() {
  . webhook.cfg
  curl -X POST --data-urlencode "payload={\"channel\": \"#infra-system-messages\", \"username\": \"robut\", \"text\": \"$1\", \"icon_emoji\": \":ghost:\"}" $webhook_url
}

# Finds the newest file in a dir structure
function lastmodified() (
  shopt -s globstar
  latest=
  t=0
  for f in "$1"/**
  do
    x=$(stat -c "%Y" "$f")
    if [ $x -gt $t ]
    then
      latest="$f"
      t="$x"
    fi
  done
  printf "%s\n" "$latest"
  printf "%s\n" "$(date -d @${t})"
)

function crtcheck() {
  curl https://$1 -vI --stderr - | grep "expire date"
}

function search() {
  if [[ -n $1 ]]
  then
    ls -lisatrh | grep $1
  else
    ls -lisatrh
  fi
}

# local scripts
FILE=localLibrary.sh
if [ -f "$FILE" ]; then
    . ./localLibrary.sh
else
    touch localLibrary.sh
    echo "Created local library file"
fi

echo "Script library sourced."
