#!/bin/bash

# rollback.sh - Script para realizar rollback de uma implantação no Kubernetes

# Verifica se o nome da implantação foi fornecido
if [ -z "$1" ]; then
    echo "Uso: $0 <nome-da-implantacao>"
    exit 1
fi

DEPLOYMENT_NAME=$1

# Obtém a revisão anterior da implantação
PREVIOUS_REVISION=$(kubectl rollout history deployment/$DEPLOYMENT_NAME --revision=$(($(kubectl rollout history deployment/$DEPLOYMENT_NAME | grep -oP '(?<=REVISION\s)[0-9]+' | sort -n | tail -1) - 1)) | grep -oP '(?<=REVISION\s)[0-9]+')

# Verifica se a revisão anterior foi encontrada
if [ -z "$PREVIOUS_REVISION" ]; then
    echo "Não foi possível encontrar a revisão anterior para a implantação $DEPLOYMENT_NAME"
    exit 1
fi

# Realiza o rollback para a revisão anterior
kubectl rollout undo deployment/$DEPLOYMENT_NAME --to-revision=$PREVIOUS_REVISION

# Verifica o status do rollback
if [ $? -eq 0 ]; then
    echo "Rollback da implantação $DEPLOYMENT_NAME para a revisão $PREVIOUS_REVISION realizado com sucesso."
else
    echo "Falha ao realizar rollback da implantação $DEPLOYMENT_NAME."
    exit 1
fi