#base operating system
FROM quay.io/centos/centos:stream10

WORKDIR /app

RUN dnf install -y \
    iproute \
    curl \
    bind-utils \
    procps-ng \
    && dnf clean all

    copy network-health.sh .

    run chmod +x network-health.sh

    CMD ["./network-health.sh"]

    
