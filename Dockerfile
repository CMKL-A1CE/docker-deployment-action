FROM alpine:3.14

LABEL 'name'='Docker Deployment Action'
LABEL 'maintainer'='Al-waleed Shihadeh <wshihadeh.dev@gmail.com>'

LABEL 'com.github.actions.name'='Docker Deployment'
LABEL 'com.github.actions.description'='supports docker-compose and Docker Swarm deployments'
LABEL 'com.github.actions.icon'='send'
LABEL 'com.github.actions.color'='green'


RUN apk --no-cache add \
    curl \
    bash \
    ca-certificates \
    openrc \
    gnupg \
    shadow \
    device-mapper \
    iptables \
    eudev \
    util-linux \
    openssh  # Install OpenSSH for ssh-agent and ssh-add

# Download and install Docker 26.x
RUN curl -fsSL https://download.docker.com/linux/static/stable/x86_64/docker-26.0.0.tgz -o docker.tgz \
    && tar xzvf docker.tgz \
    && mv docker/* /usr/local/bin/ \
    && rm docker.tgz

# Install Docker Compose (latest version)
RUN curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose \
    && chmod +x /usr/local/bin/docker-compose

# Verify Docker version
RUN docker --version

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
