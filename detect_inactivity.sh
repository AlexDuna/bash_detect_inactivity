#!/bin/bash

# Install swayidle if needed

while true; do
    /usr/bin/swayidle -w \
        timeout 300 "/home/alexduna7/GitHub/bash_detect_inactivity/pause_media.sh" \
        resume "/home/alexduna7/GitHub/bash_detect_inactivity/resume_media.sh"  
    sleep 1
done
