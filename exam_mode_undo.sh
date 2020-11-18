#!/bin/bash
sudo systemctl start 'cronie.service' # timeshift is scheduled as a hourly cron job
xautolock -enable
