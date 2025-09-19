#!/bin/sh

last_state=""

while true
do
	current_state="$(xset -q | grep 'Caps Lock' | awk '{print $4}')"

	if [[ "$current_state" != "$last_state" ]]
	then
		if [[ "$current_state" == "on" ]]
		then
			echo "CAPS LOCK"
		else
			echo "caps lock"
		fi

		last_state="$current_state"
	fi

	sleep 0.2
done
