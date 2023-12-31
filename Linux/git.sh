echo "Installing git & Generate ssh"
echo "######################################################################"
sudo apt -y install git git-core git-gui nano openssh-client
sudo ufw allow ssh
cd ~
mkdir -p ~/.ssh
chmod 700 ~/.ssh
cd ~/.ssh
ssh-keygen -t ed25519 -C "plakidin.vyacheslav@mail.ru"
chmod 600 ~/.ssh/slaweekq
chmod 600 ~/.ssh/slaweekq.pub

tee -a ~/.ssh/config <<< \
"Host github.com
    HostName github.com
    User git
    IdentityFile ~/.ssh/slaweekq
    IdentitiesOnly yes
Host gitlab.i-link.pro
    HostName gitlab.i-link.pro
    IdentityFile ~/.ssh/slaweekq
    IdentitiesOnly yes
Host digitalocean.com
    HostName digitalocean.com
    IdentityFile ~/.ssh/slaweekq
    IdentitiesOnly yes
PasswordAuthentication no"

eval "$(ssh-agent -s)"
echo $SSH_AGENT_SOCK
ssh-add ~/.ssh/slaweekq
ssh-add -l
ssh -T git@github.com

# sudo tee -a /etc/ssh/ssh_config <<< \
# "    ForwardAgent yes
#     PasswordAuthentication no
#     IdentityFile ~/.ssh/slaweekq
#     IdentitiesOnly yes"

git config --global user.name "Slaweekq" \
 && git config --global user.email "plakidin.vyacheslav@mail.ru" \
 && git config --global --add safe.directory /mnt/Documents/CRYPTO/docker-info \
 && git config --global --add safe.directory /mnt/Documents/CRYPTO/hardhat \
 && git config --global --add safe.directory /mnt/Documents/CRYPTO/setup \
 && git config --global --add safe.directory /mnt/Documents/CRYPTO/work \
 && git config --global --add safe.directory /mnt/Documents/CRYPTO/defi-invest-smart-contract \
 && git config --global core.editor code \
 && git config --global core.safecrlf true \
 && git config --global push.autoSetupRemote true \
 && git config --global credential.helper cache \
 && git config --list

tee -a ~/.bashrc <<< \
'
alias si="sudo apt -y install"
alias srp="sudo apt -y remove --purge"
alias sdr="sudo systemctl daemon-reload"
alias supd="sudo apt update && sudo apt -y upgrade && sudo apt -y --fix-broken install && sudo apt -y autoclean && sudo apt -y autoremove --purge"
alias digcon="ssh plaki@188.166.12.166"
alias doccon="docker login --password dckr_pat_yJhGjotZbYBJLvQIcRq3P27yChc -u slaweekq"
alias sshcon="eval "$(ssh-agent -s)" && echo $SSH_AGENT_SOCK && ssh-add ~/.ssh/slaweekq && ssh -T git@github.com"
alias gpush="git add ./ && git commit -m «new» -a && git push origin"
# alias docker-compose="docker compose"
alias dexec="docker exec -it"
alias dstart="docker-compose -f ./docker-compose.yml up -d"
alias dres="docker-compose down && clear && docker-compose up"
alias dstop="docker-compose -f ./docker-compose.yml down -v && docker-compose -f ./docker-compose.yml rm -sfv"
alias dstopall="docker-compose down --rmi=all -v --remove-orphans && docker rmi $(docker images -a -q)"
alias dreb="docker-compose -f ./docker-compose.yml down -v && docker-compose -f ./docker-compose.yml rm -sfv && docker-compose -f ./docker-compose.yml up -d"
alias kalistart="docker pull kalilinux/kali-rolling && docker run --tty --interactive kalilinux/kali-rolling"
alias project="cd /mnt/Documents/CRYPTO && ls -lf"
alias wclone="git clone git@gitlab.i-link.pro:defi-invest/defi-invest-smart-contract.git && cd defi-invest-smart-contract && git checkout dev && git pull && code ."'

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
