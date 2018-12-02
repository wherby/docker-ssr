FROM alpine:3.6

LABEL maintainer="https://github.com/starriv"

ENV SSR_SERVER_PORT 7999
ENV SSR_PASSWORD password
ENV SSR_METHOD chacha20
ENV SSR_PROTOCOL auth_sha1_v4
ENV SSR_OBFS http_simple

RUN apk update && \
    apk --no-cache upgrade && \
    apk --no-cache add libsodium git python && \
    cd ~ && \

RUN groupmod -g 1001 node \
  && usermod -u 1001 -g 1001 node
  
RUN mkdir /test && \
    chown -R 1001 /test && \
    chgrp -R 0 /test && \
    chmod -R g+w /test && \
    cd /test && \
    git clone -b manyuser https://github.com/shadowsocksr-backup/shadowsocksr.git





USER 1001

EXPOSE $SSR_SERVER_PORT

CMD python /test/shadowsocksr/shadowsocks/server.py -p $SSR_SERVER_PORT -k $SSR_PASSWORD -m $SSR_METHOD -O $SSR_PROTOCOL -o $SSR_OBFS
