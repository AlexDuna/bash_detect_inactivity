#!/usr/bin/env bash

TO_RESTART=()

# Check for any active media players
MEDIAS=$(playerctl -l)

if [[ -z "$MEDIAS" ]] || [[ "$MEDIAS" == "No players found" ]]; then
  echo "Haven't found any players."
  exit 0
else
  for media in $MEDIAS
  do

    # Check if any player is playing

    STATUS=$(playerctl --player=$media status 2>/dev/null)
    if [[ -n $STATUS ]]; then
      if [ "$STATUS" == "Playing" ]; then
        TO_RESTART+="$media "                  # keep currently playing media in mind, when user returns, resume it
        playerctl --player=$media pause
      elif [ "$STATUS" == "Paused" ]; then
        continue
      fi
    fi
  done
fi

echo "${TO_RESTART[@]}" > /tmp/media_to_resume
