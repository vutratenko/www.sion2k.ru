FROM debian:stable

RUN apt update && apt install -y hugo

WORKDIR /app

COPY . .

RUN hugo; ls -l 



FROM nginx:alpine

WORKDIR /app/public

COPY --from=0 ./app/public .

WORKDIR /app

COPY ./nginx.conf /etc/nginx/nginx.conf
