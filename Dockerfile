FROM rijalati/alpine-zulu-jdk8:latest-mini
MAINTAINER ritchie@selectstar.io

ENV YCSB_VERSION=0.12.0 \
    PATH=${PATH}:/usr/bin

RUN apk --update --no-cache add python \
    && cd /opt \
    && eval curl "-Ls https://github.com/brianfrankcooper/YCSB/releases/download/${YCSB_VERSION}/ycsb-${YCSB_VERSION}.tar.gz" \
    | tar -xzvf -


WORKDIR "/opt/ycsb-${YCSB_VERSION}"

ENTRYPOINT ["./bin/ycsb"]
CMD ["--help"]

