FROM streamkitchen/sk-node

# To be run from the apps directory.

# First line is libzmq dependencies, second is ffmpeg dependencies
RUN \
  apt-get update && \
  apt-get install -y python make g++ libtool autoconf automake pkg-config curl && \
  apt-get install -y libvorbisenc2 libvorbis0a libtheora0 libfreetype6 libass5 && \
  rm -rf /var/lib/apt/lists/*

ADD build/shared-dependencies.sh /build/shared-dependencies.sh
RUN /build/shared-dependencies.sh

ADD bin/ffmpeg /usr/bin/ffmpeg
CMD /usr/bin/ffmpeg
