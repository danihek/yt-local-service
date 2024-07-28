#!/bin/bash

echo "[INFO]: Uninstalling yt-local..."
sudo systemctl stop yt-local.service
sudo systemctl disable yt-local.service
sudo rm /etc/systemd/system/yt-local.service
sudo systemctl daemon-reload
sudo rm -rf yt-local
rm yt-local.service
