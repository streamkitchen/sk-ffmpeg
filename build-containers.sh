#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

docker build -f Dockerfile.build -t streamkitchen/sk-ffmpeg-build .
mkdir -p bin
docker run streamkitchen/sk-ffmpeg-build cat /root/bin/ffmpeg > bin/ffmpeg
chmod 755 bin/ffmpeg
docker build -f Dockerfile -t streamkitchen/sk-ffmpeg .
