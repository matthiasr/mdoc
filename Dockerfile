FROM nginx
RUN rm -f /etc/nginx/conf.d/default.conf
ADD nginx_mdoc.conf /etc/nginx/mdoc.inc
ADD nginx_docker.conf /etc/nginx/conf.d/mdoc.conf
