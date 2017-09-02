FROM java:8

MAINTAINER Mathias Lafeldt <mathias.lafeldt@gmail.com>

ENV SIMIANARMY_VERSION v2.5.3
ENV CONFD_VERSION 0.13.0
ENV DEBIAN_FRONTEND noninteractive

WORKDIR /simianarmy

RUN apt-get update \
    && apt-get upgrade -y \
    && git clone git://github.com/Netflix/SimianArmy.git . \
    && git checkout -qf $SIMIANARMY_VERSION \
    && ./gradlew build --no-daemon \
    && curl -fsSL https://github.com/kelseyhightower/confd/releases/download/v${CONFD_VERSION}/confd-${CONFD_VERSION}-linux-amd64 -o /usr/local/bin/confd \
    && chmod +x /usr/local/bin/confd \
    && rm -rf /var/lib/apt/lists/*

COPY confd/ /etc/confd

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 8080
