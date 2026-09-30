#!/bin/bash

set -o pipefail

[ "$#" -gt 0 ] || exit 0

source "$CONFIG_DIR/plugins/icon_map.sh" || exit 1

workspace_info="$(aerospace list-workspaces --all --format '%{workspace}%{tab}%{workspace-is-focused}')" || exit 1

[ -n "$workspace_info" ] || exit 0

window_info="$(aerospace list-windows --all --format '%{workspace}%{tab}%{app-name}' | LC_ALL=C sort -u)" || exit 1

args=()

for sid in "$@"; do
  drawing=off
  background=off
  label_drawing=off
  icons=""

  while IFS=$'\t' read -r workspace focused; do
    [ "$workspace" = "$sid" ] || continue

    drawing=on
    [ "$focused" = true ] && background=on
    break
  done <<<"$workspace_info"

  if [ "$drawing" = on ]; then
    while IFS=$'\t' read -r workspace app; do
      [ "$workspace" = "$sid" ] || continue
      [ -n "$app" ] || continue

      __icon_map "$app"
      icons+="${icons:+ }$icon_result"
    done <<<"$window_info"

    [ -n "$icons" ] && label_drawing=on
  fi

  args+=(
    --set "workspace.$sid"
    drawing="$drawing"
    background.drawing="$background"
    label="$icons"
    label.drawing="$label_drawing"
  )
done

sketchybar "${args[@]}"
