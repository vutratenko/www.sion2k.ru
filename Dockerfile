FROM debian:stable

RUN apt update && apt install -y hugo

WORKDIR /app

COPY . .

RUN ls -l; hugo



FROM nginx:alpine

WORKDIR /app

COPY --from=0 ./app/public .

COPY ./nginx.conf /etc/nginx/nginx.conf
