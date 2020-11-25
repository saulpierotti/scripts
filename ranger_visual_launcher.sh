#!/bin/bash
# this script is called by the ranger .desktop file
# by sourcing condainit, it allows to change conda env inside
# vim, when called from ranger
source /home/saul/.condainit
ranger $RANGER_START
