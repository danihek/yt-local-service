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

# creating starting script in /usr/bin/
echo "[INFO]: Creating starting script..."
echo "#!/bin/bash" > yt-local-start.sh
echo "cd $path" >> yt-local-start.sh
echo "source env/bin/activate" >> yt-local-start.sh
echo "python3 server.py" >> yt-local-start.sh
sudo chmod +x yt-local-start.sh
sudo cp yt-local-start.sh /usr/bin/

# install systemd service
cd ..
echo "[INFO]: Installing systemd service..."
sudo cp yt-local.service /etc/systemd/system/
sudo systemctl enable yt-local.service
sudo systemctl start yt-local.service

# done!
echo "[INFO]: Done! You can now open your yt-local here: http://127.0.0.1:9010"
