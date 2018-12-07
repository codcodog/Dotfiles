#!/bin/sh
if xrandr | grep -q '^DP1 connected'; then
  xrandr --output VIRTUAL1 --off --output DP1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output eDP1 --off --output DP2 --off
fi
