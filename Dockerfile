FROM ubuntu:jammy
RUN yes | unminimize \
    && apt-get update \
    && apt-get upgrade --yes \
    && apt-get clean

RUN useradd --create-home --shell /bin/bash --group sudo jonathan \
    && passwd -d jonathan

RUN apt-get update \
    && apt-get install --yes \
        apt-transport-https \
        curl \
        gnupg \
        software-properties-common \
        wget

RUN add-apt-repository ppa:ubuntu-toolchain-r/test
RUN apt-get update \
    && apt-get install --yes \
        g++-11 \
        g++-12 \
        gcc-11 \
        gcc-12

RUN wget --output-document=- https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add - \
    && apt-add-repository 'deb http://apt.llvm.org/jammy/ llvm-toolchain-jammy-14 main' \
    && apt-add-repository 'deb http://apt.llvm.org/jammy/ llvm-toolchain-jammy main'
RUN apt-get update \
    && apt-get install --yes \
        clang-14 \
        clang-15 \
        clang-format-14 \
        clang-format-15 \
        clang-tidy-14 \
        clang-tidy-15 \
        clang-tools-14 \
        clang-tools-15 \
        clangd-14 \
        clangd-15
RUN update-alternatives --install /usr/bin/clang clang /usr/bin/clang-14 14 \
    && update-alternatives --install /usr/bin/clang clang /usr/bin/clang-15 15
RUN update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-14 14 \
    && update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-15 15
RUN update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-14 14 \
    && update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-15 15
RUN update-alternatives --install /usr/bin/clang-apply-replacements clang-apply-replacements /usr/bin/clang-apply-replacements-14 14 \
    && update-alternatives --install /usr/bin/clang-apply-replacements clang-apply-replacements /usr/bin/clang-apply-replacements-15 15
RUN update-alternatives --install /usr/bin/clang-format clang-format /usr/bin/clang-format-14 14 \
    && update-alternatives --install /usr/bin/clang-format clang-format /usr/bin/clang-format-15 15
RUN update-alternatives --install /usr/bin/clang-tidy clang-tidy /usr/bin/clang-tidy-14 14 \
    && update-alternatives --install /usr/bin/clang-tidy clang-tidy /usr/bin/clang-tidy-15 15
RUN update-alternatives --install /usr/bin/git-clang-format git-clang-format /usr/bin/git-clang-format-14 14 \
    && update-alternatives --install /usr/bin/git-clang-format git-clang-format /usr/bin/git-clang-format-15 15

RUN add-apt-repository ppa:git-core/ppa
RUN curl --fail --silent --show-error --location https://bazel.build/bazel-release.pub.gpg | gpg --dearmor > /etc/apt/trusted.gpg.d/bazel.gpg \
    && echo "deb [arch=amd64] https://storage.googleapis.com/bazel-apt stable jdk1.8" | tee /etc/apt/sources.list.d/bazel.list
RUN apt-get update \
    && apt-get install --yes \
        ack \
        atop \
        bash-completion \
        bazel \
        cmake \
        fzf \
        git \
        htop \
        ninja-build \
        python3 \
        python3-dev \
        sudo \
        tmux \
        tree \
        vim \
    && apt-get clean

USER jonathan
WORKDIR /home/jonathan
