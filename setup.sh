sudo apt update
sudo apt-get install fswebcam python3-pip
sudo pip3 install requests pondslider error_counter
#sudo apt-get install curl
git clone https://github.com/UedaTakeyuki/handlers.git
ln -s handlers/sensor/uvc/uvc_photo.py
cp handlers/sensor/uvc/uvc_photo.ini .
cp handlers/sensor/uvc/config.toml .

