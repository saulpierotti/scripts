import os
import sys

my_input = sys.argv[1]
cmd_vol_up = "pamixer -i 1; pamixer -u"
cmd_vol_down = "pamixer -d 1; pamixer -u"
cmd_mute_toggle = "pamixer -t"

if my_input == "up":
    os.system(cmd_vol_up)
elif my_input == "down":
    os.system(cmd_vol_down)
elif my_input == "mute":
    os.system(cmd_mute_toggle)
