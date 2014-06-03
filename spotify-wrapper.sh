#!/bin/bash

# Spotify-Adkiller Respository: https://github.com/SecUpwN/Spotify-AdKiller/
# Feel free to contribute improvements and suggestions to this funky script!

# Wrapper-Script to automatically start Spotify-AdKiller when Spotify starts

# IMPORTANT REMINDER! CAREFULLY READ AND UNDERSTAND THIS PART. THANK YOU.
# -----------------------------------------------------------------------
# Spotify is a fantastic service and worth every penny.
# This script is *NOT* meant to circumvent buying premium.
# Please do consider switching to premium to support Spotify!
# -----------------------------------------------------------------------

# WARNING: If you use this wrapper please make sure to ALWAYS use it
#          If you start Spotify without it, there's a chance that Spotify will
#          stay muted and will have to be manually be unmuted through pactl

WMTITLE="Spotify - Linux Preview"
COUNTER="0"

# no need to supply full path to executable if
# spotify is in PATH
spotify "$@" > /dev/null 2>&1 &

# wait for spotify to launch
# if spotify not launched after 50 seconds
# exit script
while true; do
  if [[ "$COUNTER" = "10" ]]
    then
        echo "Error: Spotify not found."
        exit 1
  fi
  echo "##Waiting for Spotify##"
  xprop -name "$WMTITLE" WM_ICON_NAME > /dev/null 2>&1
  if [[ "$?" == "0" ]]; then
    break
  fi
  COUNTER=$(( COUNTER + 1 ))
  sleep 5
done

# only launch script if it isn't active already
if [[ -z "$(pgrep spotify-adkill)" ]]
  then
      # no need to supply full path to executable if
      # spotify_adkiller.sh is in PATH
      spotify_adkiller.sh > /dev/null 2>&1 &
fi