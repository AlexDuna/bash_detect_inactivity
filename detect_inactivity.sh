#!/usr/bin/env bash

# ---------------------------------
# If you are on WAYLAND
# Install swayidle if not installed

# ---------------------------------
# If you are on X11
# Install xautolock if not installed

# ---------------------------------
# If you don't know what Display Manager Protocol you are using, type:
# "echo $XDG_SESSION_TYPE" inside your terminal 

PAUSE_SCRIPT=$(find ~/ -type f -name "pause_media.sh")
RESUME_SCRIPT=$(find ~/ -type f -name "resume_media.sh") 
IDLE_THRESHOLD=300

DISPLAY_PROTOCOL=$XDG_SESSION_TYPE

if [[ -z $DISPLAY_PROTOCOL ]]; then
  exit 1
fi

while true; do
  if [[ $DISPLAY_PROTOCOL == "wayland" ]]; then
    swayidle_path=$(which swayidle)
    $swayidle_path -w \
        timeout 10 "$PAUSE_SCRIPT" \
        resume "$RESUME_SCRIPT"  
    sleep 1
  elif [[ $DISPLAY_PROTOCOL == "x11" ]]; then
    xautolock_path=$(which xautolock)
    $xautolock_path -time $((IDLE_THRESHOLD / 60)) \
                    -locker "$PAUSE_SCRIPT" \
                    -notify 1 \
                    -notifier "$RESUME_SCRIPT"
  fi
done
