#!/bin/bash

workspaces=({1..9} {A..Z})

printf -v aerospace_script '%q ' /bin/bash "$PLUGIN_DIR/aerospace.sh" "${workspaces[@]}"

args=(--add event aerospace_update)

for sid in "${workspaces[@]}"; do
  args+=(
    --add item "workspace.$sid" left
    --set "workspace.$sid"
    drawing=off
    updates=off
    icon="$sid"
    icon.padding_left=7
    icon.padding_right=7
    label=""
    label.drawing=off
    label.font="sketchybar-app-font:Regular:16.0"
    label.padding_left=0
    label.padding_right=7
    background.color=0x40ffffff
    background.corner_radius=5
    background.height=25
    background.drawing=off
    click_script="aerospace workspace '$sid'"
  )
done

args+=(
  --add item chevron left
  --set chevron
  icon=
  label.drawing=off

  --add item aerospace left
  --set aerospace
  drawing=off
  updates=on
  update_freq=0
  script="$aerospace_script"
  --subscribe aerospace
  aerospace_update
  space_windows_change
  system_woke
)

sketchybar "${args[@]}"
