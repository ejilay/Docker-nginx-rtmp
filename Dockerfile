FROM    alpine:latest

MAINTAINER Ilya Baturin <ivbaturin@gmail.com>

RUN apk update && apk --no-cache add gettext curl openssl libstdc++ ca-certificates pcre

ENTRYPOINT ["/opt/nginx/bin/run.sh"]

ENV RTMP_PORT=1935 \
    HTTP_PORT=8080

EXPOSE ${RTMP_PORT} \
       ${HTTP_PORT}

ADD	nginx.tar.gz /opt/
COPY nginx/ /opt/nginx/
