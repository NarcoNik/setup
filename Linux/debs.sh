# Download the packages file
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys B05498B7
wget https://github.com/PowerShell/PowerShell/releases/download/v7.4.0/powershell_7.4.0-1.deb_amd64.deb
wget https://dl.discordapp.net/apps/linux/0.0.39/discord-0.0.39.deb
wget https://github.com/shiftkey/desktop/releases/download/release-3.1.1-linux1/GitHubDesktop-linux-3.1.1-linux1.deb
wget https://download.anydesk.com/linux/anydesk_6.1.1-1_amd64.deb
wget https://github.com/lutris/lutris/releases/download/v0.5.14/lutris_0.5.14_all.deb
wget https://repo.steampowered.com/steam/archive/precise/steam_latest-stable.deb

# Install packages
sudo apt -y install ./powershell_7.4.0-1.deb_amd64.deb ./discord-0.0.39.deb \
  ./GitHubDesktop-linux-3.1.1-linux1.deb ./anydesk_6.1.1-1_amd64.deb \
  ./lutris_0.5.14_all.deb ./steam_latest-stable.deb
sudo apt -y --fix-broken install
sudo apt install -f
sudo systemctl daemon-reload
# Remove packages
sudo rm -rf powershell_7.4.0-1.deb_amd64.deb
sudo rm -rf discord-0.0.39.deb
sudo rm -rf GitHubDesktop-linux-3.1.1-linux1.deb
sudo rm -rf anydesk_6.1.1-1_amd64.deb
sudo rm -rf lutris_0.5.14_all.deb
sudo rm -rf steam_latest-stable.deb
