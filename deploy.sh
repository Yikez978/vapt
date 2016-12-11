#!/bin/bash

set -e
set -x


  curl -#LO https://rvm.io/mpapis.asc
  gpg --import mpapis.asc
  curl -sSL https://get.rvm.io | bash -s stable
  source ~/.rvm/scripts/rvm
  echo source ~/.rvm/scripts/rvm >> /home/dev/.bashrc
  
  rvm requirements
  rvm install 2.2.2
  gem install bundler --no-ri --no-rdoc
  gem install passenger --no-ri --no-rdoc
  
  cd /home/dev/vapt/
  rvm --default use 2.2.2
  gem install passenger
  bundle install
  cp config/database.example.yml config/database.yml
  cat > config/secrets.yml <<EOFSECRETS
production:
  secret_key_base: c6500455c722872da70362a01627e249a1c766b03dfa094389717c607df1c032be5b007f051f2332acd00fde3e5ad500a8c1c0377c9650573e2d0c3c7f6fcc6c
EOFSECRETS
  export RAILS_ENV=production
  mkdir -p /tmp/pids
  sed -i 's/password:\s*$/password: vapt/g' config/database.yml
  sed -i 's/password:\s*$/password: vapt/g' risu.cfg

  rm -rf lib/exploit-database
  cd lib
  git clone https://github.com/offensive-security/exploit-database.git
  cd ..

  rake tmp:create db:create db:migrate db:seed
  rake db:populate # Can take > 45 minutes
  rake assets:precompile # Can take > 5 minutes

  risu --create-tables

  set +e
  ps -ef | grep sidekiq | grep -v grep | awk '{print $2}' | xargs kill -9
  pkill nginx
  set -e

  passenger start -p 3000 -b 0.0.0.0 -e production -d
  bundle exec sidekiq -e production -d
EOF
