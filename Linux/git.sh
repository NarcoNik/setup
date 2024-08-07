echo "Installing git & Generate ssh"
echo "######################################################################"
sudo apt-get install -y git git-core git-gui nano openssh-client
sudo ufw allow ssh
cd ~
mkdir -p ~/.ssh
chmod 700 ~/.ssh
chmod 700 ~/.ssh/config
cd ~/.ssh
ssh-keygen -t ed25519 -C "plakidin.vyacheslav@mail.ru"
chmod 600 ~/.ssh/id_ed25519
chmod 600 ~/.ssh/id_ed25519.pub
cd -

bash -c \
'cat << EOF > ~/.ssh/config
Host github.com
    HostName github.com
    User git
    IdentityFile ~/.ssh/id_ed25519
    IdentitiesOnly yes
Host gitlab.i-link.pro
    HostName gitlab.i-link.pro
    IdentityFile ~/.ssh/id_ed25519
    IdentitiesOnly yes
Host digitalocean.com
    HostName 164.90.207.152
    IdentityFile ~/.ssh/id_ed25519
    IdentitiesOnly yes
PasswordAuthentication no
EOF'

eval "$(ssh-agent -s)"
echo $SSH_AGENT_SOCK
ssh-add ~/.ssh/id_ed25519
ssh-add -l
ssh-copy-id -i ~/.ssh/id_ed25519.pub root@164.90.207.152
ssh -T git@github.com

# sudo tee -a /etc/ssh/ssh_config <<< \
# "    ForwardAgent yes
#     PasswordAuthentication no
#     IdentityFile ~/.ssh/id_ed25519
#     IdentitiesOnly yes"

git config --global user.name "Slaweekq"
git config --global user.email "plakidin.vyacheslav@mail.ru"
git config --global --add safe.directory /mnt/D/CRYPTO/setup
git config --global --add safe.directory /mnt/D/CRYPTO/work
git config --global --add safe.directory /mnt/D/CRYPTO/work/old/smartDefi
git config --global --add safe.directory /mnt/D/CRYPTO/work/packages
git config --global --add safe.directory /mnt/D/CRYPTO/work/server
git config --global --add safe.directory /mnt/D/CRYPTO/work/shelfjs-packages
git config --global core.editor code
git config --global core.safecrlf true
git config --global push.autoSetupRemote true
git config --global credential.helper cache
git config --list


# export CACHE_CODE_DIR="blob_storage Cache CachedData CachedExtensionVSIXs CachedProfilesData 'Code Cache' Crashpad DawnCache GPUCache 'Local Storage' logs 'Service Worker' 'Session Storage' User/History User/workspaceStorage Cookies Cookies-journal $HOME/.npm/_cacache $HOME/.npm/_logs $HOME/managed_context $HOME/'Telegram Desktop' $HOME/test_suite_analysis $HOME/.cache $HOME/.nvm/.cache"


tee -a ~/.bashrc <<< \
'
alias si="sudo apt-get install -y"
alias srf="sudo rm -rf"
alias srn="sudo reboot now"
alias srp="sudo apt-get remove --purge -y"
alias sdr="sudo systemctl daemon-reload"
alias supd="sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get install --fix-broken -y && sudo apt-get autoremove && sudo apt-get autoclean -y && flatpak uninstall --unused"
alias cleanCode="cd $HOME/.config/Code/ && rm -rf $CACHE_CODE_DIR && cd -"
alias digcon="ssh root@164.90.207.152"
alias doccon="docker login --password dckr_pat_yJhGjotZbYBJLvQIcRq3P27yChc -u slaweekq"
alias sshcon="eval "$(ssh-agent -s)" && echo $SSH_AGENT_SOCK && ssh-add ~/.ssh/id_ed25519 && ssh -T git@github.com"
alias gpush="git add ./ && git commit -m «new» -a && git push origin"
alias dexec="docker exec -it"
alias dstart="docker-compose -f ./docker-compose.yml up -d"
alias dres="docker-compose down && clear && docker-compose up"
alias dstop="docker-compose -f ./docker-compose.yml down -v && docker-compose -f ./docker-compose.yml rm -sfv"
alias dstopall="docker-compose down --rmi=all -v --remove-orphans"
alias dremig="docker rmi $(docker images -a -q)"
alias dreb="docker-compose -f ./docker-compose.yml down -v && docker-compose -f ./docker-compose.yml rm -sfv && docker-compose -f ./docker-compose.yml up -d"
alias kalistart="docker pull kalilinux/kali-rolling && docker run --tty --interactive kalilinux/kali-rolling"
alias wclone="git clone git@gitlab.i-link.pro:defi-invest/defi-invest-smart-contract.git && cd defi-invest-smart-contract && git checkout dev && git pull && code ."
alias gtext="gnome-text-editor"
alias ogpt="ollama run llama3 --verbose"
alias docker-compose="docker compose"
alias nd="npm i -D"
alias nu="npm uninstall"
alias nats="~/nats"
'

# restore bash_profile
# declare > .bash_profile.recovered
# alias >> .bash_profile.recovered


#### md
# echo "######################################################################"
# add . - add change
# commit -m "Initial Commit" -a - write change
# push - send change
# pull - get change
# git branch dev - create branch developer and don't send changes in master
# then git checkout dev - switch dev branch
# git merge master - transfer master -> dev
# git branch -m new-branch-name old-branch-name - rename branch
# git branch -d - delete branch
# git branch -a - view all branch
# remote add origin git@github.com:NarcoNik/git-test.git - add remote repo
# push --set-upstream origin main - change branch origin/main
# remote - view all remote repo
# remote -v view all remote repo with url
# remote rm <name> - delete remote repo
# remote rename <old-name> <new-name> - rename remote repo
