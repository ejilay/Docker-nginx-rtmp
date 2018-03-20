#!/bin/sh
#set -x

for FILE in $(find /opt/nginx/conf -name '*.envtmpl'); do
    FILE_STRIPPED="${FILE%.*}"
    /usr/bin/envsubst < ${FILE} > ${FILE_STRIPPED}
    if [ "$1" == "show_config" ]; then
        echo ${FILE_STRIPPED}
        cat ${FILE_STRIPPED}
    fi
    rm -f ${FILE}
done

mkdir -p /var/www/streams

if [ -z "$1"  ]; then
    exec /opt/nginx/sbin/nginx -g "daemon off;"
else
    if [ -x $1 ]; then
        exec "$@"
    fi
fi



