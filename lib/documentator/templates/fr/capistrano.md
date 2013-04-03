Déploiement avec capistrano
---------------------------

Pour nos applications, nous mettons en place un script de déploiement
automatisé. Celui-ci s'appuie sur l'outil Capistrano et nos recettes maison :
[capistrano-af83](https://github.com/AF83/capistrano-af83).

Sur le serveur
--------------

Nous conseillons de faire tourner l'application avec un user UNIX au nom du
projet. Pour ce guide de déploiement, nous supposons que son `$HOME` est
`/var/www/projet` et que les dépendances (Git, Ruby, Nginx, etc.) ont déjà été
installées.

Il est alors nécessaire de créer une clé ssh pour cet utilisateur, à l'aide de
la commande `ssh-keygen`. Puis, il faudra nous fournir cette clé pour que l'on
ajoute cette clé SSH comme clé de déploiement sur github.

On peut alors se connecter en ssh pour, d'une part, vérifier que ça marche et,
d'autre part, définir quelques variables d'environnement. Nous avons pour
habitude de les placer dans le fichier `~/ruby-env` et d'ajouter la ligne
`source ~/ruby-env` au début du fichier `~/.bashrc`. Voici le contenu de ce
fichier `ruby-env` :

```
#!/bin/sh
export GEM_HOME=~/gem
export PATH=~/bin:$GEM_HOME/bin:$PATH
export APP_ROOT=~/prod/current
export THIN_CONF=~/prod/shared/thin.yml

if [ -z "en_US.UTF-8" ]; then
  export LANG=en_US.UTF-8
fi

export RAILS_ENV=production

reload() {
    pushd $APP_ROOT && bundle exec thin restart -C $THIN_CONF
    popd
}

stop() {
    pushd $APP_ROOT && bundle exec thin stop -C $THIN_CONF
    popd
}
```

Dernière étape coté serveur, il faut installer bundler avec `gem install
bundler`.


Sur la sandbox de déploiement
-----------------------------

D'autre part, la personne qui fera le déploiement du code a également besoin
d'accéder à notre dépôt github (envoyez-nous la liste des comptes github) et à
un environnement Ruby depuis lequel le déploiement capistrano se fera. Sur cet
environnement, il faudra également installer la gem Ruby bundler (`gem install
bundler`).

Comme pour le coté serveur, il peut être utile de définir les variables
d'environnement suivantes si Ruby a été installé en root :

```
export GEM_HOME=~/gem
export PATH=~/bin:$GEM_HOME/bin:$PATH
```

Le déploiement se fera depuis le répertoire contenant le code :

```
git clone git@github.com:AF83/projet.git
cd projet
```

La configuration spécifique pour l'environnement de production peut être
adaptée dans le fichier `config/deploy/prod.rb` (créez le fichier s'il
n'existe pas). Les principales variables peuvent être affichées avec `cap prod
info`.

Lors du premier déploiement, il convient de lancer `cap prod deploy:setup`.
Puis, chaque déploiement se fera en lançant `cap prod deploy`.

**Note** : il est recommandé de faire un git clone depuis le serveur avant le
premier déploiement pour éviter le message d'avertissement de ssh (connexion à
un hôte inconnu).

**Astuce** : il est possible de se connecter en ssh sur le serveur en faisant
`cap prod ssh`.
