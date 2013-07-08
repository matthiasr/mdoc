# Copyright (c) 2013 Matthias Rampke <mr@soundcloud.com>
#
# Permission to use, copy, modify, and/or distribute this software for any
# purpose with or without fee is hereby granted, provided that the above
# copyright notice and this permission notice appear in all copies.
#
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
# WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
# ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
# WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
# ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
# OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.



PCRE_VERSION= 8.33
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
	--with-pcre=${CURDIR}/pcre-${PCRE_VERSION} \
	--prefix=${CURDIR} \
	--sbin-path=${CURDIR} \
	--error-log-path=/dev/null \
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

pcre-${PCRE_VERSION}.tar.gz:
	curl -O "ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-${PCRE_VERSION}.tar.gz"

pcre-${PCRE_VERSION}: pcre-${PCRE_VERSION}.tar.gz
	tar xzf $<

nginx-${NGINX_VERSION}/Makefile: nginx-${NGINX_VERSION} pcre-${PCRE_VERSION}
	cd $<; ./configure ${NGINX_CONFIGURE_FLAGS}

nginx-${NGINX_VERSION}/objs/nginx: nginx-${NGINX_VERSION}/Makefile
	${MAKE} -C nginx-${NGINX_VERSION}

nginx: nginx-${NGINX_VERSION}/objs/nginx
	${INSTALL} $< $@

.PHONY: clean clean-all

clean:
	rm -f nginx
	rm -rf nginx-${NGINX_VERSION}
	rm -rf pcre-${PCRE_VERSION}

clean-all: clean
	rm -f nginx-*.tar.gz
	rm -rf nginx-*
	rm -rf pcre-*
