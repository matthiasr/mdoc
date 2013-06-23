#!/bin/sh

# test environment
if [ -z "$PORT" ]
then
  PORT=8080
  REVISION=testing
  CANONICAL_NAME="localhost:8080"
  export PORT REVISION CANONICAL_NAME
else
  CANONICAL_NAME="man.int.s-cloud.net"
  export CANONICAL_NAME
fi

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

    set \$port "$PORT";
    set \$revision "$REVISION";
    set \$canonical_name "$CANONICAL_NAME";

    include $PWD/nginx.conf;
  }
}
EOF

exec $PWD/nginx -c /tmp/man-$REVISION-$PORT.conf
