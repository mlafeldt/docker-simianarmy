FROM java:8

MAINTAINER Mathias Lafeldt <mathias.lafeldt@gmail.com>

ENV SIMIANARMY_VERSION 79f5263

RUN git clone git://github.com/Netflix/SimianArmy.git /src \
    && cd /src \
    && git checkout -qf $SIMIANARMY_VERSION \
    && ./gradlew build

WORKDIR /src

COPY config/*.properties src/main/resources/

ENTRYPOINT ["./gradlew"]
CMD ["jettyRun"]
