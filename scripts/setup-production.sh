#!/bin/bash

# Script para configurar ambiente de produção local
# Simula um servidor real com auto-update

echo "🚀 Configurando ambiente de produção local..."

# Verificar se Docker está rodando
if ! docker info > /dev/null 2>&1; then
    echo "❌ Docker não está rodando. Inicie o Docker e tente novamente."
    exit 1
fi

# Fazer login no GitHub Container Registry
echo "🔐 Fazendo login no GitHub Container Registry..."
echo "Você precisa de um Personal Access Token com permissões de packages"
echo "Acesse: https://github.com/settings/tokens"
echo "Crie um token com escopo 'write:packages'"
echo ""

# Fazer login
docker login ghcr.io -u dansnasc

if [ $? -eq 0 ]; then
    echo "✅ Login realizado com sucesso!"
else
    echo "❌ Falha no login. Verifique suas credenciais."
    exit 1
fi

# Iniciar ambiente de produção
echo "🚀 Iniciando ambiente de produção..."
docker-compose -f docker-compose.prod.yml up -d

echo "✅ Ambiente de produção configurado!"
echo "🌐 Aplicação disponível em: http://localhost:8080"
echo "📊 Watchtower verificando atualizações a cada 1 minuto"
echo ""
echo "Para ver logs:"
echo "  docker-compose -f docker-compose.prod.yml logs -f"
echo ""
echo "Para parar:"
echo "  docker-compose -f docker-compose.prod.yml down"
