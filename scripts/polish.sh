#!/usr/bin/env bash

input="$(cat "${1:-/dev/stdin}")"

output="$(echo "$input" | sed -E \
    -e 's/sz/ш/g' \
    -e 's/cz/ч/g' \
    -e 's/ch/х/g' \
    -e 's/ja/я/g' \
    -e 's/ju/ю/g' \
    -e 's/je/е/g' \
    -e 's/ję/ен/g' \
    -e 's/ją/ён/g' \
    -e 's/ł/l/g' \
    -e 's/ń/нь/g' \
    -e 's/ś/сь/g' \
    -e 's/ć/ч/g' \
    -e 's/ź/зь/g' \
    -e 's/ż/ж/g' \
    -e 's/rz/ж/g' \
    -e 's/dz/дз/g' \
    -e 's/dź/дзь/g' \
    -e 's/dż/дж/g' \
    \
    -e 's/a/а/g' \
    -e 's/b/б/g' \
    -e 's/c/ц/g' \
    -e 's/d/д/g' \
    -e 's/e/е/g' \
    -e 's/f/ф/g' \
    -e 's/g/г/g' \
    -e 's/h/х/g' \
    -e 's/i/и/g' \
    -e 's/j/й/g' \
    -e 's/k/к/g' \
    -e 's/l/л/g' \
    -e 's/m/м/g' \
    -e 's/n/н/g' \
    -e 's/o/о/g' \
    -e 's/p/п/g' \
    -e 's/q/к/g' \
    -e 's/r/р/g' \
    -e 's/s/с/g' \
    -e 's/t/т/g' \
    -e 's/u/у/g' \
    -e 's/v/в/g' \
    -e 's/w/в/g' \
    -e 's/x/кс/g' \
    -e 's/y/ы/g' \
    -e 's/z/з/g')"

echo "$output"
