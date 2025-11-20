#!/usr/bin/env bash

# script for gererating a random username and password
# designed for making alternate accounts without repeating
# usernames or passwords

# outputs a username and two passwords:
# password 1 is easier to remember
# password 2 is as safe as possible

# safe password length and allowed characters
SPWLEN=32
ALLOWED='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#%^*_+=-?'

list=""
list="names.txt"

while false
do
	printf "enter wordlist filename: "
	read list

	if [[ -f $list ]]
	then
		echo "using wordlist $list"
		break
	fi

	echo "file '$list' not found"
done

entries=$(cat $list | wc -w)
echo "wordlist has $entries entries"

rand() {
	local max=$1
	random_number=$(od -An -N4 -tu4 /dev/random)
	echo $(( random_number % max ))
}

rand_word() {
	sed -n "$(rand $entries)p" "$list"
}




rand_char()
{
	local idx
	idx=$(rand "${#ALLOWED}")
	echo -n "${ALLOWED:$idx:1}"
}

name=$(
	for i in $(seq 2)
	do
		rand_word
	done | tr -d "\n"
	echo "$(rand 100)"
)

pw1=$(
	for i in $(seq 2)
	do
		rand_word
		echo "$(rand 1000)"
	done | tr -d "\n"
)

pw2=$(
	for i in $(seq $SPWLEN)
	do
		rand_char
	done | tr -d "\n"
)
echo name: $name
echo password 1: $pw1
echo password 2: $pw2
