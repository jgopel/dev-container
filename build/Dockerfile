FROM run

# Precursors
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt,sharing=locked \
    apt-get update \
    && apt-get install --yes \
        apt-transport-https \
        curl \
        gnupg \
        software-properties-common \
        wget

# C++
RUN add-apt-repository ppa:ubuntu-toolchain-r/test
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt,sharing=locked \
    apt-get update \
    && apt-get install --yes \
        g++-12 \
        gcc-12 \
        g++-14 \
        gcc-13 \
        g++-13 \
        gcc-14

RUN wget --output-document=- https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add - \
    && apt-add-repository 'deb http://apt.llvm.org/noble/ llvm-toolchain-noble main' \
    && apt-add-repository 'deb http://apt.llvm.org/noble/ llvm-toolchain-noble-18 main' \
    && apt-add-repository 'deb http://apt.llvm.org/noble/ llvm-toolchain-noble-19 main'
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt,sharing=locked \
    apt-get update \
    && apt-get install --yes \
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
        clang-19 \
        clang-format-19 \
        clang-tidy-19 \
        clang-tools-19 \
        clangd-19
RUN update-alternatives --install /usr/bin/clang clang /usr/bin/clang-17 17 \
    && update-alternatives --install /usr/bin/clang clang /usr/bin/clang-18 18 \
    && update-alternatives --install /usr/bin/clang clang /usr/bin/clang-19 19
RUN update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-17 17 \
    && update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-18 18 \
    && update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-19 19
RUN update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-17 17 \
    && update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-18 18 \
    && update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-19 19
RUN update-alternatives --install /usr/bin/clang-apply-replacements clang-apply-replacements /usr/bin/clang-apply-replacements-17 17 \
    && update-alternatives --install /usr/bin/clang-apply-replacements clang-apply-replacements /usr/bin/clang-apply-replacements-18 18 \
    && update-alternatives --install /usr/bin/clang-apply-replacements clang-apply-replacements /usr/bin/clang-apply-replacements-19 19
RUN update-alternatives --install /usr/bin/clang-format clang-format /usr/bin/clang-format-17 17 \
    && update-alternatives --install /usr/bin/clang-format clang-format /usr/bin/clang-format-18 18 \
    && update-alternatives --install /usr/bin/clang-format clang-format /usr/bin/clang-format-19 19
RUN update-alternatives --install /usr/bin/clang-tidy clang-tidy /usr/bin/clang-tidy-17 17 \
    && update-alternatives --install /usr/bin/clang-tidy clang-tidy /usr/bin/clang-tidy-18 18 \
    && update-alternatives --install /usr/bin/clang-tidy clang-tidy /usr/bin/clang-tidy-19 19
RUN update-alternatives --install /usr/bin/git-clang-format git-clang-format /usr/bin/git-clang-format-17 17 \
    && update-alternatives --install /usr/bin/git-clang-format git-clang-format /usr/bin/git-clang-format-18 18 \
    && update-alternatives --install /usr/bin/git-clang-format git-clang-format /usr/bin/git-clang-format-19 19

RUN curl --fail --silent --show-error --location https://bazel.build/bazel-release.pub.gpg | gpg --dearmor > /etc/apt/trusted.gpg.d/bazel.gpg \
    && echo "deb [arch=amd64] https://storage.googleapis.com/bazel-apt stable jdk1.8" | tee /etc/apt/sources.list.d/bazel.list
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt,sharing=locked \
    apt-get update \
    && apt-get install --yes \
        bazel \
        cmake \
        cppcheck \
        cpplint \
        iwyu \
        ninja-build

# Rust
ENV RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    PATH=/usr/local/cargo/bin:$PATH
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y \
    && chmod -R a+w ${RUSTUP_HOME} ${CARGO_HOME} \
    && cargo --version \
    && rustc --version \
    && rustup --version

# Python
RUN add-apt-repository ppa:deadsnakes/ppa
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt,sharing=locked \
    apt-get update \
    && apt-get install --yes \
        python3 \
        python3-dev \
        python3-venv \
        python3.11 \
        python3.11-dev \
        python3.11-venv \
        python3.10 \
        python3.10-dev \
        python3.10-venv
ENV POETRY_HOME=/usr/local/poetry \
    PATH=/usr/local/poetry/bin:$PATH
RUN curl --silent --show-error --location https://install.python-poetry.org | python3 - \
    && poetry --version
