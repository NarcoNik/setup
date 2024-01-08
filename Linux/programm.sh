echo 'Install programm'
echo '#################################################################'
sudo add-apt-repository -y ppa:danielrichter2007/grub-customizer
sudo add-apt-repository -y ppa:atareao/telegram
sudo add-apt-repository -y ppa:ethereum/ethereum
sudo add-apt-repository -y multiverse
# Adding keys
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/packages.microsoft.gpg
sudo wget -O /etc/apt/trusted.gpg.d/winehq.key https://dl.winehq.org/wine-builds/winehq.key
# wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
# Adding repos
sudo echo "deb [signed-by=/etc/apt/trusted.gpg.d/winehq.key] https://dl.winehq.org/wine-builds/ubuntu $(lsb_release -cs) main" | \
  sudo tee /etc/apt/sources.list.d/winehq.list > /dev/null

sudo echo "deb [arch=$(dpkg --print-architecture)] https://packages.microsoft.com/repos/code stable main" |\
  sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null

sudo echo "deb [arch=$(dpkg --print-architecture)] https://packages.microsoft.com/repos/edge stable main" |\
  sudo tee /etc/apt/sources.list.d/microsoft-edge.list > /dev/null
# sudo sh -c '# "deb [arch=amd64] https://packages.microsoft.com/repos/edge stable main" >> /etc/apt/sources.list.d/microsoft-edge.list'
# sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'

sudo rm -rf packages.microsoft.gpg
sudo rm -rf microsoft.gpg
# installing
sudo apt update
sudo apt -y upgrade
sudo dpkg --add-architecture amd64
sudo dpkg --add-architecture i386
sudo apt update
sudo apt -y install --install-recommends winehq-stable
# wine winecfg
# sudo apt -y install google-chrome-stable
sudo apt -y install grub-customizer solc ethereum telegram code \
  microsoft-edge-stable libgl1-mesa-dri:amd64 libgl1-mesa-dri:i386 \
  libgl1-mesa-glx:amd64 libgl1-mesa-glx:i386
sudo apt -y --fix-broken install
# Options for shell in vscode
source /etc/X11/xinit/xinitrc.d/50-systemd-user.sh
eval $(/usr/bin/gnome-keyring-daemon --start)
export SSH_AUTH_SOCK
mkdir -p "$HOME"/.local/share/trusted.gpg.d
code --locate-shell-integration-path bash
[[ "$TERM_PROGRAM" == "vscode" ]] && . "/path/to/shell/integration/script.sh"

flatpak install flathub org.gnome.Maps

echo 'All programm installed'
echo '#################################################################'
