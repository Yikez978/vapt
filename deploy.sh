#!/bin/bash


# SCRIPT SETUP
set -e
set -x


# OS SETUP
yum update -y
yum install -y sudo
yum install -y git-core zlib zlib-devel gcc-c++ patch readline readline-devel libyaml-devel libffi-devel openssl-devel make bzip2 autoconf automake libtool bison curl sqlite-devel libicu-devel ImageMagick ImageMagick-devel libxslt libxslt-devel libxml2-devel mariadb-server mariadb-devel postgresql-libs postgresql-devel file-devel rake epel-release npm nodejs
yum install -y redis
systemctl enable mariadb
systemctl restart mariadb
systemctl restart redis
mysqladmin -u root password vapt
systemctl restart mariadb

useradd -G wheel dev

# APP SETUP AS DEV USER
exec sudo -i -u dev /bin/bash - << EOF
  set -e
  set -x

  curl -#LO https://rvm.io/mpapis.asc
  gpg --import mpapis.asc
  curl -sSL https://get.rvm.io | bash -s stable
  source ~/.rvm/scripts/rvm
  rvm requirements
  rvm install 2.2.2
  gem install bundler
  gem install passenger

  cd /home/dev/vapt
  rvm --default use 2.2.2
  bundle install
  cp config/database.example.yml config/database.yml
  cat > config/secrets.yml <<EOFSECRETS
production:
  secret_key_base: c6500455c722872da70362a01627e249a1c766b03dfa094389717c607df1c032be5b007f051f2332acd00fde3e5ad500a8c1c0377c9650573e2d0c3c7f6fcc6c
EOFSECRETS
  export RAILS_ENV=production
  mkdir -p /tmp/pids
  sed -i 's/password:/& vapt/g' config/database.yml
  sed -i 's/password:/& vapt/g' risu.cfg
  rake tmp:create db:create db:migrate db:seed
  rake db:populate # Can take > 45 minutes
  rake assets:precompile # Can take > 5 minutes
  cd lib
  git clone https://github.com/offensive-security/exploit-database.git
  cd ..
  risu --create-tables
  passenger start -p 3000 -b 0.0.0.0 -e production -d
  bundle exec sidekiq -e production -d
EOF
