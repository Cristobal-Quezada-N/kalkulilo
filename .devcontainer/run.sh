#!/usr/bin/env bash

volume_flag=""
enviroment_flag=""

case $XDG_SESSION_TYPE in
"wayland")
	enviroment_flag="XDG_RUNTIME_DIR=/tmp/xdg-runtime -e WAYLAND_DISPLAY=$WAYLAND_DISPLAY"
	volume_flag="$XDG_RUNTIME_DIR/$WAYLAND_DISPLAY:/tmp/xdg-runtime/$WAYLAND_DISPLAY"
	;;
"x11")
	enviroment_flag="DISPLAY=$DISPLAY"
	volume_flag="/tmp/.X11-unix:/tmp/.X11-unix:ro"
	;;
*)
	echo "invalid session type (XDG_SESSION_TYPE): $XDG_SESSION_TYPE"
	exit 1
	;;
esac

docker run -e $enviroment_flag -v $volume_flag -d -p 1234:1234 -it flutter-env:latest
