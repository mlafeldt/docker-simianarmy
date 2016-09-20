FROM java:8

MAINTAINER Mathias Lafeldt <mathias.lafeldt@gmail.com>

# Install security updates
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update \
    && apt-get upgrade -y \
    && rm -rf /var/lib/apt/lists/*

# Build Simian Army
ENV SIMIANARMY_VERSION v2.5.2
WORKDIR /simianarmy
RUN git clone git://github.com/Netflix/SimianArmy.git . \
    && git checkout -qf $SIMIANARMY_VERSION \
    && ./gradlew build

# Set up confd
ENV CONFD_VERSION 0.12.0-alpha3
RUN curl -fsSL https://github.com/kelseyhightower/confd/releases/download/v${CONFD_VERSION}/confd-${CONFD_VERSION}-linux-amd64 -o /usr/local/bin/confd \
    && chmod +x /usr/local/bin/confd
COPY confd/ /etc/confd

# Configure and start Simian Army
COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
EXPOSE 8080
