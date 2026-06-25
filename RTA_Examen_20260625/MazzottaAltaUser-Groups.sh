#!/bin/bash

USUARIO_REF=$1
LISTA=$2

if [[ -z "$USUARIO_REF" || -z "$LISTA" ]]; then
    echo "Uso: $0 <usuario_referencia> <path_lista_usuarios>"
    exit 1
fi

if [[ ! -f "$LISTA" ]]; then
    echo "ERROR: No se encontro el archivo $LISTA"
    exit 1
fi

PASS_HASH=$(sudo grep "^${USUARIO_REF}:" /etc/shadow | cut -d: -f2)

if [[ -z "$PASS_HASH" ]]; then
    echo "ERROR: No se pudo obtener la clave del usuario $USUARIO_REF"
    exit 1
fi

ANT_IFS=$IFS
IFS=$'\n'

for LINEA in `cat $LISTA | grep -v ^#`
do
    USUARIO=$(echo $LINEA  | awk -F ',' '{print $1}')
    GRUPO=$(echo $LINEA    | awk -F ',' '{print $2}')
    HOME_DIR=$(echo $LINEA | awk -F ',' '{print $3}')

    if ! getent group $GRUPO > /dev/null 2>&1; then
        sudo groupadd $GRUPO
        echo "[OK] Grupo creado: $GRUPO"
    else
        echo "[INFO] Grupo ya existe: $GRUPO"
    fi

    if ! id $USUARIO > /dev/null 2>&1; then
        sudo useradd -m -d $HOME_DIR -g $GRUPO -s /bin/bash $USUARIO
        sudo usermod -p $PASS_HASH $USUARIO
        echo "[OK] Usuario creado: $USUARIO | Grupo: $GRUPO | Home: $HOME_DIR"
    else
        echo "[INFO] Usuario ya existe: $USUARIO"
    fi

done

IFS=$ANT_IFS
