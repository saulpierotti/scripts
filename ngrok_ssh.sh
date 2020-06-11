#!/bin/bash

sudo systemctl start sshd
ngrok tcp 22
sudo systemctl stop sshd
