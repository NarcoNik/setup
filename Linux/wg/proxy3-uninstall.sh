# for deleting proxy3
sudo systemctl stop 3proxy.service \
  && sudo rm /etc/systemd/system/3proxy.service \
  && sudo rm -rf /etc/3proxy \
  && sudo rm /usr/bin/3proxy \
  && sudo systemctl daemon-reload

  # && sudo rm -rf /var/log/3proxy \
