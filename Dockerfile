FROM docker:stable

LABEL 'name'='Docker Deployment Action'
LABEL 'maintainer'='Al-waleed Shihadeh <wshihadeh.dev@gmail.com>'

LABEL 'com.github.actions.name'='Docker Deployment'
LABEL 'com.github.actions.description'='supports docker-compose and Docker Swarm deployments'
LABEL 'com.github.actions.icon'='send'
LABEL 'com.github.actions.color'='green'

RUN apk add --no-cache \
    curl \
    openssh-client \
    bash \
    git \
    ca-certificates \
    wget \
    gnupg \
    openrc

# Remove any pre-installed Docker (if applicable)
#RUN apk del docker

# Add Docker's official GPG key
RUN curl -fsSL https://download.docker.com/linux/static/stable/x86_64/docker-20.10.9.tgz -o docker.tgz \
    && tar xzvf docker.tgz \
    && mv docker/* /usr/local/bin/ \
    && rm docker.tgz

# Install Docker Compose
RUN curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose \
    && chmod +x /usr/local/bin/docker-compose

# Verify Docker version
RUN docker --version

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh
RUN ls -l /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
