#!/bin/sh

if [ ! -z $UID ]
then
    adduser -u $UID -s /bin/sh -D restic
    chown restic:restic .
    user=$UID
    su restic -c 'echo ''$DBHOST:5432:$DBNAME:$DBUSER:$DBPASSWORD'' > ~/.pgpass'
    su restic -c 'chmod 0600 ~/.pgpass'
    su restic -c 'pg_dump -f $DUMP -h $DBHOST -U $DBUSER $DBNAME'
    su restic -c 'restic --no-cache backup $DUMP'
    exit 0
fi

echo '$DBHOST:5432:$DBNAME:$DBUSER:$DBPASSWORD' > ~/.pgpass
chmod 0600 ~/.pgpass
pg_dump -f $DUMP -h $DBHOST -U $DBUSER $DBNAME
restic --no-cache backup $DUMP
