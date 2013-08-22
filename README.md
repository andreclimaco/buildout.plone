# Buildout Plone

<img src="https://raw.github.com/andreclimaco/buildout.plone/master/docs/configuration.png"/>

## Preparação do ambiente

**Observação:** Antes de tudo, instale os pacotes do sistema operacional necessários para o Plone. [Instruções](http://developer.plone.org/getstarted/installation.html#id6)

Monte seu ambiente python utilizando o virtualenv com python 2.7.

Utilizando o pacote [buildout.python](http://github.com/collective/buildout.python) é possível a montagem do ambiente necessário para a criação do virtualenv.

## Ativando o virtualenv
```bash
$ source /path/to/env/bin/activate
```
## ZEO
```bash
$ cd /path/to/zodb
$ python bootstrap.py
$ bin/buildout -v
```
## Zope Instances
```bash
$ cd /path/to/app
$ python bootstrap.py
$ bin/buildout -v
```
## Frontend
```bash
$ cd /path/to/frontend
$ python bootstrap.py
$ bin/buildout -v
```
