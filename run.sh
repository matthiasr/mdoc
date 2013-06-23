#!/bin/sh

# test environment
if [ -z "$PORT" ]
then
  PORT=8080
  CANONICAL_NAME="localhost:8080"
  export PORT CANONICAL_NAME
fi

# check mandatory configuration
if [ -z "$CANONICAL_NAME" ]
then
  echo "MISSING CONFIGURATION: Please set \$CANONICAL_NAME." 1>&2
  exit 1
fi

# set dummy revision if none passed in
if [ -z "$REVISION" ]
then
  REVISION="None"
  export REVISION
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
  access_log off;
  error_log stderr info;

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
