FROM ubuntu:jammy-20220428

RUN useradd --create-home --shell /bin/bash jonathan \
    && passwd -d jonathan

RUN apt-get update \
    && apt-get install --yes \
        software-properties-common

RUN add-apt-repository ppa:ubuntu-toolchain-r/test
RUN apt-get update \
    && apt-get install --yes \
        g++-11 \
        g++-12 \
        gcc-11 \
        gcc-12

USER jonathan
WORKDIR /home/jonathan