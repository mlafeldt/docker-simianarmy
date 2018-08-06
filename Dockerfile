FROM openjdk:8-alpine

MAINTAINER Mathias Lafeldt <mathias.lafeldt@gmail.com>

ENV SIMIANARMY_VERSION v2.5.3
ENV CONFD_VERSION      0.16.0

WORKDIR /simianarmy

RUN apk update \
    && apk upgrade \
    && apk add bash curl git \
    && git clone git://github.com/Netflix/SimianArmy.git . \
    && git checkout -qf $SIMIANARMY_VERSION \
    && ./gradlew build --no-daemon \
    && curl -fsSL https://github.com/kelseyhightower/confd/releases/download/v${CONFD_VERSION}/confd-${CONFD_VERSION}-linux-amd64 -o /usr/local/bin/confd \
    && chmod +x /usr/local/bin/confd

COPY confd/ /etc/confd

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 8080
