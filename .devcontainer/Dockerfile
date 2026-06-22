# badprog.com
FROM debian:bookworm-slim

ARG BUILDROOT_VERSION=2024.02.9
ARG BUILDROOT_URL=https://buildroot.org/downloads/buildroot-${BUILDROOT_VERSION}.tar.gz
ARG USERNAME=badprog
ARG WORKDIR_NAME=/workspaces/embedded-linux

# Install all required Buildroot dependencies
RUN apt-get update && apt-get install -y \
    bc \
    binutils \
    build-essential \
    bzip2 \
    cpio \
    file \
    g++ \
    gcc \
    git \
    gzip \
    libncurses-dev \
    libssl-dev \
    make \
    patch \
    perl \
    python3 \
    rsync \
    tar \
    tree \
    unzip \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Create non-root user
RUN useradd -m -u 1000 -s /bin/bash $USERNAME

# Download and extract Buildroot into /opt
WORKDIR /opt
RUN wget -q ${BUILDROOT_URL} && \
    tar xf buildroot-${BUILDROOT_VERSION}.tar.gz && \
    mv buildroot-${BUILDROOT_VERSION} buildroot && \
    rm buildroot-${BUILDROOT_VERSION}.tar.gz && \
    chown -R $USERNAME:$USERNAME /opt/buildroot

# Set up user environment
RUN echo "alias l='ls -la'" >> /home/$USERNAME/.bashrc

# Switch to non-root user and set up workspace entry point
USER $USERNAME
WORKDIR $WORKDIR_NAME