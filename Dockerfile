FROM alpine:3.14

LABEL 'name'='Docker Deployment Action'
LABEL 'maintainer'='Al-waleed Shihadeh <wshihadeh.dev@gmail.com>'

LABEL 'com.github.actions.name'='Docker Deployment'
LABEL 'com.github.actions.description'='supports docker-compose and Docker Swarm deployments'
LABEL 'com.github.actions.icon'='send'
LABEL 'com.github.actions.color'='green'

# Install Docker from Alpine repository
RUN apk add --no-cache \
    docker \
    curl \
    bash \
    git \
    openssh-client \
    ca-certificates \
    wget \
    gnupg \
    openrc

# Install the latest Docker Compose binary
RUN curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose \
    && chmod +x /usr/local/bin/docker-compose

# Verify Docker and Docker Compose versions
RUN docker --version && docker-compose --version

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh
RUN ls -l /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
