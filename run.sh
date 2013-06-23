#!/bin/sh

# test environment

[ -z "$PORT" ] && export PORT=8080
[ -z "$REVISION" ] && export REVISION="deafbeef"

cat >/tmp/man-$REVISION-$PORT.conf <<EOF
daemon off;
lock_file /tmp/man-$REVISION-$PORT.lock;
pid /tmp/man-$REVISION-$PORT.pid;

events {

}

http {
  access_log /dev/stdout;
  error_log /dev/stderr;

  server {
    listen *:$PORT;

    include $PWD/nginx.conf;
  }
}
EOF

exec $PWD/nginx -c /tmp/man-$REVISION-$PORT.conf
