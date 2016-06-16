#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

mkdir ~/ffmpeg_sources
cd ~/ffmpeg_sources

# YASM
wget http://www.tortall.net/projects/yasm/releases/yasm-1.3.0.tar.gz
tar xzvf yasm-1.3.0.tar.gz
cd yasm-1.3.0
./configure --bindir="$HOME/bin"
make
make install

# libx264
cd ~/ffmpeg_sources
wget http://download.videolan.org/pub/x264/snapshots/x264-snapshot-20160507-2245.tar.bz2
tar xjvf x264-snapshot-20160507-2245.tar.bz2
cd x264-snapshot*
PATH="$HOME/bin:$PATH" ./configure --bindir="$HOME/bin" --enable-static
PATH="$HOME/bin:$PATH" make
make install

# libmp3lame
cd ~/ffmpeg_sources
wget https://github.com/rbrito/lame/archive/RELEASE__3_99_5.tar.gz
tar xzvf RELEASE__3_99_5.tar.gz
cd lame-RELEASE__3_99_5
./configure --enable-nasm --disable-shared
make
make install

# libopus
cd ~/ffmpeg_sources
wget http://downloads.xiph.org/releases/opus/opus-1.1.tar.gz
tar xzvf opus-1.1.tar.gz
cd opus-1.1
./configure --disable-shared
make
make install
make clean

# libvpx
cd ~/ffmpeg_sources
wget http://storage.googleapis.com/downloads.webmproject.org/releases/webm/libvpx-1.5.0.tar.bz2
tar xjvf libvpx-1.5.0.tar.bz2
cd libvpx-1.5.0
PATH="$HOME/bin:$PATH" ./configure --disable-examples --disable-unit-tests
PATH="$HOME/bin:$PATH" make
make install
make clean

# ffmpeg itself
cd ~/ffmpeg_sources
git clone https://github.com/FFmpeg/FFmpeg.git
cd FFmpeg
git checkout caee88d193fe4e066251cb541e360d98b2f152ae
PATH="$HOME/bin:$PATH" PKG_CONFIG_PATH="$HOME/ffmpeg_build/lib/pkgconfig" ./configure \
  --pkg-config-flags="--static" \
  --bindir="$HOME/bin" \
  --enable-libfreetype \
  --enable-libmp3lame \
  --enable-libopus \
  --enable-libtheora \
  --enable-libvorbis \
  --enable-libvpx \
  --enable-libx264 \
  --enable-gpl \
  --enable-libzmq \
  --enable-gnutls
PATH="$HOME/bin:$PATH" make
make install
make distclean
