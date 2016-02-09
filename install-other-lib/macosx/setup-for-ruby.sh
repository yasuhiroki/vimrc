#!/bin/bash

# rsense
brew list rsense 1>/dev/null 2>&1 || brew install rsense
ruby /usr/local/Cellar/rsense/0.3/libexec/etc/config.rb > ~/.rsense

# gem tool
gem install rubocop refe2 bitclust-dev
which rbenv && rbenv rehash
bitclust setup

