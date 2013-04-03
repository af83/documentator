# Postgresql

## Installation

### Debian

En tant que root:

``` bash
aptitude install postgresql postgresql-server-dev-9.1 postgresql-client
libpq-dev
```

Une fois postgresql installé, il faut créer un nouvel utilisateur:

``` bash
su postgres
createuser username
exit
```

Puis éditer le fichier `/etc/postgresql/9.1/main/pg_hba.conf` pour autoriser les
utilisateurs non-unix à s'authentifier.

Pour cela, il faut changer `peer` en `trust`:

```
# TYPE  DATABASE        USER            ADDRESS                 METHOD

# "local" is for Unix domain socket connections only
local   all             all                                     trust
```

Finalement, redémarrer postgresql:

``` bash
/etc/init.d/postgresql restart
```
