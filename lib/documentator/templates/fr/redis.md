# Redis

[Redis](http://redis.io/) est une base de donnée "clé-valeur" améliorée. Elle est capable
de stocker des structures de données évoluées comme des chaines, des
dictionnaire, des listes, des ensembles et des ensembles ordonnés.

## Installation

### Debian

En tant que root :

```shell
aptitude install redis-server
```

## Configuration

Le fichier de configuration de Redis est /etc/redis/redis.conf. Les
effets de chaque variables y sont documentés.

## Utilisation

### Le shell Redis

La commande `redis-cli` permet de se connecter à un serveur
Redis. Toutes les commandes listées sur la [documentation de
Redis](http://redis.io/commands) peuvent être utilisées sur le shell.

La commande `INFO` permet d'avoir un apercu de l'état du serveur Redis,
notamment de la mémoire consommée. La commande `MONITOR` permet de
moniter en temps réel les opérations exécuté sur le serveur.
