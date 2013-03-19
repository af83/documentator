# Elasticsearch


[Elasticsearch](http://www.elasticsearch.org/) est un moteur de recherche
distribué basé sur Lucene qui offre une API JSON RESTful et une quantité assez
impressionnante d'options de recherches. Il est très simple à mettre en place
et s'est imposé chez nous comme la solution de référence dès que nous avons une
recherche un peu évoluée à mettre en place.

## Installation


### Pour une installation en local

Le plus simple pour une installation en local est d'utiliser [Desi](https://github.com/AF83/desi) :

```shell
gem install desi && desi install
```

Par défaut, Desi installera ES dans le répertoire `$HOME/elasticsearch`, mais
on peut facilement [changer ce paramètre](https://github.com/AF83/desi#change-settings).

Une fois ES installé par Desi, on peut très simplement à la fois le lancer et
afficher les logs en faisant `desi start --tail`. Pour arrêter le démon, faire
`desi stop`, tout simplement. Pour les autres options proposées par Desi,
référez-vous à [la page du projet](https://github.com/AF83/desi).


### Installation sur un serveur

Le plus simple est de récupérer l'archive deb
[directement depuis la page _download_ du projet](http://www.elasticsearch.org/download/).

L'installation est là aussi très simple. On peut se référer à [la page
correspondante sur le site du projet](http://www.elasticsearch.org/guide/reference/setup/installation.html)
pour plus de détails.

### Gotcha

Bien que des optimisations aient été apportées pour diminuer sa gourmandise en
la matière, ES fait une consommation importante de descripteurs de fichiers.
Les réglages par défaut du nombre maximum de descripteurs de fichiers autorisés
par utilisateur sur un système Linux sont généralement rapidement atteints,
avec comme conséquence le message d'erreur `Too many open files`.

Pour prévenir ce problème, il convient donc d'augmenter cette limite pour
l'utilisateur qui lancera le démon Elasticsearch. La documentation du projet
recommande de le hausser à 32 000, voir 64 000. Sur un système Linux, il
faudra modifier le fichier `/etc/security/limits.conf`. Cela donne par exemple
chez moi :

```
drr  soft  nofile    8192
drr  hard  nofile    65536
```

## Plugins

Il existe [un grand nombre de plugins](http://www.elasticsearch.org/guide/reference/modules/plugins.html)
parmi lesquels quelques-uns peuvent être utiles pour l'administration au
quotidien :

* [elasticsearch-head](https://github.com/mobz/elasticsearch-head)
* [elasticsearch-inquisitor](https://github.com/polyfractal/elasticsearch-inquisitor)
* [bigdesk](https://github.com/lukas-vlcek/bigdesk)
* [paramedic](https://github.com/karmi/elasticsearch-paramedic)

Pour installer un plugin, il faut aller dans le répertoire où est installé ES
et lancer la commande `bin/plugin install github_user/github_repo`. Par
exemple, pour installer les plugins mentionnés ci-dessus avec une installation
typique faite par Desi, on peut faire :

```shell
$ cd ~/elasticsearch/current
$ bin/plugin install mobz/elasticsearch-head
$ bin/plugin install polyfractal/elasticsearch-inquisitor
$ bin/plugin install lukas-vlcek/bigdesk
$ bin/plugin install karmi/elasticsearch-paramedic
```

Ces plugins seront accessibles sur les URLs suivantes :

* http://localhost:9200/_plugin/head/
* http://localhost:9200/_plugin/inquisitor/
* http://localhost:9200/_plugin/bigdesk/
* http://localhost:9200/_plugin/paramedic/



## Bonnes pratiques


### Se méfier des erreurs de mapping

Les erreurs de
[mapping](http://www.elasticsearch.org/guide/reference/mapping/index.html) sont
particulièrement pernicieuses et constituent d'expérience la plus grosse source
de fragilité. Il s'agit d'ailleurs en premier lieu de problèmes posés par
Lucene et non par ES proprement dit.

Elles se manifestent par l'impossibilité d'indexer un document dont la
structure ne correspond pas à celle attendue par l'index où on veut le stocker.
Cela peut avoir des conséquences particulièrement gênantes en production car
la suppression/recréation de l'index suivie d'une réindexation sera fréquemment
la seule solution.

Pour s'en prémunir, il convient donc en premier lieu :

1. de ne pas se fier uniquement au [mapping
    dynamique](http://www.elasticsearch.org/guide/reference/mapping/dynamic-mapping.html)
   d'Elasticsearch mais d'indiquer explicitement à ES les champs à indexer

2. d'indexer le moins de champs possibles.

  On n'est en effet pas obligé d'*indexer* un champ pour le stocker dans
  Elasticsearch. On peut tout à fait le stocker dans la
  [source](http://www.elasticsearch.org/guide/reference/mapping/source-field.html)
  du document sans qu'il soit pris en compte dans la requête. Elasticsearch
  — et plus précisément Lucene — le stockera sans chercher à procéder à quelque
  analyse que ce soit et pourra le restituer tel qu'il lui a été fourni.

  Le mieux est donc d'utiliser les [dynamic\_templates](http://www.elasticsearch.org/guide/reference/mapping/root-object-type.html) pour passer par défaut tous les champs en `"index": "no"`, pour
  ensuite indexer explicitement les champs désirés au cas par cas.

  Outre la fiabilité accrue, cela réduira également la taille des indexes
  Lucene et donc la charge du système.


Au delà de cette première mesure, il faut également bien sûr mentionner deux
conseils de bon sens :

  * Tâcher autant que faire se peut de déterminer le plus précisément
    possible la structure du document et de s'y tenir
  * Ne pas changer en cours de route la nature d'un champ en conservant son
    nom à l'identique. On peut changer la cardinalité d'un élement sans
    changer le mapping, mais son type doit demeurer identique.


### Ne pas nommer à l'identique deux champs de natures différentes stockés dans un même index ES

On peut stocker dans un même [index](http://www.elasticsearch.org/guide/reference/glossary/#index)
Elasticsearch plusieurs [types](http://www.elasticsearch.org/guide/reference/glossary/#type)
de documents. Il faut cependant garder à l'esprit que tous les documents d'un
index ES, quel que soit leur type, seront stockés dans le même index Lucene.
Une des conséquences est qu'on ne peut avoir en parallèle de champs dont le
nom soit identique d'un type à l'autre mais dont la nature soit différente.


### Utiliser les multi-fields pour préparer ses recherches

Les [multi fields](http://www.elasticsearch.org/guide/reference/mapping/multi-field-type.html)
permettent de spécifier à ES qu'on veut qu'un même champ soit indexé de
plusieurs façons à la fois. On pourra dès lors faire des requêtes dessus en
utilisant la syntaxe `nom_du_champ.nom_du_sous_champ`. On peut donc avoir
plusieurs sous-champs optimisés chacun pour des cas précis : recherche
_full-text_ normale, tri ou facette, auto-complétion, etc.


### Utiliser un champ non "tokenisé" pour effectuer des tris ou des facettes

Afin d'effectuer une recherche _full-text_ sur un champ de type chaîne de
caractères, il est nécessaire de lui appliquer tout un certain nombre
d'opérations (typiquement : segmentation en mots, suppression des caractères diacritiques, des
accents, lemmatisation, etc.) Cependant, ces opérations empêcheront d'effectuer
certaines opérations qui n'ont de sens qu'appliquées sur le contenu exact du
champ d'origine, notamment :

* le tri (cela n'a pas de sens de faire un tri sur un champ texte segmenté en
plusieurs mots différents)
* les facettes

Pour ces deux cas, il conviendra donc donc soit de définir le _mapping_ du champ
comme `not_analyzed`, soit d'utiliser le _mapping_ `keyword`. Dans le deux cas,
il sera indexé tel quel sans segmentation ou modification d'aucune sorte.

Comme indiqué ci-dessus, on peut bien sûr utiliser un *multi-field* si on veut
indexer le même champ de plusieurs façons à la fois.

### Utiliser l'endpoint `analyze` pour vérifier la façon dont un texte est segmenté

Pour plus de détails, se référer [à la documentation](http://www.elasticsearch.org/guide/reference/api/admin-indices-analyze.html)

### Se méfier des limitations de Tire

[Tire](https://github.com/karmi/tire) est sans conteste la gem Ruby destinée
à faciliter l'utilisation d'Elasticsearch la plus évoluée. Son développeur
principal, karmi, a d'ailleurs rejoint récemment l'équipe
d'[Elasticsearch.com](http://www.elasticsearch.com/), la société qui est
derrière le projet. Elle est cependant loin d'être exempte de défauts. Elle
rend les choses simples triviales mais les cas de figure plus complexes peuvent
devenir rapidement compliqués à mettre en place.

Ses principales limitations :

  * Son DSL de recherche entraîne assez rapidement des confusions entre sa
    syntaxe propre et celle — foisonnante — d'Elasticsearch.

  * Il est dans l'ensemble très orienté vers un pattern de type Active Record,
    avec une classe de persistence couplée dans une relation 1-1 avec un index
    ES. On peut cependant avoir facilement des besoins qui vont au-delà de ce
    cas de figure

  * une documentation mine de rien lacunaire quand on commence à vouloir avoir
    des besoins un peu précis.

La gem [stretcher](https://github.com/PoseBiz/stretcher) est née récemment en
réaction à nombre de ces points. C'est une alternative récente à étudier.


## Outils


### Librairies

* Ruby: [desi](https://github.com/AF83/desi), [tire](https://github.com/karmi/tire),
  [stretcher](https://github.com/PoseBiz/stretcher)

* Javascript : [elastic.js](https://github.com/fullscale/elastic.js)


### Outils en ligne de commande

* [desi](https://github.com/AF83/desi)
* [elasticshell](https://github.com/javanna/elasticshell)


### Plugins Elasticsearch

* [elasticsearch-head](https://github.com/mobz/elasticsearch-head)
* [elasticsearch-inquisitor](https://github.com/polyfractal/elasticsearch-inquisitor)
* [bigdesk](https://github.com/lukas-vlcek/bigdesk)
* [paramedic](https://github.com/karmi/elasticsearch-paramedic)

(Voir plus haut pour plus de détails.)
