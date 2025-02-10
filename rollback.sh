#!/bin/bash

# Nome do deployment
DEPLOYMENT_NAME="httpd"

# Namespace (se aplicável)
NAMESPACE="default"

# Executa o rollback do deployment
kubectl rollout undo deployment/$DEPLOYMENT_NAME --namespace=$NAMESPACE

# Verifica o status do rollback
kubectl rollout status deployment/$DEPLOYMENT_NAME --namespace=$NAMESPACE