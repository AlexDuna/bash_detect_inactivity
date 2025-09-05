#!/usr/bin/env bash

if [[ -f /tmp/media_to_resume ]];then
  read -r -a TO_RESTART < /tmp/media_to_resume
  for media in "${TO_RESTART[@]}"; do
    playerctl --player=$media play
  done
  rm /tmp/media_to_resume
fi
