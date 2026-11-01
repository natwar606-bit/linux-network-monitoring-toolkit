#base operating system
FROM quay.io/centos/centos:stream10

WORKDIR /app

RUN dnf install -y \
    iproute \
    curl \
    bind-utils \
    procps-ng \
    hostname \
    && dnf clean all

    COPY network-health.sh .
    RUN chmod +x network-health.sh

    CMD ["./network-health.sh"]

    
