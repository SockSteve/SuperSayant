#!/bin/sh
echo -ne '\033c\033]0;LD56\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/SuperSayant V1.x86_64" "$@"
