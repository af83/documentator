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

Puis éditer le fichier `/etc/postgresql/9.1/main/pg_hba.conf` pour autoriser les
utilisateurs non-unix à s'authentifier.

Pour cela, il faut changer `peer` en `trust` :

```
# TYPE  DATABASE        USER            ADDRESS                 METHOD

# "local" is for Unix domain socket connections only
local   all             all                                     trust
```

À noter que cela veut dire autoriser tous les utilisateurs de la machine
à se connecter à n'import quelle base avec n'importe quel utilisateur
PostgreSQL, sans mot de passe.

**Ceci ne doit bien évidemment être fait que pour une utilisation sur une
machine individuelle et JAMAIS sur un serveur.**

Redémarrer PostgreSQL pour prendre en compte ce changement de configuration :

``` bash
/etc/init.d/postgresql restart
```

Pour créer un nouvel utilisateur :

``` bash
createuser -U postgres MON_NOUVEL_UTILISATEUR
```
