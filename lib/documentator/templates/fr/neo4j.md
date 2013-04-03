# Neo4j

[The Market Leader Property Graph Database](http://www.neo4j.org/)

Une base de données graphe est un système de stockage supportant 
la persistance des données sous forme de graphe (noeuds, relations) nativement. 

## Installation

Version recommandée stable en édition 'community': 1.8.2

* Debian

``` shell
# start root shell
sudo -s
# Import our signing key
wget -O - http://debian.neo4j.org/neotechnology.gpg.key | apt-key add - 
# Create an Apt sources.list file
echo 'deb http://debian.neo4j.org/repo stable/' > /etc/apt/sources.list.d/neo4j.list
# Find out about the files in our repository
apt-get update
# Install Neo4j, community edition
apt-get install neo4j
# start neo4j server, available at http://localhost:7474 of the target machine
neo4j start
```

* OSX
via Homebrew
``` shell
brew update && brew install neo4j
neo4j start
```
