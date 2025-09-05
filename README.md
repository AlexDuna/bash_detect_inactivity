# Detect inactivity and stop media players

The scripts in this repo were created with one goal in mind:
- To detect user inactivity and pause all media players in the background until the user gets back.
- When the user returns to the computer, all players that were running before, but then got paused, will resume.

## Important!
- If your system is using [wayland](https://wayland.freedesktop.org/), in order for the script to execute, you need to install [swayidle](https://github.com/swaywm/swayidle).
- If your system is using [x11](https://en.wikipedia.org/wiki/X_Window_System), then you need to install [xautolock](https://github.com/eatse21/xautolock).
- In case you don't know what display server protocol you are using, don't panic, just copy the following command in your terminal:
```bash
$ echo $XDG_SESSION_TYPE
```
- If you would like to use other **idle management daemon** then the ones used in the scripts, feel free to research and edit the ```detect_inactivity.sh``` script to suit your preference. 

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
- I gave the script the job to find the ```pause_media.sh``` and ```resume_media.sh``` scripts on your system so that you dont have to, but feel free to put your paths instead of the ```find``` commands for ```PAUSE_MEDIA``` and ```RESUME_MEDIA``` variables.
- It detects that the user is inactive, by using [swayidle](https://github.com/swaywm/swayidle) for **Wayland**, and [xautolock](https://github.com/eatse21/xautolock) for **X11**, which are called **idle management daemons**. You can edit this script to use your prefered idle manager.
- After a 5 minutes idle, basically inactivity is detected and ```pause_media.sh``` script is executed. After detecting activity again, the ```resume_media.sh``` is executed and every media player that was active before IDLE will resume to its state.

This way, ```detect_inactivity.sh``` script can be used in your config files to detect inactivity and pause media players in the background.

## Thanks for accessing my repo :)
