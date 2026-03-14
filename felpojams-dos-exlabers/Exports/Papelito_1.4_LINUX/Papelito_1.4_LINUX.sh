#!/bin/sh
printf '\033c\033]0;%s\a' TGA 2026
base_path="$(dirname "$(realpath "$0")")"
"$base_path/Papelito_1.4_LINUX.x86_64" "$@"
