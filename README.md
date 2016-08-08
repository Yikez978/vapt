HackTheArch
===========

Requirements
------------
CentOS 7+
or
Ubuntu Server 14.4+
or 
MACOSX

Deployment Options
==================
Getting Started
---------------
* Do not deploy this framework as root. Create a new user for your envirorment and add them to the sudoers / wheel group.
* Where it tells you to use nano in the instructions please use nano. vi tends to break the files by adding additional random characters.
* Download XML from  http://cve.mitre.org/data/downloads/index.html (raw allitems.xml version)
* Download Version 2.9 ZIP from https://cwe.mitre.org/data/index.html#archive , to your download folder

Ubuntu-server
==================
1. Download the latest version of Ubuntu-server from (http://www.ubuntu.com/download/server/thank-you?version=16.04.1&architecture=amd64)
2. Create new user, add new user to sudo group.
# Create new user
------------
adduser deploy
# add new user deploy to "sudo" group"
------------
usermod -aG sudo deploy
3. SSH to server as user deploy
ssh <username>@<IP ADDRESS>
4. Update
sudo apt-get update
5. clone git
git clone git@github.com:GoodWorkLabs/hack-the-arch.git
6. Installing RVM & Ruby
------------
curl -#LO https://rvm.io/mpapis.asc
gpg --import mpapis.asc
curl -sSL https://get.rvm.io | bash -s stable
source ~/.rvm/scripts/rvm
# Install missing package with fix.
------------
sudo apt-get install imagemagick --fix-missing
sudo apt-get install libmysqlclient-dev
sudo apt-get install libmagickwand-dev imagemagick
sudo apt-get install libmagic-dev
sudo apt-get install redis-server
sudo apt-get install mysql-server (Supply username and password and remember)
sudo apt-get install nodejs

git config --global url."https://".insteadOf git://
cd /etc/opt/
rvm requirements
rvm install 2.2.2 
gem install bundler
gem install passenger
# Change Directory to hack-the-arch
------------
cd ~/hack-the-arch
# Set rvm envirorment for application
------------
rvm --default use 2.2.2
gem install bundler
bundle install
# Copy example database and edit new file with correct information.
------------
cp config/database.example.yml config/database.yml
nano database.yml (enter username and password for the database and save & exit)
# Prepare the database
------------
rake db:create RAILS_ENV=production
rake db:migrate RAILS_ENV=production
rake db:seed RAILS_ENV=production
# This file should automake but doesn't currently so if this directory structor is not present in your hack-the-arch folder then create it.
------------
mkdir /tmp/pids
bundle exec rake tmp:create

cd lib
git clone https://github.com/offensive-security/exploit-database.git
rails c production
PopulateExploit.populate_exploits_from_exploit_db

CveDatabase.populate_data_from_csv_xml("/home/deploy/hack-the-arch/allitems.xml")  (Downloaded file full path, pass as argument)
CweWeaknessCatalog.populate_data_from_cwe_xml("/home/deploy/hack-the-arch/cwec_v2.9.xml")  (Downloaded file full path, pass as argument)
nano risu.cfg
1. replace author name with your name
2. give proper database name , user name and password. You can find these data in the database.yml file
risu --create-tables

# Start server
------------
passenger start -p 3000 -b 0.0.0.0 -e production -d (anything under 1024 will throw an error)

Install & Prepare background worker & queue 
=====================================
# Install & run redis on default redis port, make sure it is running after system boot.
------------
redis-cli (to check if installed and running redis)
# Run sidekiq service as background demon
------------
bundle exec sidekiq -e production -d
