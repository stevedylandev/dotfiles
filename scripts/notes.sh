#!/usr/bin/env bash

folder="$HOME/notes"

mkdir -p "$folder"

# BusyBox setsid has no -f; background with & instead.
launch () {
  setsid "$term" -e nvim "$1" >/dev/null 2>&1 &
}

: "${TERMINAL:=st}"
term="$(command -v "$TERMINAL")" || {
  echo "notes: terminal '$TERMINAL' not found" >&2
  exit 1
}

newnote () { \
  dir="$(find "$folder" -type d | sort | dmenu -c -l 5 -i -p 'Choose directory: ')" || exit 0
  : "${dir:=$folder}"
  name="$(echo "" | dmenu -c -sb "#a3be8c" -nf "#d8dee9" -p "Enter a name: " <&-)" || exit 0
  : "${name:=$(date +%F_%H-%M-%S)}"
  launch "${dir%/}/${name}.md"
}

selected () { \
  choice=$(
    { echo "New"
      find "$folder" -type f -name '*.md' -exec stat -c '%Y %n' {} + 2>/dev/null \
        | sort -nr | cut -d' ' -f2- | sed "s|^$folder/||"
    } | dmenu -c -l 5 -i -p "Choose note or create new: "
  )
  case $choice in
    New) newnote ;;
    *.md) launch "$folder/$choice" ;;
    *) exit ;;
  esac
}

selected
