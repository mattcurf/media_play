FROM ubuntu:18.04 AS base
WORKDIR /build

# Install prerequisites
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
   apt-get install -y -q --no-install-recommends \
      lsb-release \
      build-essential \
      wget \
      git \
      ca-certificates \
      cmake \
      autoconf \
      autotools-dev \
      automake libtool \
      ninja-build \
      meson \
      pkg-config \
      libdrm-dev \
      libpciaccess-dev \
      xutils-dev \
      libx11-dev \
      xorg-dev && \
    rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/intel/libva.git libva  && \
   cd libva && \
   git checkout ccf3b081ff3d2b0784cd66daf04bbc317277cf8b && \
   ./autogen.sh --prefix=/usr --libdir=/usr/lib/x86_64-linux-gnu && \
   make -j$(nproc) && \
   make install

RUN git clone https://github.com/intel/gmmlib gmmlib && \
   cd gmmlib && \
   git checkout d7a0586104096f3e2241e2a773c6bc41a9e2c422 && \
   mkdir build_gmm && \
   cd build_gmm && \
   cmake -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Release .. && \
   make -j$(nproc) && \
   make install

RUN git clone https://anongit.freedesktop.org/git/mesa/drm.git libdrm && \
   cd libdrm && \
   git checkout 9fbae6f6ad7994240e25e7823573604d4a9be4c4 && \
   mkdir build && \
   cd build && \
   meson --prefix=/usr -Dudev=true && \
   ninja && \
   ninja install

RUN git clone https://github.com/intel/media-driver.git media-driver && \
   cd media-driver && \
   git checkout d7061b608ad4d55fccab00f8d80b852f20eab1d7 && \
   mkdir build && \
   cd build && \
   cmake -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Release .. && \
   make -j$(nproc) && \
   make install

RUN git clone https://github.com/Intel-Media-SDK/MediaSDK msdk && \
   cd msdk && \
   git checkout 543138c85b9d54f172fd83f7e8aefc9846413a0f && \
   mkdir build && \
   cd build && \
   cmake -DCMAKE_BUILD_TYPE=Release -DBUILD_TESTS=ON -DBUILD_TOOLS=ON .. && \
   make -j$(nproc) && \
   make install 

RUN echo 'LIBVA_DRIVERS_PATH=/opt/intel/mediasdk/lib' >> /etc/environment && \
    echo 'LIBVA_DRIVER_NAME=iHD' >> /etc/environment && \
    echo 'LIBRARY_PATH=/opt/intel/mediasdk/lib:${LIBRARY_PATH}' >> /etc/environment && \
    echo 'PKG_CONFIG_PATH=/usr/lib/x86_64-linux-gnu/pkgconfig:/opt/intel/mediasdk/lib64/pkgconfig' >> /etc/environment && \
   ldconfig

