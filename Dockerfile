FROM rijalati/alpine-zulu-jdk8:8u112
MAINTAINER ritchie@selectstar.io

ENV YCSB_VERSION=0.11.0 \
    YCSB=/opt/ycsb-${YCSB_VERSION} \
    PATH=${PATH}:/usr/bin

RUN cd /opt \
    && curl -Ls https://github.com/brianfrankcooper/YCSB/releases/download/${YCSB_VERSION}/ycsb-${YCSB_VERSION}.tar.gz \
    && tar -xzvf *.tar.gz \
    && rm -fr *.tar.gz


WORKDIR ${YCSB}

ENTRYPOINT ["./bin/ycsb"]
CMD ["--help"]

