echo 'Installing Bluetooth Audio for AirPods'
echo '#################################################################'
# sudo apt -y install 'bluez*' blueman
modprobe btusb
sudo tee -a /etc/bluetooth/main.conf <<< \
"
ControllerMode = bredr
"
sudo /etc/init.d/bluetooth restart
sudo systemctl restart bluetooth

sudo add-apt-repository -y ppa:pipewire-debian/pipewire-upstream
sudo apt update
sudo apt -y install \
  pulseaudio-utils pipewire pipewire-pulse pipewire-tests libspa-0.2-jack \
  gstreamer1.0-pipewire libspa-0.2-bluetooth libspa-0.2-jack \
  pipewire-audio-client-libraries
sudo systemctl disable --global pulseaudio
sudo systemctl enable --global pipewire-pulse
pactl info | grep "Server Name"
