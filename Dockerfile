FROM ubuntu:jammy-20220428

RUN useradd --create-home --shell /bin/bash jonathan \
    && passwd -d jonathan

USER jonathan
WORKDIR /home/jonathan