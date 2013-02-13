# Ruby

## Install

On the server you need to install some packages

Debian, as root:

``` shell
aptitude install ruby1.9.3 ruby1.9.1-dev make libxml2-dev libxslt1-dev g++ git libcurl4-gnutls-dev
```

Gems, as a user:

``` shell
gem install bundler && bundle install
```

## Configuration

First of all, you need to do some manual setup on the server, create a ruby-env
shell script with:

``` shell
cat > ~/ruby-env << EOF
#!/bin/sh
export GEM_HOME=~/gem
export PATH=~/bin:\$GEM_HOME/bin:\$PATH
if [ -z "\$LANG" ]; then
  export LANG=en_US.UTF-8
fi
export RAILS_ENV=production
export RACK_ENV=production
EOF
```

A gemrc file:

``` shell
cat > ~/.gemrc << EOF
gem: --no-ri --no-rdoc
EOF
```

And source the ~/ruby-env file on top of bashrc.
