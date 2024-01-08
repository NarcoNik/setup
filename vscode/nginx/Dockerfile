FROM node:16 as builder
WORKDIR /app
COPY package.json /app/package.json
RUN npm install --force
COPY . /app
CMD [ "npm", "run", "start" ]

# FROM node:alpine as builder

# # send signal to containers to stop them
# STOPSIGNAL SIGTERM

# # create working directory
# RUN mkdir -p /usr/src/reactapp

# # set working directory
# WORKDIR /usr/src/reactapp

# # copy package.json file to working directory
# COPY . .

# FROM nginx:alpine as reactapp

# # Install a self signed SSL certificate with no locally cached packages
# # FROM debian:11.6-slim
# #тут наверное лучше использоваться какой-то более простой и лёгкий образ
# FROM ubuntu:22.04

# # Open SSL Version pinning - https://debian.pkgs.org/11/debian-main-amd64/openssl_1.1.1n-0+deb11u3_amd64.deb.html
# RUN apt update && apt install -y --no-install-recommends nginx openssl \
#     && apt clean \
#     && rm -rf /var/lib/apt/lists/* \
#     && openssl req \
#       -x509 \
#       -subj "/C=KE/ST=Nairobi/L=Nairobi/O=Company Name Ltd/OU=Portfolio website/CN=localhost" \
#       -nodes \
#       -days 365 \
#       -new \
#       -newkey rsa:2048 \
#       -keyout /etc/ssl/private/nginx-selfsigned.key \
#       -out /etc/ssl/certs/nginx-selfsigned.crt

# RUN rm -rf /usr/share/nginx/html/*

# #зачем плодить лишние команды??)) их можно плодить когда отлаживаешь и не знаешь на каком этапе ломается сборка
# COPY --from=builder /usr/src/reactapp/nginx/* /etc/nginx/

# COPY --from=builder /usr/src/reactapp/build /usr/share/nginx/html

# #не понадобится 443, тк будем делать прокси за докером
# EXPOSE 80

# CMD ["/bin/bash", "-c", "nginx -g daemon off;"]
# # CMD ["/bin/bash", "-c", "nginx -g \"daemon off;\""]



# FROM nginx:alpine

# RUN rm -rf /usr/share/nginx/html/*

# COPY /nginx/nginx.conf /etc/nginx/nginx.conf
# COPY /nginx/nginxconfig/general.conf /etc/nginx/general.conf
# COPY /nginx/nginxconfig/security.conf /etc/nginx/security.conf
# COPY build /usr/share/nginx/html

# RUN touch /var/run/nginx.pid
# RUN chown -R nginx:nginx /var/run/nginx.pid /usr/share/nginx/html /var/cache/nginx /var/log/nginx /etc/nginx/conf.d
# USER nginx

# EXPOSE 80 443
# ENTRYPOINT ["nginx", "-g", "daemon off;"]

# # sudo apt update && sudo apt -y install --no-install-recommends nginx openssl && sudo apt clean && sudo rm -rf /var/lib/apt/lists/*

# # sudo openssl req -x509 -subj "/C=KE/ST=Nairobi/L=Nairobi/O=Company Name Ltd/OU=Portfolio website/CN=localhost" -nodes -days 365 -new -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt