FROM debian:stable

RUN apt update && apt install -y hugo

COPY . .

RUN hugo



FROM nginx:alpine

WORKDIR /app

COPY --from=0 ./public .

COPY ./nginx.conf /etc/nginx/nginx.conf
