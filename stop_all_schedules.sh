#!/bin/bash
systemctl stop 'cronie.service' # timeshift is scheduled as a hourly cron job
xscreensaver_awake.sh
