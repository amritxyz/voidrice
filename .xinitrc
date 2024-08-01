#!/bin/sh
xset r rate 300 50 &
slstatus &
sxhkd &
picom &
xwallpaper --stretch .local/share/wall/dwm.jpg &&
exec dwm
