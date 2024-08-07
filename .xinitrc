#!/bin/sh
xset r rate 300 50 &
slstatus &
sxhkd &
picom &
xwallpaper --stretch .local/share/void-wall/dwm.jpg &&
exec dwm
