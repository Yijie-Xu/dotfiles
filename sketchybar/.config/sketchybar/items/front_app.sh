#!/bin/bash

front_app=(
  icon.font="sketchybar-app-font:Regular:17.0"
  label.font="$FONT_FACE:SemiBold:14.0"
  script="$PLUGIN_DIR/front_app.sh"
  icon.padding_left=7
  icon.padding_right=7
  label.padding_left=7
  label.padding_right=7
  icon.y_offset=-0.5
)

sketchybar --add item front_app left \
  --set front_app "${front_app[@]}" \
  --subscribe front_app front_app_switched
