#!/bin/sh
printf '\033c\033]0;%s\a' Felpojams_dos_Exlabers
base_path="$(dirname "$(realpath "$0")")"
"$base_path/Felpojam_beta_0.4_linux.x86_64" "$@"
