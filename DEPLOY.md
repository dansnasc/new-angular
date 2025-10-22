# 🚀 Guia de Deploy Automático - BemAgro

Este documento explica como funciona o pipeline de CI/CD automatizado da aplicação BemAgro.

## 📋 Visão Geral do Pipeline

```
Developer → Pull Request → GitHub Actions → Build → Test → Deploy → Produção
```

## 🔄 Fluxo Automático

### 1. **Pull Request para Main**
- ✅ Lint do código
- ✅ Execução de testes
- ✅ Build da aplicação
- ✅ Criação de Docker image
- ✅ Push para GitHub Container Registry

### 2. **Merge para Main**
- ✅ Deploy automático para produção
- ✅ Health check da aplicação
- ✅ Notificação de status

## 🛠️ Configuração

### **Arquivos Principais:**
- `.github/workflows/ci-cd.yml` - Pipeline GitHub Actions
- `Dockerfile.prod` - Imagem Docker de produção
- `docker-compose.prod.yml` - Orquestração de produção
- `nginx.prod.conf` - Configuração Nginx otimizada
- `scripts/deploy.sh` - Script de deploy manual

### **Variáveis de Ambiente Necessárias:**
```bash
GITHUB_TOKEN          # Token do GitHub (automático)
REGISTRY              # ghcr.io (GitHub Container Registry)
IMAGE_NAME           # dansnasc/new-angular
```

## 🚀 Deploy Manual

### **Opção 1: Deploy Automático (Recomendado)**
```bash
# 1. Fazer merge do PR para main
# 2. GitHub Actions executa automaticamente
# 3. Aplicação fica disponível em produção
```

### **Opção 2: Deploy Manual**
```bash
# 1. Build local
docker build -f Dockerfile.prod -t bemagro-app .

# 2. Deploy local
docker-compose -f docker-compose.prod.yml up -d

# 3. Verificar status
docker-compose -f docker-compose.prod.yml ps
```

### **Opção 3: Script de Deploy**
```bash
# Tornar executável
chmod +x scripts/deploy.sh

# Executar deploy
./scripts/deploy.sh production latest
```

## 🔍 Monitoramento

### **Health Check:**
```bash
# Verificar se aplicação está rodando
curl http://localhost/health

# Ver logs
docker-compose -f docker-compose.prod.yml logs -f
```

### **Status dos Containers:**
```bash
docker-compose -f docker-compose.prod.yml ps
```

## 🛡️ Segurança

### **Headers de Segurança Configurados:**
- `X-Frame-Options: SAMEORIGIN`
- `X-Content-Type-Options: nosniff`
- `X-XSS-Protection: 1; mode=block`
- `Referrer-Policy: strict-origin-when-cross-origin`

### **Otimizações de Performance:**
- Gzip compression habilitado
- Cache de assets estáticos (1 ano)
- Compressão de imagens
- Minificação de CSS/JS

## 🔧 Troubleshooting

### **Problema: Deploy falha**
```bash
# Ver logs do GitHub Actions
# Verificar se todos os testes passaram
# Verificar se Docker image foi criada
```

### **Problema: Aplicação não inicia**
```bash
# Verificar logs do container
docker-compose -f docker-compose.prod.yml logs bemagro-app

# Verificar se porta 80 está livre
netstat -tulpn | grep :80
```

### **Problema: Imagem não encontrada**
```bash
# Verificar se imagem existe
docker images | grep bemagro

# Fazer pull manual
docker pull ghcr.io/dansnasc/new-angular:latest
```

## 📊 Métricas e Monitoramento

### **Watchtower (Auto-update):**
- Atualiza containers automaticamente
- Verifica novas imagens a cada 5 minutos
- Limpa imagens antigas automaticamente

### **Health Check:**
- Endpoint: `/health`
- Intervalo: 30 segundos
- Timeout: 10 segundos
- Retries: 3 tentativas

## 🎯 Próximos Passos

1. **Configurar domínio personalizado**
2. **Adicionar SSL/TLS (Let's Encrypt)**
3. **Configurar backup automático**
4. **Adicionar monitoramento (Prometheus/Grafana)**
5. **Configurar alertas (Slack/Email)**

## 📞 Suporte

Para dúvidas ou problemas:
1. Verificar logs do GitHub Actions
2. Verificar logs dos containers
3. Consultar este documento
4. Abrir issue no repositório
