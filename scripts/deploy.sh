#!/bin/bash

# Script de Deploy Automático - BemAgro
# Uso: ./scripts/deploy.sh [environment]

set -e

ENVIRONMENT=${1:-production}
IMAGE_TAG=${2:-latest}

echo "🚀 Iniciando deploy para $ENVIRONMENT..."

# Verificar se Docker está rodando
if ! docker info > /dev/null 2>&1; then
    echo "❌ Docker não está rodando. Inicie o Docker e tente novamente."
    exit 1
fi

# Parar containers existentes
echo "🛑 Parando containers existentes..."
docker-compose -f docker-compose.prod.yml down || true

# Remover imagens antigas (opcional)
echo "🧹 Limpando imagens antigas..."
docker image prune -f || true

# Pull da imagem mais recente
echo "📥 Baixando imagem mais recente..."
docker pull ghcr.io/dansnasc/new-angular:$IMAGE_TAG

# Iniciar novos containers
echo "🚀 Iniciando aplicação..."
docker-compose -f docker-compose.prod.yml up -d

# Verificar se a aplicação está rodando
echo "🔍 Verificando status da aplicação..."
sleep 10

if curl -f http://localhost/health > /dev/null 2>&1; then
    echo "✅ Deploy realizado com sucesso!"
    echo "🌐 Aplicação disponível em: http://localhost"
else
    echo "❌ Falha no deploy. Verifique os logs:"
    docker-compose -f docker-compose.prod.yml logs
    exit 1
fi

echo "📊 Status dos containers:"
docker-compose -f docker-compose.prod.yml ps
