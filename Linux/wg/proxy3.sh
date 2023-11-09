version=0.9.3
echo "Installing proxy3"
echo "####################################################################################"

sudo apt -y update \
  && sudo apt -y upgrade \
  && sudo apt install wget curl gcc make git -y

echo "Download and unpack the sources"
cd ~ && sudo wget --no-check-certificate -O 3proxy-${version}.tar.gz https://github.com/z3APA3A/3proxy/archive/${version}.tar.gz

tar xzf 3proxy-${version}.tar.gz \
  && cd ~/3proxy-${version}

echo "Compiling"
sudo make -f Makefile.Linux

echo "Installing"
sudo mkdir /etc/3proxy \
  && cd ~/3proxy-0.9.3/bin \
  && sudo cp 3proxy /usr/bin/ \
  && cd /etc/3proxy/

sudo wget --no-check-certificate https://github.com/SnoyIatk/3proxy/raw/master/3proxy.cfg
sudo chmod 600 /etc/3proxy/3proxy.cfg
sudo mkdir /var/log/3proxy/
sudo wget --no-check-certificate https://github.com/SnoyIatk/3proxy/raw/master/.proxyauth
sudo chmod 600 /etc/3proxy/.proxyauth
cd /etc/init.d/
sudo wget --no-check-certificate  https://raw.github.com/SnoyIatk/3proxy/master/3proxy
sudo chmod  +x /etc/init.d/3proxy
sudo update-rc.d 3proxy defaults
echo "Deleting temporery files"
sudo rm ~/3proxy-${version}.tar.gz \
  && sudo rm -r ~/3proxy-${version} \
  && cd ~




# sudo adduser --system --no-create-home --disabled-login --group proxy3 && id proxy3

# # uid=113(proxy3) gid=121(proxy3) groups=121(proxy3)
# echo "Creating config file"
# sudo bash -c \
# "cat << EOF > /etc/3proxy/3proxy.cfg
# setgid 117
# setuid 110
# #
# # Пропишите правильные серверы имен посмотрев их
# # на своем сервере в /etc/resolv.conf
# nserver 127.0.0.53
# nscache 65536
# timeouts 1 5 30 60 180 1800 15 60
# #
# # Если несколько IP на одном сервере, указываем тот,
# # через который будем ходить во внешний мир.
# # Иначе эту строку игнорируем
# #external <YOURSERVERIP>
# # Тоже самое, только указываем IP, который надо слушать
# # Если проигнорировать, то прокси слушает все адреса на сервере
# #internal <YOURSERVERIP>
# users $/etc/3proxy/.proxyauth
# daemon
# auth cache strong
# #
# # Запускаем анонимный (-a) HTTP-proxy на порту (-p) 3128 и
# # c отключенной NTLM-авторизацией (-n)
# proxy -n -p3128 -a
# EOF"

# echo "settings & example
# sudo nano /etc/3proxy/3proxy.cfg
# nano ~/3proxy-0.9.3/cfg/3proxy.cfg.sample
# ~/3proxy-0.9.3/doc/ru/example1.txt"

# echo "Creating proxy authentication"
# sudo bash -c \
# "cat << EOF > /etc/3proxy/.proxyauth
# ## addusers in this format:
# #user:CL:password
# ##see for documentation: http://www.3proxy.ru/howtoe.asp#USERS
# proxy3:CL:88C1mgzd1Q
# EOF"

# echo "Setting access rights to proxy server files"
# sudo chown proxy3:proxy3 -R /etc/3proxy \
#   && sudo chown proxy3:proxy3 /usr/bin/3proxy \
#   && sudo chmod 444 /etc/3proxy/3proxy.cfg \
#   && sudo chmod 400 /etc/3proxy/.proxyauth

# echo "Add to startup and start the proxy server"
# sudo bash -c \
# "cat << EOF > /etc/systemd/system/3proxy.service
# [Unit]
# Description=3proxy Proxy Server
# After=network.target


# [Service]
# Type=simple
# ExecStart=/usr/bin/3proxy /etc/3proxy/3proxy.cfg
# ExecStop=/bin/kill `/usr/bin/pgrep -u proxy3`
# RemainAfterExit=yes
# Restart=on-failure

# [Install]
# WantedBy=multi-user.target
# EOF"

# echo "example nano ~/3proxy-0.9.3/scripts/3proxy.service"

# sudo systemctl daemon-reload \
#   && sudo systemctl enable 3proxy \
#   && sudo systemctl start 3proxy \
#   && sudo ps -ela | grep "3proxy"
#   # && sudo systemctl status 3proxy.service \

# echo "Oppening port 3128"
# sudo iptables -I INPUT -p tcp -m tcp --dport 3128 -j ACCEPT
# # sudo ufw allow 3128/tcp \
# #   && sudo ufw enable

# echo "Deleting temporery files"
# sudo rm ~/0.9.3.tar.gz \
#   && sudo rm -r ~/3proxy-0.9.3 \
#   && cd ~

# for deleting proxy3
# sudo systemctl stop 3proxy.service \
#   && sudo rm /etc/systemd/system/3proxy.service \
#   && sudo rm -rf /etc/3proxy \
#   && sudo rm -rf /var/log/3proxy \
#   && sudo rm /usr/bin/3proxy \
#   && sudo systemctl daemon-reload
