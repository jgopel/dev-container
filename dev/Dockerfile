FROM build

# Make system human-friendly
RUN apt-get update \
    && apt-get install --yes \
        unminimize \
    && yes | unminimize \
    && apt-get install --yes \
        ca-certificates \
        man-db \
        manpages-posix \
    && apt-get upgrade --yes \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Docker
RUN install -m 0755 -d /etc/apt/keyrings \
    && curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc \
    && chmod a+r /etc/apt/keyrings/docker.asc \
    && echo "deb \
        [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] \
        https://download.docker.com/linux/ubuntu \
        $(. /etc/os-release && echo "$VERSION_CODENAME") stable" \
    | tee /etc/apt/sources.list.d/docker.list > /dev/null
RUN apt-get update \
    && apt-get install --yes \
        docker-ce \
        docker-ce-cli \
        containerd.io \
        docker-buildx-plugin \
        docker-compose-plugin \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Developer tools
RUN add-apt-repository ppa:git-core/ppa
RUN apt-get update \
    && apt-get install --yes \
        bash-completion \
        emacs \
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
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
