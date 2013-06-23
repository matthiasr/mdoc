# build nginx for Bazooka deployment

NGINX_VERSION= 1.5.1
NGINX_CONFIGURE_FLAGS= \
	--with-ipv6 \
	--without-http_ssi_module \
	--without-http_userid_module \
	--without-http_access_module \
	--without-http_auth_basic_module \
	--without-http_autoindex_module \
	--without-http_geo_module \
	--without-http_map_module \
	--without-http_split_clients_module \
	--without-http_referer_module \
	--without-http_proxy_module \
	--without-http_fastcgi_module \
	--without-http_uwsgi_module \
	--without-http_scgi_module \
	--without-http_memcached_module \
	--without-http_limit_conn_module \
	--without-http_limit_req_module \
	--without-http_empty_gif_module \
	--without-http_browser_module \
	--without-http_upstream_ip_hash_module \
	--without-http_upstream_least_conn_module \
	--without-http_upstream_keepalive_module \
	--without-http-cache \
	--prefix=${CURDIR} \
	--sbin-path=${CURDIR} \
	--error-log-path=/dev/stderr \
	--pid-path=/dev/null \
	--lock-path=/tmp/man-$(REVISION).lock \
	--conf-path=$(CURDIR)/nginx.conf

INSTALL= install -c

all: build

build: nginx

nginx-${NGINX_VERSION}.tar.gz:
	curl -O "http://nginx.org/download/$@"

nginx-${NGINX_VERSION}: nginx-${NGINX_VERSION}.tar.gz
	tar xzf $<

nginx-${NGINX_VERSION}/Makefile: nginx-${NGINX_VERSION}
	cd $<; ./configure ${NGINX_CONFIGURE_FLAGS}

nginx-${NGINX_VERSION}/objs/nginx: nginx-${NGINX_VERSION}/Makefile
	${MAKE} -C nginx-${NGINX_VERSION}

nginx: nginx-${NGINX_VERSION}/objs/nginx
	${INSTALL} $< $@

.PHONY: clean clean-all

clean:
	rm -f nginx
	rm -rf nginx-${NGINX_VERSION}

clean-all: clean
	rm -f nginx-*.tar.gz
	rm -rf nginx-*
