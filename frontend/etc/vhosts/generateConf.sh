#!/bin/bash
#./generateConf.sh
TEMPLATE="../templates/portal.conf.in"
if [ -f $TEMPLATE ]; then
    echo "Informe o ID do Site? (ex: plone)"
    read VAR_PORTAL_ID
    if [ ! -z $VAR_PORTAL_ID ]; then
        if [ -f ./$VAR_PORTAL_ID.conf ]; then
            echo "O arquivo $VAR_PORTAL_ID.conf já existe.";
        else
            VAR_MIRROR_NGINX="../../var/www/$VAR_PORTAL_ID/mirror"
            VAR_TMP_NGINX="../../var/www/$VAR_PORTAL_ID/tmp"
            echo "Informe a URL do Site? (ex: www.plone.org)"
            read VAR_PORTAL_URL
            if [ ! -z $VAR_PORTAL_URL ]; then
                
                echo "Deseja restringir o login? (Y ou N)"
                read -r INCLUDE_LOGIN
                if [[ $INCLUDE_LOGIN =~ ^([yY]|[eE]|[sS]|[yY])$ ]]; then
                    RES_LOGIN='';
                else
                    RES_LOGIN='#INCLUDE_LOGIN';
                fi
                echo "Deseja incluir o 'comum'? (Y ou N)"
                read -r INCLUDE_COMUM
                if [[ $INCLUDE_COMUM =~ ^([yY]|[eE]|[sS]|[yY])$ ]]; then
                    COMUM='';
                else
                    COMUM='#INCLUDE_COMUM';
                fi
                
                echo "Gerando arquivo de configuração";
                echo "-------------------------------";
                cat $TEMPLATE | sed -e s/VAR_PORTAL_ID/$VAR_PORTAL_ID/g | sed -e s/VAR_PORTAL_URL/$VAR_PORTAL_URL/g | sed s/#INCLUDE_LOGIN/$RES_LOGIN/g | sed s/#INCLUDE_COMUM/$COMUM/g
                cat $TEMPLATE | sed -e s/VAR_PORTAL_ID/$VAR_PORTAL_ID/g | sed -e s/VAR_PORTAL_URL/$VAR_PORTAL_URL/g | sed s/#INCLUDE_LOGIN/$RES_LOGIN/g | sed s/#INCLUDE_COMUM/$COMUM/g | tee ./$VAR_PORTAL_ID.conf 1>/dev/null;
                echo "-------------------------------";
                echo "O arquivo $VAR_PORTAL_ID.conf foi criado com sucesso!";
                if [ ! -d $VAR_MIRROR_NGINX ]; then
                    mkdir -p $VAR_MIRROR_NGINX;
                    echo "Criando o diretório MIRROR em: $VAR_MIRROR_NGINX";
                fi
                if [ ! -d $VAR_TMP_NGINX ]; then
                    mkdir -p $VAR_TMP_NGINX;
                    echo "Criando o diretório TMP em: $VAR_MIRROR_NGINX";
                fi
            fi
        fi
    else
        echo "Informação inválida";
    fi
else
    echo "O arquivo $TEMPLATE não foi encontrado.";
fi