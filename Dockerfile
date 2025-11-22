##############################
# STAGE 1: BUILD EVERYTHING  #
##############################
FROM debian:bookworm-slim AS build

ENV PYTHONUNBUFFERED=1

# Install build dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        build-essential wget git flex bison \
        libgmp-dev libssl-dev libffi-dev \
        zlib1g-dev libbz2-dev libreadline-dev \
        libsqlite3-dev libncurses5-dev liblzma-dev \
        tk-dev uuid-dev autoconf automake libtool \
        xz-utils ca-certificates && \
    rm -rf /var/lib/apt/lists/*


#################################################
# Build Python 3.7
#################################################
WORKDIR /tmp/python37

RUN wget https://www.python.org/ftp/python/3.7.17/Python-3.7.17.tgz && \
    tar -xf Python-3.7.17.tgz && \
    cd Python-3.7.17 && \
    ./configure --with-lto && \
    make -j16 && \
    make install && \
    cd / && rm -rf /tmp/python37

RUN python3.7 -m ensurepip && \
    python3.7 -m pip install --upgrade pip setuptools wheel && \
    rm -rf /root/.cache/pip

# Remove unused Python modules to save space
RUN rm -rf \
    /usr/local/lib/python3.7/test \
    /usr/local/lib/python3.7/ensurepip \
    /usr/local/lib/python3.7/idlelib \
    /usr/local/lib/python3.7/tkinter \
    /usr/local/lib/python3.7/lib2to3 \
    /usr/local/lib/python3.7/distutils/tests

# Strip debug symbols from Python binaries
RUN strip --strip-unneeded /usr/local/bin/python3.7 || true && \
    strip --strip-unneeded /usr/local/lib/python3.7/lib-dynload/*.so || true


#################################################
# Build PBC
#################################################
WORKDIR /tmp/pbc

RUN wget https://crypto.stanford.edu/pbc/files/pbc-0.5.14.tar.gz && \
    tar xf pbc-0.5.14.tar.gz && \
    cd pbc-0.5.14 && \
    ./configure && \
    make -j16 && \
    make install && \
    ldconfig && \
    cd / && rm -rf /tmp/pbc


#################################################
# Build Charm-Crypto
#################################################
WORKDIR /tmp/charm

RUN git clone https://github.com/JHUISI/charm . && \
    python3.7 -m pip install -r requirements.txt && \
    ./configure.sh --python=/usr/local/bin/python3.7 && \
    make -j16 && \
    make install && \
    ldconfig && \
    cd / && rm -rf /tmp/charm



##############################
# STAGE 2: RUNTIME CONTAINER #
##############################
FROM debian:bookworm-slim AS runtime

ENV PYTHONUNBUFFERED=1

# Install only minimal runtime dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        libgmp10 libssl3 libffi8 libbz2-1.0 \
        liblzma5 libreadline8 libsqlite3-0 zlib1g \
        ca-certificates && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/*

##############################
# Copy runtime binaries
##############################
COPY --from=build /usr/local /usr/local

# Linker config for PBC
RUN echo "/usr/local/lib" > /etc/ld.so.conf.d/usr-local.conf && ldconfig

# Slim down locales & docs
RUN rm -rf /usr/share/locale/* /usr/local/share/locale/* \
           /usr/share/man /usr/share/doc /usr/share/info

WORKDIR /app
CMD ["tail", "-f", "/dev/null"]
