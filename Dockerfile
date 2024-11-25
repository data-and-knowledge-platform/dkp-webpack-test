FROM node:21-alpine3.19 AS builder
WORKDIR /app
ARG build_env
COPY . ./
RUN export NODE_OPTIONS="--max-old-space-size=8192"
RUN npm install --legacy-peer-deps
RUN npm run build

FROM nginx:alpine
WORKDIR /usr/share/nginx/html
RUN rm -rf ./*
COPY --from=builder /app/build .
WORKDIR /etc/nginx/conf.d/
ARG build_env
COPY ./default.conf.dev ./default.conf
ENTRYPOINT ["nginx", "-g", "daemon off;"]





