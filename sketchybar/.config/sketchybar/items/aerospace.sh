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
    icon.font="$FONT_FACE:Bold:12.0"
    icon.padding_left=7
    icon.padding_right=5
    label=""
    label.drawing=off
    label.font="sketchybar-app-font:Regular:12.0"
    label.y_offset=-1
    label.padding_left=2
    label.padding_right=5
    background.color="$BACKGROUND_3"
    background.corner_radius=5
    background.height=20
    background.drawing=off
    click_script="aerospace workspace '$sid'"
  )
done

args+=(
  --add bracket workspaces '/^workspace\..*/'
  --set workspaces
  background.drawing=on
  background.color="$BACKGROUND_4"
  background.border_color="$BACKGROUND_5"
  background.border_width=2
  background.corner_radius=8
  background.height=30
  background.padding_left=4
  background.padding_right=4
)

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
