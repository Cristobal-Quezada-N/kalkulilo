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

image_name="flutter-env"
project_dir_path=$(
	cd "$(dirname "$0")"/..
	pwd -P
)

args=("$@")
build_extra_flags=()
run_extra_flags=()
tmp_flags=()

for arg in "${args[@]}"; do
	if [ "$arg" == "--build" ]; then
		run_extra_flags="${tmp_flags[@]}"
		tmp_flags=()
	elif [ "$arg" == "--run" ]; then
		build_extra_flags="${tmp_flags[@]}"
		tmp_flags=()
	else
		tmp_flags+=("$arg")
	fi
done

case "${args[0]}" in
"--run")
	if [ -z "${run_extra_flags[@]}" ] && [ -z "${build_extra_flags[@]}" ]; then
		run_extra_flags="${tmp_flags[@]}"
	else
		build_extra_flags="${tmp_flags[@]}"
	fi
	;;
"--build")
	if [ -z "${run_extra_flags[@]}" ] && [ -z "${build_extra_flags[@]}" ]; then
		build_extra_flags="${tmp_flags[@]}"
	else
		run_extra_flags="${tmp_flags[@]}"
	fi
	;;
"")
	true
	;;
*)
	echo "invalid options: $@"
	echo "available commands are --build and --run"
	exit 1
	;;
esac

echo -e "build $image_name image\n"
docker build $build_extra_flags $project_dir_path/.devcontainer/ -t $image_name || exit 1

container_name="$image_name-$RANDOM"
docker run $run_extra_flags --name $container_name -e $enviroment_flag -v $volume_flag -v $project_dir_path:/home/debian/kalkulilo -p 1234:1234 -d -it $image_name >/dev/null || exit 1

echo -e "\ncontainer $container_name created from $image_name image"
