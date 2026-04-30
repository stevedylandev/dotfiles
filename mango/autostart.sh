#!/bin/bash
waybar -c ~/.config/mango/config.jsonc -s ~/.config/mango/style.css  &
swaybg -i ~/andromeda.png &
swaync &
wl-clip-persist --clipboard regular --reconnect-tries 0 &
wl-paste --watch cliphist store &
