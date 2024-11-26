#FROM node:21-alpine3.19 AS builder
FROM masdkpacr.azurecr.io/dkpalpine:latest AS builder
WORKDIR /app
ARG build_env
COPY . ./
RUN apk add --no-cache nodejs npm
RUN export NODE_OPTIONS="--max-old-space-size=8192"
RUN npm install -g npm@10.7.0
RUN npm install --legacy-peer-deps
#RUN npm run build
RUN npm run build:production

#FROM nginx:alpine
FROM nginx:alpine AS nginx-base
WORKDIR /usr/share/nginx/html
RUN rm -rf ./*
COPY --from=builder /app/build .
WORKDIR /etc/nginx/conf.d/
ARG build_env
COPY ./default.conf.dev ./default.conf
ENTRYPOINT ["nginx", "-g", "daemon off;"]





