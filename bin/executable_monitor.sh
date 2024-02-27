#!/bin/bash

if [ "$#" -eq 0 ]; then
	echo "Usage: $0 <command_to_monitor> [arg1] [arg2] [...]"
	exit 1
fi

command_to_monitor=("$@")

while true; do
	result=$("${command_to_monitor[@]}")
	timestamp=$(date +"%Y-%m-%d %H:%M:%S")

	if [ "$result" != "$prev_result" ]; then
		printf "\e[1;34m%s\e[0m ------------ \n%s\n" "$timestamp" "$result"
		prev_result="$result"
	fi

	sleep 1
done
