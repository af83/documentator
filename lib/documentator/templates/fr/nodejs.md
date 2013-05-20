# Nodejs

[Nodejs](http://nodejs.org/)

## Installation

Version recommandée : version majeur pair (ex 0.10.6)
Installation sans droit administrateur.

prérequis :

 * GNU make >= 3.81
 * python == 2.6 ou 2.7.

``` shell
git clone https://github.com/joyent/node.git
cd node
git checkout v0.10.6
./configure --prefix=$HOME/.node && make -j 3 && make install
export PATH=$PATH:$HOME/node/bin
```

ou utiliser les [binaires](http://nodejs.org/download/)

``` shell
wget http://nodejs.org/dist/v0.10.6/node-v0.10.6-linux-x64.tar.gz
tar xzvf node-v0.10.6-linux-x64.tar.gz
export PATH=$PATH:$HOME/node-v0.10.6-linux-x64/bin
```

Ajouter la derniere ligne à ~/.profile ou ~/.bash_profile ou ~/.bashrc ou ~/.zshenv

## Utilisation

``` shell
npm --help
node --help
```
