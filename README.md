# Buildout Plone
### Introdução

A configuração proposta, a seguir, é destinada a aumentar o desempenho de um ambiente de produção para o Plone. 

Para aumentar o desempenho, devemos atingir alguns objetivos:

* O navegador web do usuário deverá armazenar a maior quantidade de informações em cache possível.  
* O servidor de cache (Varnish) deverá otimizar o armazenamento das informações do backend.
* Automatizar a atualização do conteúdo em cache (Varnish).
* Balanceamneto de carga entra as instâncias, para evitar sobrecarga.
* Acesso diferenciado para usuários autenticados e anônimos.
* Os serviços serão gerenciados(start|stop|restart) pelo Supervisor.

### Arquitetura porposta

<img src="https://raw.github.com/andreclimaco/buildout.plone/master/docs/configuration.png"/>


* **Nginx -  servidor web frontend**: interface de comunicação entre o usuário e o Plone.
* **Varnish - cache**: recebe as solicitações do Nginx e decidi se elas serão servidas a partir do cache ou para ser processadas pelas ZEO-Clients/ZEO-Server.
* **HAProxy - load-balancer**: distribui todos as solicitações que vêm do Varnish para cada ZEO-Client.
* **ZEO-Client 1-7/ZEO-Server**: recebe as solicitações do HAProxy e processa as requisições utilizando o ZEO-Server.
* **Supervisor**: monitora os serviços definidos nesta configuração.

## Preparação do ambiente

**Observação:** Antes de tudo, instale os pacotes do sistema operacional necessários para o Plone. [Instruções](http://developer.plone.org/getstarted/installation.html#id6)

Monte seu ambiente python utilizando o virtualenv com python 2.7.

Utilizando o pacote [buildout.python](http://github.com/collective/buildout.python) é possível a montagem do ambiente necessário para a criação do virtualenv.

## Ativando o virtualenv
```bash
$ source /path/to/env/bin/activate
```
## ZEO-Server
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
## Zope Instances - ZEO-Clients
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

## Iniciando os serviços

### ZEO-Server
```bash
$ cd /path/to/zeo
$ ./bin/supervisord
$ ./bin/supervisorctl status

```
### ZEO-Clients
```bash
$ cd /path/to/app
$ ./bin/supervisord
$ ./bin/supervisorctl status

```
### Frontend
```bash
$ cd /path/to/frontend
$ ./bin/supervisord
$ ./bin/supervisorctl status

```

