Vulnerability Assessment Penitration Tool (VAPT)
===========

This is a framework built for penters and teams to collect and corrilate data during a penitration test.  VAPT has the following capabilities:
- User Registration
- Project Scheduling
- Tool parsing
  - Nmap
  - Nessus
  - Metasploit DB
- Report retention and security
- Local Datase Mapping
  - National Vulnerability Database (NVD)
    *Note: Custom user created exploites can be added to your local database through the gui.
  - Common Vulnerabilities and Exposures (CVE)
  - Common Weakness Enumeration (CWE)

Setup Instruction
===================

Download Needed Files
-----------------------------
1. Download Version 2.9 ZIP from https://cwe.mitre.org/data/index.html#archive , to your download folder
Unzip the zip file
2. Download XML from  http://cve.mitre.org/data/downloads/index.html , to your download folder.

CentOS 7 Deploy Script
------------------
Clone the git hub
run ./deploy.sh
sit back and watch the magic happen!

CentOS - Build it out yourself
------------------
Download CentOS 7 Minamal build
Prior to seting up it is important that you create a user and add them into the wheel / sudoers group. DO NOT RUN THIS AS ROOT.
Git Clone project

sudo yum install update
-------------------
- git clone https://github.com/anpseftis/vapt.git

- Install required packages
--------------------------------
sudo yum install -y git-core zlib zlib-devel gcc-c++ patch readline readline-devel libyaml-devel libffi-devel openssl-devel make bzip2 autoconf automake libtool bison curl sqlite-devel libicu-devel ImageMagick ImageMagick-devel libxslt libxslt-devel libxml2-devel mariadb-server mariadb-devel postgresql-libs postgresql-devel file-devel rake epel-release nodejs npm nodejs redis

Start Services
-------------------------------
- sudo yum update
- sudo systemctl start mariadb
- sudo systemctl enable mariadb.service
- sudo systemctl start redis.service

Setup RVM & Ruby
----------------------------------
- curl -#LO https://rvm.io/mpapis.asc
- gpg --import mpapis.asc
- curl -sSL https://get.rvm.io | bash -s stable
- source ~/.rvm/scripts/rvm
- git config --global url."https://".insteadOf git://
- cd /etc/opt/
- rvm requirements
- rvm install 2.2.2
- gem install bundler
- gem install passenger

Configure APP
--------------------------------------
- cd /vapt
- rvm --default use 2.2.2
- gem install bundler
- bundle install
- cp config/database.example.yml config/database.yml
- vi config/database
- rake db:create RAILS_ENV=production
- rake db:migrate RAILS_ENV=production
- rake db:seed RAILS_ENV=production
- mkdir /tmp/pids
- bundle exec rake tmp:create
- cd lib
- git clone https://github.com/offensive-security/exploit-database.git

Populate Databases
-----------------------------------------
*Note: The path to the .xml needs to be the full path
- rails c production
- PopulateExploit.populate_exploits_from_exploit_db
- CveDatabase.populate_data_from_csv_xml("~/Downloads/allitems.xml")
- CweWeaknessCatalog.populate_data_from_cwe_xml("~/Downloads/cwec_v2.9.xml")

Config Risu
--------------------------------------------
- vi risu.cfg
(Edit password and change deployment to production)
- risu --create-tables

Start Server
--------------------------------
- passenger start -p 3000 -b 0.0.0.0 -e production -d

- Install & Prepare background worker & queue 
-------------------------------------------------
* Note:	Install & run redis on default redis port, make sure it is running after system boot.
- sudo yum install redis
- sudo systemctl start redis.service 
- redis-cli (to check if installed and running redis)
Run sidekiq service as background demon
------------------------------------------
- bundle exec sidekiq -e production –d

