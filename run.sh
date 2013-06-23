#!/bin/sh

# test environment
if [ -z "$PORT" ]
then
  PORT=8080
  REVISION=testing
  CANONICAL_NAME="localhost:8080"
  export PORT REVISION CANONICAL_NAME
elif [ -z "$CANONICAL_NAME" ]
then
  CANONICAL_NAME="man.int.s-cloud.net"
  export CANONICAL_NAME
fi

if [ -d /dev/shm ]
then
  TMPDIR=/dev/shm
else
  TMPDIR=/tmp
fi

cat >$TMPDIR/man-$REVISION-$PORT.conf <<EOF
daemon off;
lock_file $TMPDIR/man-$REVISION-$PORT.lock;
pid $TMPDIR/man-$REVISION-$PORT.pid;

events {

}

http {
  access_log /dev/stdout;
  error_log /dev/stderr;

  client_body_temp_path $TMPDIR/man-$REVISION-$PORT;

  server {
    listen *:$PORT;

    set \$port "$PORT";
    set \$revision "$REVISION";
    set \$canonical_name "$CANONICAL_NAME";

    include $PWD/nginx.conf;
  }
}
EOF

exec $PWD/nginx -c /$TMPDIR/man-$REVISION-$PORT.conf
