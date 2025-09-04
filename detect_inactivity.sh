#!/bin/bash

/usr/bin/swayidle -w \
    timeout 480 "/usr/bin/kitty --class cmatrix-saver -e /usr/bin/cmatrix" \
    resume ""  

