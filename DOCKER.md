# Docker para Desenvolvimento - BemAgro

Este documento explica como configurar e usar o Docker para desenvolvimento da aplicação Angular BemAgro.

## 🚀 Início Rápido

### Pré-requisitos
- Docker Desktop instalado
- Docker Compose instalado

### Comandos Principais

```bash
# Iniciar ambiente de desenvolvimento
npm run docker:up

# Parar ambiente
npm run docker:down

# Ver logs da aplicação
npm run docker:logs

# Acessar shell do container
npm run docker:shell
```

## 📁 Estrutura de Arquivos Docker

```
projeto/
├── Dockerfile              # Configuração do container Angular
├── docker-compose.yml      # Orquestração dos serviços
├── .dockerignore          # Arquivos ignorados no build
├── nginx.conf             # Configuração do proxy reverso
└── DOCKER.md              # Esta documentação
```

## 🔧 Configuração Detalhada

### Dockerfile
- **Base**: Node.js 20 Alpine (leve e rápido)
- **Porta**: 4200 (Angular dev server)
- **Hot Reload**: Habilitado com polling para Windows
- **Volumes**: Código fonte montado para desenvolvimento

### Docker Compose
- **Serviço app**: Aplicação Angular principal
- **Serviço nginx**: Proxy reverso (opcional)
- **Volumes**: Hot reload configurado
- **Rede**: Rede isolada para comunicação entre serviços

## 🛠️ Scripts Disponíveis

| Script | Descrição |
|--------|-----------|
| `npm run docker:up` | Inicia ambiente completo |
| `npm run docker:down` | Para todos os serviços |
| `npm run docker:logs` | Mostra logs em tempo real |
| `npm run docker:shell` | Acessa shell do container |
| `npm run docker:build` | Constrói imagem Docker |
| `npm run start:docker` | Inicia Angular com configurações Docker |

## 🌐 Acesso à Aplicação

- **Desenvolvimento**: http://localhost:4200
- **Com Nginx**: http://localhost:80 (quando habilitado)

## 🔄 Hot Reload

O hot reload está configurado para funcionar perfeitamente:
- Arquivos em `src/` são monitorados
- Mudanças são refletidas automaticamente
- Polling configurado para Windows (2000ms)

## 🐛 Troubleshooting

### Container não inicia
```bash
# Verificar logs
npm run docker:logs

# Reconstruir imagem
docker-compose build --no-cache
```

### Hot reload não funciona
```bash
# Verificar se volumes estão montados
docker-compose exec app ls -la /app/src

# Reiniciar com volumes limpos
docker-compose down -v
docker-compose up -d
```

### Porta já em uso
```bash
# Verificar processos na porta 4200
netstat -ano | findstr :4200

# Parar processo ou mudar porta no docker-compose.yml
```

## 📦 Produção

Para build de produção:

```bash
# Build otimizado
npm run build:docker

# Usar nginx para servir arquivos estáticos
docker-compose --profile production up -d
```

## 🔧 Personalização

### Alterar Porta
Edite `docker-compose.yml`:
```yaml
ports:
  - "3000:4200"  # Muda para porta 3000
```

### Adicionar Variáveis de Ambiente
```yaml
environment:
  - NODE_ENV=development
  - API_URL=http://localhost:3000
```

### Configurar Banco de Dados
Adicione serviço no `docker-compose.yml`:
```yaml
services:
  database:
    image: postgres:15
    environment:
      POSTGRES_DB: bemagro
      POSTGRES_USER: user
      POSTGRES_PASSWORD: password
```

## 📚 Recursos Adicionais

- [Docker Documentation](https://docs.docker.com/)
- [Angular Docker Guide](https://angular.io/guide/docker)
- [Docker Compose Reference](https://docs.docker.com/compose/)
