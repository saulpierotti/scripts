#!/bin/bash
sudo systemctl stop 'cronie.service' # timeshift is scheduled as a hourly cron job
xset s off
xset -dpms
