FROM alpine:3.6

LABEL maintainer="https://github.com/wherby"

ENV SSR_SERVER_PORT 7999
ENV SSR_PASSWORD password
ENV SSR_METHOD chacha20
ENV SSR_PROTOCOL auth_sha1_v4
ENV SSR_OBFS http_simple

RUN apk update && \
    apk --no-cache upgrade && \
    apk --no-cache add libsodium git python && \
    cd ~

  
RUN mkdir /test && \
    chown -R 1001 /test && \
    chgrp -R 0 /test && \
    chmod -R g+w /test && \
    cd /test && \
    git clone https://github.com/teddysun/shadowsocksr.git


#RUN /test/shadowsocksr/initcfg.sh

RUN apk add -U tzdata

RUN ls /usr/share/zoneinfo

RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

ADD start.sh /test/start.sh
RUN chmod +x /test/start.sh

USER 1001

EXPOSE $SSR_SERVER_PORT

WORKDIR /test

#ENTRYPOINT  /test/shadowsocksr/shadowsocks/server.py -p $SSR_SERVER_PORT -k $SSR_PASSWORD -m $SSR_METHOD -O $SSR_PROTOCOL -o $SSR_OBFS


CMD /test/start.sh
