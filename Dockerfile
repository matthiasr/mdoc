FROM nginx
ADD nginx_mdoc.conf /etc/nginx_mdoc.conf
ADD nginx_docker.conf /etc/nginx.conf
WORKDIR /etc
CMD ["nginx"]
