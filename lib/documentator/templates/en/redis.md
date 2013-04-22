# Redis

[Redis](http://redis.io/) is an open source, BSD licensed, advanced key-value store. It is
often referred to as a data structure server since keys can contain
strings, hashes, lists, sets and sorted sets.

## Install Redis

### Debian

As root:

```shell
aptitude install redis-server
```

## Configuration

The configuration file is located at /etc/redis.redis.conf. The
meaning of each configuration variable is documented in the file.

## Usage

### Redis shell

The `redis-cli` command opens a command-line console to a Redis
server. All the commands documented on the [Redis documentation
page](http://redis.io/commands) are allowed.

The `INFO` command displays the current state of the Redis server
including the memory usage. The `MONITOR` command shows all the
operations currently executed on the Redis server.


