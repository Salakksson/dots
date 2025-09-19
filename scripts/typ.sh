#!/usr/bin/env bash

shopt -s nullglob

if ! command -v zathura >/dev/null 2>&1
then
	echo "zathura isnt installed on the system"
fi

if ! command -v typst >/dev/null 2>&1
then
	echo "typst isnt installed on the system"
fi

if [[ $# != 1 ]]
then
	docs=( *.typ )
	n_docs=${#docs[@]}
	case $n_docs in
	0)
		echo "no typst document in current directory"
		exit 1
	;;
	1)
		echo "chose typst document $docs"
		input=$docs
	;;
	*)
		echo "choose typst document to open:"
		declare -A arr
		i=1
		for doc in "${docs[@]}"
		do
			arr[$i]="$doc"
			echo "$i: $doc"
			i=$((++i))
		done
		printf "index: "
		read option
		if [[ ! -v arr[$option] ]]
		then
			echo "invalid index"
		fi
		doc=${arr[$option]}
		echo "chose typst document $doc"
		input=$doc
	;;
	esac
else
	input=$1
fi

typ="$input"
if [[ "$typ" != *.typ ]]
then
	typ="$input".typ
fi

pdf=${typ/.typ/.pdf}

echo "using typ: $typ"
echo "using pdf: $pdf"

printf "correct? (Y/n): "
read confirm

case $confirm in
	[nN]*) exit ;;
	*) break ;;
esac

touch $pdf
echo "running zathura"
zathura $pdf & disown

echo "running typst watch"
typst watch $typ
