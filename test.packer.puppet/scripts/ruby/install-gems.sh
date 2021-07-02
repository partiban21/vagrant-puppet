#!/bin/bash
set -eu

export PATH=/usr/local/rvm/bin/:$PATH # rvm: command not found, because needs terminal needs reloads
rvm use 2.3 --default

# gems
gem install r10k