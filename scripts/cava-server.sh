#! /bin/bash

pipe="/tmp/cava.fifo"

if [ -p $pipe ]; then
	unlink $pipe
fi
mkfifo $pipe

config_file="/tmp/waybar_cava_config"
echo "
[general]
bars = 22
framerate = 15
sleep_timer = 3
[input]
sample_rate = 44100
sample_bits = 8
channels = 1
autoconnect = 2
[output]
method = raw
raw_target = $pipe
data_format = ascii
ascii_max_range = 7
" > $config_file

killall -q cava

exec cava -p $config_file
