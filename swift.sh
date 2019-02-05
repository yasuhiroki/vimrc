#!/bin/bash

set -eu

url_base="https://raw.githubusercontent.com/apple/swift/master/"
for d in ftdetect ftplugin syntax
do
  curl -sSL ${url_base}/utils/vim/${d}/swift.vim -o ./vim/${d}/swift.vim || echo 'Error'
done
