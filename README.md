# Detect inactivity and stop media players

The scripts in this repo were created with one goal in mind:
- To detect user inactivity and pause all media players in the background until the user gets back.
- When the user returns to the computer, all players that were running before, but then got paused, will resume.

## Development
I used an interesting command-line utility and library for controlling media players named **Playerctl**.
```Playerctl``` works on media players that implement the [MPRIS](https://specifications.freedesktop.org/mpris-spec/latest/) D-Bus Interface Specification.
- **MPRIS** - Media Player Remote Interfacing Specification is a standard [D-BUS](https://www.freedesktop.org/wiki/Software/dbus/) interface which aims to provide a common programmatic API for controlling media players. Most modern browsers, music apps, such as Spotify, and others are using this interface.

Playerctl comes with a daemon that allows it to act on the currently active media player called ```playerctld```.
This library offers a wide range of commands and options to be used, so more details can be found here: [playerctl](https://github.com/altdesktop/playerctl).

## Scripts

### pause_media.sh
```pause_media.sh``` script checks if there are any active media players running on your computer. If there are, we save them in a ```MEDIAS``` list.
- After checking the list to not be empty, we go through every media device that is active, and check for "Playing" status. Save it for later in a ```TO_RESTART``` list, and pause it.
- We pass the contents of ```TO_RESTART``` list to a ```/tmp/media_to_resume``` temporary file.
- This will be the first step, after the user idles and is detected as inactive.

### resume_media.sh
```resume_media.sh``` script checks if the ```/tmp/media_to_resume``` exists, and then reads the contents of the file into the ```TO_RESTART``` list variable.
- We then go through the list and resume all media players, (basically set their status from "Paused" to "Playing"), and then delete the file.
- This step will take place after the user returns from being AFK.

### detect_inactivity.sh
```detect_inactivity.sh``` script runs in a infinite loop, so it will constantly run in the background and check for idles.
- It detects that the user is inactive, by using [swayidle](https://github.com/swaywm/swayidle), **an idle manager for wayland**. You may need to use other managers if preffered, or in case of not using Wayland, but X11 for example.
- After a 5 minutes idle, on timeout you will need to execute the ```pause_media.sh``` script, by using the full path between ```""```.
- On resume, use the full path to your ```resume_media.sh```

This way, ```detect_inactivity.sh``` script can be used in your config files to detect inactivity and pause media players in the background.

## Thanks for accessing my repo :)
