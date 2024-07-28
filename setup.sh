#!/bin/bash

# clone repo and save path as variable
git clone https://github.com/danihek/yt-local
cd yt-local
path="$(pwd)"
echo "[INFO]: PATH: $path"

# python stuff
echo "[INFO]: Setting up python environment..."
python3 -m venv env
source env/bin/activate
echo "[INFO]: Installing requirements..."
pip3 install -r requirements.txt

# add path to systemd service template
echo "[INFO]: Generating a systemd service..."
cd ..
cp yt-local.service.template yt-local.service
echo "ExecStart=/usr/bin/python3 $path" >> yt-local.service

# install systemd service
echo "[INFO]: Installing systemd service..."
sudo cp yt-local.service /etc/systemd/system/
sudo systemctl enable yt-local.service
sudo systemctl start yt-local.service
