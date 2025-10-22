# 🚀 Guia de Desenvolvimento - BemAgro Angular

Este documento explica o fluxo completo de desenvolvimento com pipeline CI/CD automatizado.

## 📋 Índice

- [Fluxo de Desenvolvimento](#-fluxo-de-desenvolvimento)
- [Cenários de Desenvolvimento](#-cenários-de-desenvolvimento)
- [Comandos de Desenvolvimento](#-comandos-de-desenvolvimento)
- [Monitoramento e Debugging](#-monitoramento-e-debugging)
- [Benefícios do Pipeline](#-benefícios-do-pipeline)
- [Próximos Passos](#-próximos-passos)

## 🔄 Fluxo de Desenvolvimento

### **📝 1. Desenvolvimento Local**

#### **O que você faz:**
```bash
# 1. Fazer mudanças no código
# Editar arquivos em src/

# 2. Testar localmente
npm run docker:up
# Acessa: http://localhost:4300

# 3. Ver mudanças em tempo real
# Hot reload funciona automaticamente
```

#### **O que acontece por trás:**
- ✅ Docker monitora arquivos em `src/`
- ✅ Angular recompila automaticamente
- ✅ Browser atualiza sem refresh
- ✅ Logs aparecem no terminal

---

### **🔄 2. Commit e Push**

#### **O que você faz:**
```bash
# 1. Adicionar mudanças
git add .

# 2. Fazer commit
git commit -m "feat: adicionar nova funcionalidade de mapa"

# 3. Push para GitHub
git push
```

#### **O que acontece automaticamente:**
1. **GitHub recebe o push**
2. **GitHub Actions detecta mudanças**
3. **Pipeline CI/CD inicia automaticamente**

---

### **⚙️ 3. Pipeline Automático (GitHub Actions)**

#### **Etapa 1: Build and Test**
```yaml
# O que acontece automaticamente:
- Checkout do código
- Setup Node.js 20
- Instalar dependências (npm ci)
- Lint do código
- Executar testes
- Build da aplicação
```

#### **Etapa 2: Build Docker (só em main)**
```yaml
# O que acontece automaticamente:
- Setup Docker Buildx
- Login no GitHub Container Registry
- Build da imagem Docker
- Push para ghcr.io/dansnasc/new-angular:latest
```

#### **Etapa 3: Deploy (só em main)**
```yaml
# O que acontece automaticamente:
- Deploy para produção
- Health check da aplicação
- Notificação de status
```

---

### **🌐 4. Deploy Automático**

#### **O que acontece automaticamente:**
1. **Imagem Docker criada** e enviada para GitHub Container Registry
2. **Servidor de produção** baixa a nova imagem
3. **Container antigo** é parado
4. **Container novo** é iniciado
5. **Aplicação fica disponível** em produção

---

## 📋 Cenários de Desenvolvimento

### **🔄 Cenário 1: Desenvolvimento Normal**

```bash
# 1. Você faz mudanças
# 2. Testa localmente (http://localhost:4300)
# 3. Commit + Push
# 4. GitHub Actions executa
# 5. Se for main: Deploy automático
```

### **🔄 Cenário 2: Pull Request**

```bash
# 1. Criar branch feature
git checkout -b feature/nova-funcionalidade

# 2. Fazer mudanças
# 3. Commit + Push
git push origin feature/nova-funcionalidade

# 4. Criar Pull Request no GitHub
# 5. GitHub Actions executa testes
# 6. Review do código
# 7. Merge para main
# 8. Deploy automático
```

### **🔄 Cenário 3: Hotfix**

```bash
# 1. Bug encontrado em produção
# 2. Criar branch hotfix
git checkout -b hotfix/corrigir-bug-critico

# 3. Corrigir bug
# 4. Commit + Push
# 5. Deploy automático após merge
```

---

## 🛠️ Comandos de Desenvolvimento

### **Desenvolvimento:**
```bash
# Iniciar ambiente de desenvolvimento
npm run docker:up

# Ver logs
npm run docker:logs

# Parar ambiente
npm run docker:down

# Acessar shell do container
npm run docker:shell
```

### **Deploy Manual (se necessário):**
```bash
# Deploy manual
./scripts/deploy.sh production latest

# Verificar status
docker-compose -f docker-compose.prod.yml ps
```

### **Scripts Disponíveis:**
```bash
# Desenvolvimento
npm start                    # Servidor de desenvolvimento
npm run docker:up          # Ambiente Docker
npm run docker:down        # Parar ambiente
npm run docker:logs        # Ver logs
npm run docker:shell       # Acessar shell

# Build
npm run build              # Build de desenvolvimento
npm run build:docker       # Build de produção
npm run test               # Executar testes
npm run test:ci            # Testes para CI

# Docker
npm run docker:build       # Build da imagem
npm run docker:run         # Executar container
```

---

## 🔍 Monitoramento e Debugging

### **O que você pode verificar:**

#### **1. Status do Pipeline:**
- **GitHub Actions**: https://github.com/dansnasc/new-angular/actions
- **Logs detalhados** de cada etapa
- **Status** de cada job

#### **2. Imagens Docker:**
- **GitHub Packages**: https://github.com/dansnasc?tab=packages
- **Tags** das versões
- **Tamanho** das imagens

#### **3. Aplicação em Produção:**
- **Health Check**: http://localhost:8080/health
- **Logs**: `docker-compose -f docker-compose.prod.yml logs`
- **Status**: `docker-compose -f docker-compose.prod.yml ps`

### **Comandos de Debug:**
```bash
# Ver logs do container
docker logs bemagro-dev

# Acessar container
docker exec -it bemagro-dev sh

# Ver status dos containers
docker ps

# Ver logs do GitHub Actions
# Acesse: https://github.com/dansnasc/new-angular/actions
```

---

## 🎯 Benefícios do Pipeline

### **Para Você (Desenvolvedor):**
- ✅ **Deploy automático** - não precisa fazer manualmente
- ✅ **Testes automáticos** - bugs são detectados antes do deploy
- ✅ **Rollback fácil** - pode voltar para versão anterior
- ✅ **Ambiente consistente** - mesmo ambiente em dev e prod
- ✅ **Foco no código** - infraestrutura é automática

### **Para o Projeto:**
- ✅ **Qualidade** - testes obrigatórios
- ✅ **Segurança** - headers de segurança automáticos
- ✅ **Performance** - build otimizado
- ✅ **Disponibilidade** - health checks automáticos
- ✅ **Escalabilidade** - fácil de replicar

---

## 🚀 Próximos Passos

### **1. Configurar Servidor Real:**
- Configurar servidor de produção
- Configurar domínio personalizado
- Configurar SSL/TLS

### **2. Melhorar Pipeline:**
- Adicionar testes E2E
- Configurar notificações (Slack/Email)
- Adicionar métricas de performance

### **3. Monitoramento:**
- Configurar logs centralizados
- Adicionar alertas
- Configurar backup automático

---

## 📚 Arquivos Importantes

### **Configuração Docker:**
- `Dockerfile` - Desenvolvimento
- `Dockerfile.prod` - Produção
- `docker-compose.yml` - Desenvolvimento
- `docker-compose.prod.yml` - Produção
- `nginx.prod.conf` - Configuração Nginx

### **Pipeline CI/CD:**
- `.github/workflows/ci-cd.yml` - Pipeline GitHub Actions
- `scripts/deploy.sh` - Script de deploy manual

### **Documentação:**
- `README.md` - Documentação principal
- `DEPLOY.md` - Guia de deploy
- `DEVELOPMENT.md` - Este arquivo

---

## 🔧 Troubleshooting

### **Problemas Comuns:**

#### **1. Pipeline falha:**
```bash
# Verificar logs no GitHub Actions
# Verificar se todos os testes passaram
# Verificar se Docker image foi criada
```

#### **2. Aplicação não inicia:**
```bash
# Verificar logs do container
docker logs bemagro-dev

# Verificar se porta está livre
netstat -tulpn | grep :4300
```

#### **3. Hot reload não funciona:**
```bash
# Verificar se volumes estão montados
docker-compose exec app ls -la /app/src

# Reiniciar com volumes limpos
docker-compose down -v
docker-compose up -d
```

---

## 📞 Suporte

Para dúvidas ou problemas:
1. Verificar logs do GitHub Actions
2. Verificar logs dos containers
3. Consultar este documento
4. Abrir issue no repositório

---

## 🎉 Conclusão

Agora você tem um pipeline completo de CI/CD que:
- ✅ **Automatiza** todo o processo de deploy
- ✅ **Garante qualidade** com testes automáticos
- ✅ **Facilita desenvolvimento** com hot reload
- ✅ **Mantém consistência** entre ambientes
- ✅ **Permite foco** no desenvolvimento de features

**Bom desenvolvimento!** 🚀
