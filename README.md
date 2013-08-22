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
Preparando as configurações antes de rodar o buildout:
```bash
$ cd /path/to/zeo
$ vim settings.cfg

No arquivo, alterar as variáveis:

[blobstorage]
directory = /path/to/blobstorage

[tmp]
directory = /path/to/tmpPortal
```
Executar o buildout:

```bash
$ cd /path/to/zeo
$ python bootstrap.py
$ bin/buildout -v
```
## Zope Instances
Preparando as configurações antes de rodar o buildout:
```bash
$ cd /path/to/app
$ vim settings.cfg

No arquivo, alterar as variáveis:

[users]
effective-user = user/local/machine

[blobstorage]
directory = /path/to/blobstorage

[tmp]
directory = /path/to/tmpPortal
```
Executar o buildout:

```bash
$ cd /path/to/app
$ python bootstrap.py
$ bin/buildout -v
```

## Frontend
Preparando as configurações antes de rodar o buildout:
```bash
$ cd /path/to/frontend
$ vim settings.cfg

No arquivo, alterar as variáveis:

[users]
os = user/local/machine

[hostname]
portal = hostname/machine/instance

[varnish-purge-hosts]
hosts =
"hostname/machine/instance";

```
Executar o buildout:

```bash
$ cd /path/to/frontend
$ python bootstrap.py
$ bin/buildout -v
```
