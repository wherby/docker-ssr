FROM centos:7

LABEL maintainer="https://github.com/wherby"


RUN mkdir /test && \
    chown -R 1001 /test && \
    chgrp -R 0 /test && \
    chmod -R g+w /test && \
    cd /test 

WORKDIR  /test

ADD shadowsocksR.sh /test/shadowsocksR.sh


RUN chmod +x shadowsocksR.sh
#RUN /test/shadowsocksR.sh 2>&1 
#RUN /test/shadowsocksr/initcfg.sh


#USER 1001

EXPOSE $SSR_SERVER_PORT

#CMD python /test/shadowsocksr/shadowsocks/server.py -p $SSR_SERVER_PORT -k $SSR_PASSWORD -m $SSR_METHOD -O $SSR_PROTOCOL -o $SSR_OBFS
