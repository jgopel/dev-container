FROM build

# Make system human-friendly
RUN apt-get update \
    && apt-get install --yes \
        unminimize \
    && yes | unminimize \
    && apt-get install --yes \
        man-db \
        manpages-posix \
    && apt-get upgrade --yes \
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
