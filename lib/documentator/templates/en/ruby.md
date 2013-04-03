# Ruby

## Install

Our recommandation is to use the most recent Ruby 1.9.3.

Debian doesn't provide official packages for Ruby 1.9.3, but it's possible to
use other sources for that. We trust Bearstech and use their debian packages.
You can use them for Ruby by creating a
`/etc/apt/sources.list.d/bearstech-ruby1.9.3.list` file with this line:

```
deb http://deb.bearstech.com/squeeze ruby-1.9.3/
```

Then, as root, you can launch the install with:

``` shell
aptitude update && aptitude install ruby1.9.3 ruby1.9.1-dev build-essential libxml2-dev libxslt1-dev libcurl4-gnutls-dev
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


## Gems

To manage our gems, we use a tool called Bundler. So, you can install them
by going in the application directory and taping this one-liner:

``` shell
gem install bundler && bundle install
```
