# MongoDB

[MongoDB (from "humongous") is a scalable, high-performance, open source NoSQL database.](http://www.mongodb.org/)

## Installation

### Debian

En tant que root:

```
aptitude install mongodb
```

Pour une version plus récente, on peut également utiliser [le dépôt de
10gen](http://docs.mongodb.org/manual/tutorial/install-mongodb-on-debian/).

### Mac OS X

```
brew install mongodb
```

## Configuration

Par défaut `mongod` active la journalisation à partir de la v2.0.
Cela prend beaucoup d'espace disque et est inutile dans un environnement
de développement. Pour la désactiver, ajouter `nojournal = true`
dans `/etc/mongod.conf` ou l'option ` --nojournal` en ligne de commande.

```
# Disables write-ahead journaling
nojournal = true
```

## Utilisation

### Shell mongo

Se connecter à la base `myproject_dev` :

```
mongo --port 27017 --host localhost myproject_dev
```

### Commandes shell

Quelques exemples sur la collection `foo` :


    db.help()                               Toutes les méthodes de mongodb
    db.foo.help()                           Toutes les méthodes de la collection
    db.foo.find().help()                    Toutes les méthodes de la méthode find()
    db.foo.find()                           Liste des documents de la collection
    db.foo.save({a: 1})                     Enregistre un document dans la collection
    db.foo.update({a: 1}, { $set:{a: 2} })  Update un document quand a == 1
    db.foo.find({a: 1})                     Liste des documents de la collection quand a == 1

### Exporter une base

Exporter ma base de donnée `myproject_dev`.

```
mongodump --db myproject_dev
```

### Restorer une base

Restorer ma base de donnée `myproject_dev` dans la base `myproject_staging`.

```
mongorestore --db myproject_staging dump/myproject_dev/
```

