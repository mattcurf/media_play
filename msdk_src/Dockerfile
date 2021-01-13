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
      libxcb-dri3-dev \
      libx11-xcb-dev \
      libxcb-present-dev \
      xorg-dev && \
    rm -rf /var/lib/apt/lists/*

RUN git clone --depth=1 -b 2.10.0 https://github.com/intel/libva.git libva  && \
   cd libva && \
   ./autogen.sh --prefix=/usr --libdir=/usr/lib/x86_64-linux-gnu && \
   make -j$(nproc) && \
   make install

RUN git clone --depth=1 -b 2.10.0 https://github.com/intel/libva-utils libva-utils && \
   cd libva-utils && \
   ./autogen.sh --prefix=/usr --libdir=/usr/lib/x86_64-linux-gnu && \
   make -j$(nproc) && \
   make install

RUN git clone --depth=1 -b intel-gmmlib-20.4.1 https://github.com/intel/gmmlib gmmlib && \
   cd gmmlib && \
   mkdir build_gmm && \
   cd build_gmm && \
   cmake -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Release .. && \
   make -j$(nproc) && \
   make install

RUN git clone --depth=1 -b intel-media-20.4.5 https://github.com/intel/media-driver.git media-driver && \
   cd media-driver && \
   mkdir build && \
   cd build && \
   cmake -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Release .. && \
   make -j$(nproc) && \
   make install

RUN git clone --depth=1 -b intel-mediasdk-20.5.1 https://github.com/Intel-Media-SDK/MediaSDK msdk && \
   cd msdk && \
   mkdir build && \
   cd build && \
   cmake -DCMAKE_BUILD_TYPE=Release -DBUILD_TESTS=ON -DBUILD_TOOLS=ON -DENABLE_X11_DRI3=ON .. && \
   make -j$(nproc) && \
   make install 

RUN echo 'LIBVA_DRIVERS_PATH=/opt/intel/mediasdk/lib' >> /etc/environment && \
    echo 'LIBVA_DRIVER_NAME=iHD' >> /etc/environment && \
    echo 'LIBRARY_PATH=/opt/intel/mediasdk/lib:${LIBRARY_PATH}' >> /etc/environment && \
    echo 'PKG_CONFIG_PATH=/usr/lib/x86_64-linux-gnu/pkgconfig:/opt/intel/mediasdk/lib64/pkgconfig' >> /etc/environment && \
   ldconfig
