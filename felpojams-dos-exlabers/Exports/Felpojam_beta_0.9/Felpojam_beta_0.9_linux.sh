#!/bin/sh
printf '\033c\033]0;%s\a' TGA 2026
base_path="$(dirname "$(realpath "$0")")"
"$base_path/Felpojam_beta_0.9_linux.x86_64" "$@"
