FROM nginx:alpine

WORKDIR /app

COPY ./public .

COPY ./nginx.conf /etc/nginx/nginx.conf
