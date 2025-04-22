#! /bin/bash

# bar="▁▂▃▄▅▆▇█"		# For default fonts
bar="abdcefgh"		# For my custom font

pipe="/tmp/cava.fifo"
dict="s/;//g;"

i=0
while [ $i -lt ${#bar} ]
do
	dict="${dict}s/$i/${bar:$i:1}/g;"
	i=$((i=i+1))
done

while [ ! -p "$pipe" ]; do
	sleep 0.1
done

while read -r cmd; do
	echo $cmd | sed $dict
done < $pipe
