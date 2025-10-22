#!/bin/bash

# Script para configurar autenticação do Watchtower
# Este script deve ser executado antes de iniciar o docker-compose

echo "🔐 Configurando autenticação para Watchtower..."

# Verificar se o usuário está logado
if ! docker info > /dev/null 2>&1; then
    echo "❌ Docker não está rodando ou usuário não está logado"
    exit 1
fi

# Fazer login no GitHub Container Registry
echo "🔑 Fazendo login no GitHub Container Registry..."
echo "Digite seu token do GitHub quando solicitado:"
docker login ghcr.io -u dansnasc

# Verificar se o login funcionou
if docker pull ghcr.io/dansnasc/new-angular:latest > /dev/null 2>&1; then
    echo "✅ Login realizado com sucesso!"
    echo "🚀 Agora você pode iniciar o docker-compose com autenticação"
else
    echo "❌ Falha na autenticação. Verifique seu token."
    exit 1
fi