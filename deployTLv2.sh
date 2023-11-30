#!/bin/bash



RUBY_VERSION=3.0.0

SCRIPT_USER=$SUDO_USER

TL_BRANCH=master

CURRENT_PATH=$(pwd)



# Checking if script running with sudo

if [[ $(id -u) -ne 0 ]]

    then echo "Please run with sudo ..."

    exit 1

fi



if [ "$SUDO_USER" = "root" ]; then

  echo "Cant be run as root User, Exiting..."

  exit 1

  

else 

  echo "All dandy "$SUDO_USER "ON" $CURRENT_PATH

fi



echo 'Well, here we go! Running the script...'





sudo apt update

sudo apt install -y build-essential libssl-dev zlib1g-dev git
sudo apt-get install -y libcurl4-openssl-dev ruby-dev

sudo apt autoremove -y



cd /home/"$SCRIPT_USER"



echo "Rbenv Install Path "$(pwd)



git clone http://github.com/rbenv/rbenv.git .rbenv

git clone https://github.com/rbenv/rbenv-vars.git /home/"$SCRIPT_USER"/.rbenv/plugins/rbenv-vars



chmod 777 -R /home/"$SCRIPT_USER"/.rbenv



echo 'export RBENV_ROOT=/home/'$SCRIPT_USER'/.rbenv' >> /home/"$SCRIPT_USER"/.bashrc

echo 'export PATH="$RBENV_ROOT/bin:$PATH"' >> /home/"$SCRIPT_USER"/.bashrc

echo 'eval "$(rbenv init -)"' >> /home/"$SCRIPT_USER"/.bashrc



echo 'export RBENV_ROOT=/home/'$SCRIPT_USER'/.rbenv' >> /home/"$SCRIPT_USER"/.zshrc

echo 'export PATH="$RBENV_ROOT/bin:$PATH"' >> /home/"$SCRIPT_USER"/.zshrc

echo 'eval "$(rbenv init -)"' >> /home/"$SCRIPT_USER"/.zshrc



echo 'export RBENV_ROOT=/home/'$SCRIPT_USER'/.rbenv' >> /root/.bashrc

echo 'export PATH="$RBENV_ROOT/bin:$PATH"' >> /root/.bashrc

echo 'eval "$(rbenv init -)"' >> /root/.bashrc



export RBENV_ROOT=/home/"$SCRIPT_USER"/.rbenv

export PATH="$RBENV_ROOT/bin:$PATH"

eval "$(rbenv init -)"



# Install ruby-build

git clone https://github.com/rbenv/ruby-build.git /home/"$SCRIPT_USER"/.rbenv/plugins/ruby-build





echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> /home/"$SCRIPT_USER"/.bashrc

echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> /home/"$SCRIPT_USER"/.zshrc



chmod 777 -R /home/"$SCRIPT_USER"/.rbenv



source /home/"$SCRIPT_USER"/.bashrc



# Install Ruby

rbenv install -v "$RUBY_VERSION"

rbenv global "$RUBY_VERSION"



gem install bundler



cd

curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -

sudo apt-get install -y nodejs

curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -

echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

sudo apt update && sudo apt install -y yarn



cd /home/"$SCRIPT_USER"



mkdir TodoLegal

cd /home/"$SCRIPT_USER"/TodoLegal

git init

git remote add origin https://github.com/TodoLegal/TodoLegal.git

git pull origin "$TL_BRANCH"

echo "ELASTICSEARCH_URL: ENV["\""ELASTICSEARCH_URL"\""]" >> /home/"$SCRIPT_USER"/TodoLegal/config/application.yml

EDITOR="nano" bin/rails credentials:edit

chmod 777 -R /home/"$SCRIPT_USER"/TodoLegal



sudo apt-get install -y postgresql-client libpq-dev



bundle install

sudo apt-get install -y dirmngr gnupg

sudo apt-get install -y nginx

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 561F9B9CAC40B2F7

sudo apt-get install -y apt-transport-https ca-certificates

sudo sh -c 'echo deb https://oss-binaries.phusionpassenger.com/apt/passenger focal main > /etc/apt/sources.list.d/passenger.list'

sudo apt-get update

sudo apt-get install -y libnginx-mod-http-passenger

`if [ ! -f /etc/nginx/modules-enabled/50-mod-http-passenger.conf ]; then sudo ln -s /usr/share/nginx/modules-available/mod-http-passenger.load /etc/nginx/modules-enabled/50-mod-http-passenger.conf ; fi`

cd $CURRENT_PATH

sudo cp Docs/TodoLegal /etc/nginx/sites-enabled/
sudo rm /etc/nginx/sites-enabled/default
sudo service nginx restart



#sudo snap install --classic certbot

#sudo ln -s /snap/bin/certbot /usr/bin/certbot



#chown -R "$SCRIPT_USER":"$SCRIPT_USER" /home/"$SCRIPT_USER"

#chown -R "$SCRIPT_USER":root /usr/local/rbenv

