# Beanstalkd

[A simple, fast work queue](http://kr.github.com/beanstalkd/).

## Installation

En tant que root:

``` shell
aptitude install beanstalkd
```

## Configuration

Exemple de fichier de configuration:

    ## Defaults for the beanstalkd init script, /etc/init.d/beanstalkd on
    ## Debian systems. Append ``-b /var/lib/beanstalkd'' for persistent
    ## storage.
    BEANSTALKD_LISTEN_ADDR=0.0.0.0
    BEANSTALKD_LISTEN_PORT=11300
    DAEMON_OPTS="-l $BEANSTALKD_LISTEN_ADDR -p $BEANSTALKD_LISTEN_PORT"

    ## Uncomment to enable startup during boot.
    START=yes

`beanstalkd` accepte le flag `-b` suivit d'un chemin. Cette option active un
binlog. Cela permet de ne pas perdre de message lors d'un redémarrage de
beanstalkd.
