#!/usr/bin/env bash

compress() {
	local file="$1"
	local size="$2"

	local size_bytes
	case "$size" in
		*[Kk]) size_bytes=$(( ${size%[Kk]} * 1024 )) ;;
		*[Mm]) size_bytes=$(( ${size%[Mm]} * 1024 * 1024 )) ;;
		*[Gg]) size_bytes=$(( ${size%[Gg]} * 1024 * 1024 * 1024 )) ;;
		*) size_bytes="$size" ;;
	esac

	local duration
	duration=$(ffprobe -v error -select_streams v:0 -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "$file")
	duration=${duration%.*}

	if [[ -z "$duration" || "$duration" -le 0 ]]; then
		echo 0 duration, exiting
		return 1
	fi

	local audio_bitrate=128000
	local video_bitrate=$(( (size_bytes * 8 / duration) - audio_bitrate ))
	local video_bitrate=$(( video_bitrate * 10 / 11 ))
	if [[ "$video_bitrate" -le 0 ]]; then
		echo 0 video bitrate, exiting
		return 1
	fi

	local base="$(basename "$file")"
	local name="${base%.*}"
	local output="${name}-com.mp4"

	ffmpeg -v error -y -i "$file" -c:v libx265 -b:v "${video_bitrate}" -c:a aac -b:a 128k "$output"
}

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
	compress "$@"
fi
