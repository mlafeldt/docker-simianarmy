FROM java:8

MAINTAINER Mathias Lafeldt <mathias.lafeldt@gmail.com>

ENV SIMIANARMY_VERSION 79f5263

WORKDIR /simianarmy

RUN git clone git://github.com/Netflix/SimianArmy.git . \
    && git checkout -qf $SIMIANARMY_VERSION \
    && ./gradlew build

COPY config/*.properties src/main/resources/

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
