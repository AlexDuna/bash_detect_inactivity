#!/bin/bash

# Install playerctl if not installed


# Check if any media players are active

MEDIAS=$(playerctl -l 2>&1)
TO_RESTART=""

if [[ -z "$MEDIAS" ]] || [[ "$MEDIAS" == "No players found" ]]; then
  echo "Haven't found any players."
  exit 1
else
  for media in $MEDIAS
  do

    # Check if any player is playing

    STATUS=$(playerctl --player=$media status)
    if [[ -n $STATUS ]]; then
      if [ "$STATUS" == "Playing" ]; then
        TO_RESTART+="$media "
        playerctl --player=$media pause
      elif [ "$STATUS" == "Paused" ]; then
        continue
      fi
    fi
  done
fi

for i in $TO_RESTART
do
  echo "$i"
done



exit 0
