# Postgresql

## Installation

Les exemples ci-dessus prennent comme version de référence la version 9.1, [la
version de PostgreSQL la plus récente qui soit disponible dans
squeeze-backports](http://packages.debian.org/squeeze-backports/postgresql)

### Debian

En tant que root :

``` bash
aptitude install postgresql postgresql-server-dev-9.1 postgresql-client postgresql-contrib-9.1
libpq-dev
```

## Authentification sur une machine de développment

Pour une utilisation en dévelopment, il est généralement beaucoup plus simple
de changer les paramètres d'authentification de PostgreSQL pour autoriser tout
utilisateur local à se connecter à n'importe quelle base avec n'importe quel
rôle (_user_).

Pour cela, éditer le fichier `/etc/postgresql/9.?/main/pg_hba.conf` et changez
les méthodes `peer` (accès autorisés pour tout utilisateur ayant un nom de
compte Unix identique au rôle PG demandé) ou `md5` (password crypté) en `trust`
(confiance absolue, aucune vérification de l'identité du user ou de son
password)¹.

Cela donne donc, pour la section du fichier concernée :

```
# TYPE  DATABASE        USER            ADDRESS                 METHOD

# "local" is for Unix domain socket connections only
local   all             all                                     trust
# IPv4 local connections:
host    all             all             127.0.0.1/32            trust
# IPv6 local connections:
host    all             all             ::1/128                 trust
```

**Ceci ne doit bien évidemment être fait que pour une utilisation sur une
machine individuelle et JAMAIS sur un serveur un tant soit peu exposé.**

Redémarrer PostgreSQL pour prendre en compte ce changement de configuration :

``` bash
/etc/init.d/postgresql restart
```


## Ajout d'un nouvel utilisateur (UTILISATEUR)

Faire ² :

```shell
# su postgres -c "createuser --createdb --pwprompt UTILISATEUR"
```

Il faudra alors saisir le mot de passe que l'on désire pour l'utilisateur
PosgreSQL `map`. Dans le cas d'une installation sur une machine de
développment (ou de manière générale, non "sensible"), on peut préférer ne pas
préciser de mot de passe. On lancera alors la commande sans le flag _pwprompt_ ² :

```shell
# su postgres -c "createuser --createdb UTILISATEUR"
```

## Gestion des extensions

Pour pouvoir installer ou supprimer une extension, un utilisateur Postgres doit
être doté des droits _superuser_.

Comme il n'est cependant ni vraiment utile, ni raisonnable de donner ces droits
à un utilisateur lambda, le plus simple est d'ajouter l'extension désirée à la
base _template1_, qui sert de modèle pour toutes les bases créées. Toute
nouvelle base de données créée héritera donc automatiquement de cette
extension, via le schéma `pg_catalog`.

Par exemple, si on veut rajouter l'extension
[hstore](http://www.postgresql.org/docs/9.1/static/hstore.html), on peut faire
(en tant que root)² :

```shell
# su postgres -c "psql -d template1 -c 'CREATE EXTENSION IF NOT EXISTS hstore'"
```

¹ Voir http://www.postgresql.org/docs/9.1/static/auth-methods.html pour plus
de détails
² Pour tous les exemples de commandes de type `su postgres -c "psql…`, on peut
tout simplement faire un `psql -U postgres -c "…` si on a déjà mis en place une
configuration de type "machine de développment" tel que décrite plus haut.
