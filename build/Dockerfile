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
        gcc-13 \
        g++-13
# NOTE: gcc-14 does not seem to be in the ppa for unclear reasons - skipping
# TODO: gcc-15
# RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
#     --mount=type=cache,target=/var/lib/apt,sharing=locked \
#     apt-get update \
#     && apt-get install --yes \
#         gcc-15 \
#         g++-15

RUN wget --output-document=- https://apt.llvm.org/llvm-snapshot.gpg.key | tee /etc/apt/trusted.gpg.d/apt.llvm.org.asc
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt,sharing=locked \
    apt-add-repository 'deb http://apt.llvm.org/noble/ llvm-toolchain-noble-19 main' \
    && apt-get update \
    && apt-get install --yes \
        clang-19 \
        clang-format-19 \
        clang-tidy-19 \
        clang-tools-19 \
        clangd-19 \
    && update-alternatives --install /usr/bin/clang clang /usr/bin/clang-19 19 \
    && update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-19 19 \
    && update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-19 19 \
    && update-alternatives --install /usr/bin/clang-apply-replacements clang-apply-replacements /usr/bin/clang-apply-replacements-19 19 \
    && update-alternatives --install /usr/bin/clang-format clang-format /usr/bin/clang-format-19 19 \
    && update-alternatives --install /usr/bin/clang-tidy clang-tidy /usr/bin/clang-tidy-19 19 \
    && update-alternatives --install /usr/bin/git-clang-format git-clang-format /usr/bin/git-clang-format-19 19
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt,sharing=locked \
    apt-add-repository 'deb http://apt.llvm.org/noble/ llvm-toolchain-noble-20 main' \
    && apt-get update \
    && apt-get install --yes \
        clang-20 \
        clang-format-20 \
        clang-tidy-20 \
        clang-tools-20 \
        clangd-20 \
    && update-alternatives --install /usr/bin/clang clang /usr/bin/clang-20 20 \
    && update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-20 20 \
    && update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-20 20 \
    && update-alternatives --install /usr/bin/clang-apply-replacements clang-apply-replacements /usr/bin/clang-apply-replacements-20 20 \
    && update-alternatives --install /usr/bin/clang-format clang-format /usr/bin/clang-format-20 20 \
    && update-alternatives --install /usr/bin/clang-tidy clang-tidy /usr/bin/clang-tidy-20 20 \
    && update-alternatives --install /usr/bin/git-clang-format git-clang-format /usr/bin/git-clang-format-20 20
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt,sharing=locked \
    apt-add-repository 'deb http://apt.llvm.org/noble/ llvm-toolchain-noble-21 main' \
    && apt-get update \
    && apt-get install --yes \
        clang-21 \
        clang-format-21 \
        clang-tidy-21 \
        clang-tools-21 \
        clangd-21 \
    && update-alternatives --install /usr/bin/clang clang /usr/bin/clang-21 21 \
    && update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-21 21 \
    && update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-21 21 \
    && update-alternatives --install /usr/bin/clang-apply-replacements clang-apply-replacements /usr/bin/clang-apply-replacements-21 21 \
    && update-alternatives --install /usr/bin/clang-format clang-format /usr/bin/clang-format-21 21 \
    && update-alternatives --install /usr/bin/clang-tidy clang-tidy /usr/bin/clang-tidy-21 21 \
    && update-alternatives --install /usr/bin/git-clang-format git-clang-format /usr/bin/git-clang-format-21 21
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt,sharing=locked \
    apt-add-repository 'deb http://apt.llvm.org/noble/ llvm-toolchain-noble main' \
    && apt-get update \
    && apt-get install --yes \
        clang \
        clang-format \
        clang-tidy \
        clang-tools \
        clangd

RUN curl --fail --silent --show-error --location https://bazel.build/bazel-release.pub.gpg | gpg --dearmor > /etc/apt/trusted.gpg.d/bazel.gpg \
    && echo "deb [arch=amd64] https://storage.googleapis.com/bazel-apt stable jdk1.8" | tee /etc/apt/sources.list.d/bazel.list
RUN wget --output-document=- https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | gpg --dearmor - | tee /etc/apt/trusted.gpg.d/kitware.gpg >/dev/null \
    && apt-add-repository "deb https://apt.kitware.com/ubuntu/ $(lsb_release --codename --short) main"
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
