echo "Installing git"
sudo apt install -y git git-core git-gui
git --version

echo "generate ssh"
echo "#################################################################################"
cd ~ \
  && mkdir ./.ssh \
  && cd ~/.ssh \
  && ssh-keygen -C "plakidin.vyacheslav@mail.ru"

eval "$(ssh-agent -s)" \
  && ssh-add ~/.ssh/slaweekq \
  && ssh -T git@github.com

git config --global user.name "Slaweekq" \
 && git config --global user.email "plakidin.vyacheslav@mail.ru" \
 && git config --global --add safe.directory /mnt/Documents/Nelly/nelly-bot \
 && git config --global --add safe.directory /mnt/Documents/CRYPTO/contract \
 && git config --global --add safe.directory /mnt/Documents/CRYPTO/cpp \
 && git config --global --add safe.directory /mnt/Documents/CRYPTO/hardhat \
 && git config --global --add safe.directory /mnt/Documents/CRYPTO/hash \
 && git config --global --add safe.directory /mnt/Documents/CRYPTO/project \
 && git config --global --add safe.directory /mnt/Documents/CRYPTO/setup \
 && git config --global --add safe.directory /mnt/Documents/CRYPTO/websites \
 && git config --global core.editor kate \
 && git config --global core.safecrlf true \
 && git config --global push.autoSetupRemote true \
 && git config --list


# kate ~/.bashrc
# alias sshcon='eval "$(ssh-agent -s)" && ssh-add ~/.ssh/slaweekq && ssh -T git@github.com'
# alias gpush='ssh-add ~/.ssh/slaweekq && git add . && git commit -m «new» -a && git push origin'
# alias docon='ssh plaki@64.227.69.234'

# cd ~/.ssh && kate slaweekq.pub

#### git create
#################################################################################
# cd && mkdir git-test && cd ./git-test && git init
# git clone git@github.com:NarcoNik/git-test.git

# ssh-add ~/.ssh/GitHub && git add . && git commit -m «new» -a && git push origin
# git remote add origin git@github.com:NarcoNik/git-test.git
# git push --set-upstream origin main


#### md
#################################################################################
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
