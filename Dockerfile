FROM ubuntu:noble

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
        g++-12 \
        g++-13 \
        g++-14 \
        gcc-12 \
        gcc-13 \
        gcc-14 \
    && apt-get clean

RUN wget --output-document=- https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add - \
    && apt-add-repository 'deb http://apt.llvm.org/mantic/ llvm-toolchain-mantic-16 main' \
    && apt-add-repository 'deb http://apt.llvm.org/mantic/ llvm-toolchain-mantic-17 main' \
    && apt-add-repository 'deb http://apt.llvm.org/mantic/ llvm-toolchain-mantic main'
RUN apt-get update \
    && apt-get install --yes \
        clang-16 \
        clang-format-16 \
        clang-tidy-16 \
        clang-tools-16 \
        clangd-16 \
        clang-17 \
        clang-format-17 \
        clang-tidy-17 \
        clang-tools-17 \
        clangd-17 \
        clang-18 \
        clang-format-18 \
        clang-tidy-18 \
        clang-tools-18 \
        clangd-18 \
    && apt-get clean
RUN update-alternatives --install /usr/bin/clang clang /usr/bin/clang-16 16 \
    && update-alternatives --install /usr/bin/clang clang /usr/bin/clang-17 17 \
    && update-alternatives --install /usr/bin/clang clang /usr/bin/clang-18 1
RUN update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-16 16 \
    && update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-17 17 \
    && update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-18 1
RUN update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-16 16 \
    && update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-17 17 \
    && update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-18 1
RUN update-alternatives --install /usr/bin/clang-apply-replacements clang-apply-replacements /usr/bin/clang-apply-replacements-16 16 \
    && update-alternatives --install /usr/bin/clang-apply-replacements clang-apply-replacements /usr/bin/clang-apply-replacements-17 17 \
    && update-alternatives --install /usr/bin/clang-apply-replacements clang-apply-replacements /usr/bin/clang-apply-replacements-18 1
RUN update-alternatives --install /usr/bin/clang-format clang-format /usr/bin/clang-format-16 16 \
    && update-alternatives --install /usr/bin/clang-format clang-format /usr/bin/clang-format-17 17 \
    && update-alternatives --install /usr/bin/clang-format clang-format /usr/bin/clang-format-18 1
RUN update-alternatives --install /usr/bin/clang-tidy clang-tidy /usr/bin/clang-tidy-16 16 \
    && update-alternatives --install /usr/bin/clang-tidy clang-tidy /usr/bin/clang-tidy-17 17 \
    && update-alternatives --install /usr/bin/clang-tidy clang-tidy /usr/bin/clang-tidy-18 1
RUN update-alternatives --install /usr/bin/git-clang-format git-clang-format /usr/bin/git-clang-format-16 16 \
    && update-alternatives --install /usr/bin/git-clang-format git-clang-format /usr/bin/git-clang-format-17 17 \
    && update-alternatives --install /usr/bin/git-clang-format git-clang-format /usr/bin/git-clang-format-18 1

# Python tools
RUN apt-get update \
    && apt-get install --yes \
        python3 \
        python3-dev \
        python3-venv \
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
        iwyu \
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
        plocate \
        rsync \
        strace \
        sudo \
        time \
        tmux \
        tree \
        vim \
    && apt-get clean

RUN useradd --create-home --shell /bin/bash --group sudo jonathan \
    && passwd -d jonathan
USER jonathan
WORKDIR /home/jonathan
