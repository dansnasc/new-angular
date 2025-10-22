# Dockerfile para desenvolvimento Angular BemAgro
# Otimizado para desenvolvimento com hot reload
FROM node:20-alpine

# Instalar dependências do sistema necessárias para Angular
RUN apk add --no-cache git

# Definir diretório de trabalho
WORKDIR /app

# Copiar arquivos de dependências primeiro (para cache de layers)
COPY package*.json ./

# Instalar dependências
RUN npm ci

# Copiar código fonte
COPY . .

# Expor porta do Angular dev server
EXPOSE 4200

# Comando para desenvolvimento com hot reload
CMD ["npm", "run", "start", "--", "--host", "0.0.0.0", "--poll", "2000"]
