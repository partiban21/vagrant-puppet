#!/bin/bash
set -eu

RBENV_ROOT="/root/.rbenv"
RBENV_RUBY_BUILD_PLUGIN=$RBENV_ROOT/plugins/ruby-build

# install build dependencies
yum clean all && yum install --setopt=skip_missing_names_on_install=False -y \
    bzip2 \
    bzip2-devel \
    epel-release \
    gcc \
    gcc-c++ \
    gettext \
    git \
    make \
    openssl \
    openssl-devel \
    python36 \
    python36-pip \
    readline-devel \
    ruby \
    sqlite \
    sqlite-devel \
    tree \
    vim \
    which \
    zlib-devel

git clone https://github.com/rbenv/rbenv.git $RBENV_ROOT \
    && echo "export RBENV_ROOT=\"$RBENV_ROOT\"" >> /root/.bashrc \
    && echo 'export PATH="$RBENV_ROOT/bin:$PATH"' >> /root/.bashrc \
    && echo -e 'if command -v rbenv 1>/dev/null 2>&1; then\n  eval "$(rbenv init -)"\nfi' >> /root/.bashrc \
    && echo 'eval "$(rbenv init -)"' >> /root/.bashrc \
    && git clone https://github.com/rbenv/ruby-build.git $RBENV_RUBY_BUILD_PLUGIN \
    && source /root/.bashrc \
    && rbenv install 2.3.8 \
    && rbenv install 2.6.4 \
    && rbenv global 2.6.4

# to disable generating of documents as that would take so much time
echo "gem: --no-document" > ~/.gemrc

# install bundler
gem install bundler
gem install r10k

# must be executed everytime a gem has been installed in order for the ruby executable to run
rbenv rehash
