FROM java:8

MAINTAINER Mathias Lafeldt <mathias.lafeldt@gmail.com>

ENV SIMIANARMY_VERSION master
WORKDIR /simianarmy
RUN git clone git://github.com/Netflix/SimianArmy.git . \
    && git checkout -qf $SIMIANARMY_VERSION \
    && ./gradlew build

ENV CONFD_VERSION 0.12.0-alpha3
RUN curl -fsSL https://github.com/kelseyhightower/confd/releases/download/v${CONFD_VERSION}/confd-${CONFD_VERSION}-linux-amd64 -o /usr/local/bin/confd \
    && chmod +x /usr/local/bin/confd
COPY confd/ /etc/confd

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
EXPOSE 8080
