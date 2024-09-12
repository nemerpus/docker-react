# Fase de construcción
FROM node:16-alpine as builder

WORKDIR '/app'

COPY package.json .
RUN npm install

COPY . .

RUN npm run build

# Fase de producción
FROM nginx

# Copia los archivos estáticos desde el builder a nginx
COPY --from=builder /app/build /usr/share/nginx/html

# Comando de inicio de Nginx
CMD ["nginx", "-g", "daemon off;"]
