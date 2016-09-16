#!/bin/bash

set -e
set -x

# OS SETUP
yum update -y
yum install -y sudo
yum install -y git-core zlib zlib-devel gcc-c++ patch readline readline-devel libyaml-devel libffi-devel openssl-devel make bzip2 autoconf automake libtool bison curl sqlite-devel libicu-devel ImageMagick ImageMagick-devel libxslt libxslt-devel libxml2-devel mariadb-server mariadb-devel postgresql-libs postgresql-devel file-devel rake epel-release npm
yum install -y redis
yum install -y nodejs
systemctl enable mariadb
systemctl restart mariadb
systemctl restart redis
if ! mysqladmin -u root password vapt; then
  echo 'The mysql root password could not be set. It will be updated.'
  mysqladmin -u root -p'vapt' password vapt
  echo 'The mysql root password was updated.'
fi
systemctl restart mariadb
if ! id -u dev >/dev/null 2>&1; then
  useradd -G wheel dev
fi

# APP SETUP AS DEV USER
exec sudo -i -u dev /bin/bash - << EOF
  set -e
  set -x

  mkdir -p /home/dev/.ssh

  cat > /home/dev/.ssh/id_rsa <<EOKEY
-----BEGIN RSA PRIVATE KEY-----
MIIEowIBAAKCAQEA6CEUkfPFKTKuaYxGJTHyf3A8xi454po4Rb9GtXwSRpG4+qrb
zcQizgM8nrkjPygiVe0i6MXuP3kPwCO0FBo8tsjZZnWocyn9yOW6ZtXx5DFZnBLG
Q9ddAYRAkYRI5tjZypit4wQ8ZsXv9vMEoUiiSG5lfcWLf7e35SaH0xkpReRdVWLw
v9c9xHH3o0DMbGscfgSASL1FI0WqRC9vaRXg+UjGiLn7o1/CGYmhCwh5cTzC5zpg
f/7lMM3Gg1+v0C3U6rUZqhbSpmRTuHkwM2aIALCwwWt0i+hHN+xrv/OZCEBy0dee
FDTLfb8LjXoUNJu2Elg/YbMjF14C7n6jINvXPQIDAQABAoIBABmSq2V46ZukTbqr
DX9DhWeswcVDinUAcHqem/ead5j2rN5QvG5q0TrI+ICz/MIUddPpkBL820Z629Vb
GZetXEr2zZyQEcK+OYtMY8C4iTGOjkS3fMg0jbaBD2v4mt9zvGqpb163NMBNxiX6
l+P80IQSRXQZs0iawNOp7wS+nOFqFXRRyvudLUVeu7NhpMuzftsy36ZwLLaKQ+mF
RHjwVttMXfN/e1ZjmbFbHSEXrbK1ci3ihhXQHl/Sn0ccfmhc2HyOd1Uf+rhDGrN5
dccAb/vopwjznHI1wH6w7WPhr7nRnt6vCIqTVS5Lxb6I8ZZH1Ivd2fb3maaGikLj
SYhG0YECgYEA+WluQwdirLTs+IK6wuN3Mw4bamGagH3gx0QfBBsFeCw4dBpxOnoK
zwVfKUJ5TGcop9AeiNB2bGnE5Jw0LhlDunr8RiCuAnTurqi9h4l/FN6CkDQpO6bq
PIbCB3OihM7WYIF+6O9V50j3S4aqM7/KivZp0l6ywCllSFgdNulFOrkCgYEA7kLI
BwW+/r7RsA3BLGCFepLhd7fFeaocU1X4YSgqy/OrJ3Ys/1uTonyF2+goiQBSnt9Y
Z3zSf9735RqFFpqTRjYtRXB42GkiJQp6zIelHC42iFAtv9m1wVnkCsaa/EXY9PHS
SCmyggDWW2N47oZaf+7jA78CokBd92GQx0lN7qUCgYBkFsdE5uXWYRTn9a51H0tq
lbKy0lBqWBmoXdIEl8NuInDVRvdBfFByG7nAmQiMfKl4DrDyPpYHk7qL85ONHF5t
q4Upr1ulaL+QH+9PQQJaoaDLteMGKUm+2GVtEB6cJVUqjU0ctU9H7aQwDu6mrcTe
V1zIK3CYZQRcL+ApdRtvIQKBgAQqksjcptxZhd0oQGqAPZVJIDwxsHhSKzCh3jgE
tcrfNez4ugy1Ez3SI50W0C6lHMy+ZxNYMW4e/gK5lf4xMcYWiHAgaVyPahNvvXn6
HT8C5902WbZzHiSFZ+FwW6FxrzuJRv4QDJkNXrI2aRTysH5wNPQJ0Qf5TCtZP2jc
tUopAoGBALC882fGHt60kV2A7AmLlVnVe3fDEkuiPP1Zv9ygXhrz6Kip3tDEcC58
p6UMAsUUeWplegu6mn+98QHZFnM848OUYEpPg2i7Y8uCBf8/knWZlRqb1fcgVYfs
FMfeO+f+sWG40mRZLo9/iOx0pb8OkWMREXG3aYrvS4Zy8x3q/ZGp
-----END RSA PRIVATE KEY-----
EOKEY

  cat > /home/dev/.ssh/id_rsa.pub <<EOKEY
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDoIRSR88UpMq5pjEYlMfJ/cDzGLjnimjhFv0a1fBJGkbj6qtvNxCLOAzyeuSM/KCJV7SLoxe4/eQ/AI7QUGjy2yNlmdahzKf3I5bpm1fHkMVmcEsZD110BhECRhEjm2NnKmK3jBDxmxe/28wShSKJIbmV9xYt/t7flJofTGSlF5F1VYvC/1z3EcfejQMxsaxx+BIBIvUUjRapEL29pFeD5SMaIufujX8IZiaELCHlxPMLnOmB//uUwzcaDX6/QLdTqtRmqFtKmZFO4eTAzZogAsLDBa3SL6Ec37Gu/85kIQHLR154UNMt9vwuNehQ0m7YSWD9hsyMXXgLufqMg29c9 anpseftis86@gmail.com
EOKEY

  echo -e "Host github.com\n\tStrictHostKeyChecking no\n" >> /home/dev/.ssh/config
  chmod 600 /home/dev/.ssh/*
  git clone git@github.com:anpseftis/vapt.git
  curl -#LO https://rvm.io/mpapis.asc
  gpg --import mpapis.asc
  curl -sSL https://get.rvm.io | bash -s stable
  source ~/.rvm/scripts/rvm
  git config --global url."https://".insteadOf git://
  cd /etc/opt/
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
  cd lib
  git clone https://github.com/offensive-security/exploit-database.git
  cd ..
  sed -i 's/password:/& vapt/g' config/database.yml
  sed -i 's/password:/& vapt/g' risu.cfg
  rake tmp:create db:create db:migrate db:seed
  rake db:populate # Can take > 45 minutes
  rake assets:precompile # Can take > 5 minutes
  risu --create-tables
  passenger start -p 3000 -b 0.0.0.0 -e production -d
  bundle exec sidekiq -e production -d
EOF
