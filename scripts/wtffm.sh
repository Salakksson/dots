#!/usr/bin/env bash

shopt -s dotglob

while true
do
	ROWS=$(tput lines)
	newdir="."
	FZF_ARGS=""
	FZF_ARGS+=" --border"
	FZF_ARGS+=" --footer-label=$PWD"
	select=$(printf '%s\n' . .. */ | sort | fzf $FZF_ARGS)

	if [[ "$select" == "." || ! -e "$select" ]]
	then
		exit
	fi

	if [[ "$select" == ".." ]]
	then
		cd ..
		continue
	fi

	printf "(Cd/cP/Mv/Rm)? "
	read ans
	cmd=""
	addargs=false
	case "$ans" in
	[Pp]*)
		cmd="cp"
		addargs=true
		;;
	[Mm]*)
		cmd="mv"
		addargs=true
		;;
	[Cc]*)
		cmd="cd"
		addargs=false
		;;
	[Rr]*)
		cmd="rm -fr"
		addargs=false
		;;
	*)
		cmd="echo"
		;;
	esac

	arg=""
	args=("$select")

	if $addargs
	then
		read arg
		args+=("$arg")
	fi

	# echo $cmd "$select" "${args[@]}" "(y/N)"
	# read confirm
	if [[ "$confirm" != "yes" ]]
	then
		$cmd "$select" "${args[@]}"
	fi
	# read
done
