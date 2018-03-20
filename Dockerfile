FROM alpine:latest

# https://github.com/sergey-dryabzhinsky/nginx-rtmp-module/issues/127
ENV NGINX_VERSION 1.9.10
ENV RTMP_MODULE_VERSION 1.2.1

WORKDIR /tmp

RUN	apk update		&&	\
	apk add				\
		git			\
		gcc			\
		binutils-libs		\
		binutils		\
		gmp			\
		isl			\
		libgomp			\
		libatomic		\
		libgcc			\
		openssl			\
		pkgconf			\
		pkgconfig		\
		mpfr3			\
		mpc1			\
		libstdc++		\
		ca-certificates		\
		libssh2			\
		curl			\
		expat			\
		pcre			\
		musl-dev		\
		libc-dev		\
		pcre-dev		\
		zlib-dev		\
		openssl-dev		\
		make


RUN	wget https://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz			&&	\
	wget https://github.com/arut/nginx-rtmp-module/archive/v${RTMP_MODULE_VERSION}.tar.gz

RUN tar xzf v${RTMP_MODULE_VERSION}.tar.gz
RUN	tar xzf nginx-${NGINX_VERSION}.tar.gz
RUN	cd nginx-${NGINX_VERSION}							&&	\
	./configure										\
		--prefix=/opt/nginx								\
		--with-http_ssl_module								\
		--add-module=../nginx-rtmp-module-${RTMP_MODULE_VERSION}					&&	\
	make -j16										&&	\
	make install


FROM    alpine:latest

MAINTAINER Ilya Baturin <ivbaturin@gmail.com>

RUN apk update && apk --no-cache add gettext curl openssl libstdc++ ca-certificates pcre

ENTRYPOINT ["/opt/nginx/bin/run.sh"]

ENV RTMP_PORT=1935 \
    HTTP_PORT=8080

EXPOSE ${RTMP_PORT} \
       ${HTTP_PORT}

COPY --from=0  /opt/nginx/ /opt/nginx/
COPY nginx/ /opt/nginx/
