FROM ubuntu:kinetic
RUN yes | unminimize \
    && apt-get update \
    && apt-get install --yes \
        man-db \
        manpages-posix \
    && apt-get upgrade --yes \
    && apt-get clean

# Compilers
RUN apt-get update \
    && apt-get install --yes \
        apt-transport-https \
        curl \
        gnupg \
        software-properties-common \
        wget \
    && apt-get clean

RUN add-apt-repository ppa:ubuntu-toolchain-r/test
RUN apt-get update \
    && apt-get install --yes \
        g++-11 \
        g++-12 \
        gcc-11 \
        gcc-12 \
    && apt-get clean

RUN wget --output-document=- https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add - \
    && apt-add-repository 'deb http://apt.llvm.org/kinetic/ llvm-toolchain-kinetic-14 main' \
    && apt-add-repository 'deb http://apt.llvm.org/kinetic/ llvm-toolchain-kinetic-15 main' \
    && apt-add-repository 'deb http://apt.llvm.org/kinetic/ llvm-toolchain-kinetic main'
RUN apt-get update \
    && apt-get install --yes \
        clang-14 \
        clang-format-14 \
        clang-tidy-14 \
        clang-tools-14 \
        clangd-14 \
        clang-15 \
        clang-format-15 \
        clang-tidy-15 \
        clang-tools-15 \
        clangd-15 \
        clang-16 \
        clang-format-16 \
        clang-tidy-16 \
        clang-tools-16 \
        clangd-16 \
    && apt-get clean
RUN update-alternatives --install /usr/bin/clang clang /usr/bin/clang-15 15 \
    && update-alternatives --install /usr/bin/clang clang /usr/bin/clang-16 1
RUN update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-15 15 \
    && update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-16 1
RUN update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-15 15 \
    && update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-16 1
RUN update-alternatives --install /usr/bin/clang-apply-replacements clang-apply-replacements /usr/bin/clang-apply-replacements-15 15 \
    && update-alternatives --install /usr/bin/clang-apply-replacements clang-apply-replacements /usr/bin/clang-apply-replacements-16 1
RUN update-alternatives --install /usr/bin/clang-format clang-format /usr/bin/clang-format-15 15 \
    && update-alternatives --install /usr/bin/clang-format clang-format /usr/bin/clang-format-16 1
RUN update-alternatives --install /usr/bin/clang-tidy clang-tidy /usr/bin/clang-tidy-15 15 \
    && update-alternatives --install /usr/bin/clang-tidy clang-tidy /usr/bin/clang-tidy-16 1
RUN update-alternatives --install /usr/bin/git-clang-format git-clang-format /usr/bin/git-clang-format-15 15 \
    && update-alternatives --install /usr/bin/git-clang-format git-clang-format /usr/bin/git-clang-format-16 1

# Python tools
RUN apt-get update \
    && apt-get install --yes \
        python3 \
        python3-dev \
    && apt-get clean
ENV POETRY_HOME /opt/poetry
RUN curl --silent --show-error --location https://install.python-poetry.org | python3 -
RUN update-alternatives --install /usr/local/bin/poetry poetry /opt/poetry/bin/poetry 20

# C++ tools
RUN add-apt-repository ppa:git-core/ppa
RUN curl --fail --silent --show-error --location https://bazel.build/bazel-release.pub.gpg | gpg --dearmor > /etc/apt/trusted.gpg.d/bazel.gpg \
    && echo "deb [arch=amd64] https://storage.googleapis.com/bazel-apt stable jdk1.8" | tee /etc/apt/sources.list.d/bazel.list
RUN apt-get update \
    && apt-get install --yes \
        bazel \
        cmake \
        cppcheck \
        cpplint \
        ninja-build \
    && apt-get clean

# Developer tools
RUN apt-get update \
    && apt-get install --yes \
        ack \
        atop \
        bash-completion \
        dtrx \
        fzf \
        git \
        htop \
        mlocate \
        rsync \
        strace \
        sudo \
        tmux \
        tree \
        vim \
    && apt-get clean

RUN useradd --create-home --shell /bin/bash --group sudo jonathan \
    && passwd -d jonathan
USER jonathan
WORKDIR /home/jonathan
