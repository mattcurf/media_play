FROM ubuntu:20.04

# Install prerequisites
ARG TZ=America/New_York
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends \
      software-properties-common \
      ca-certificates \
      lsb-release \
      libva-x11-2 \
      libva-drm2 \
      xorg && \
   rm -rf /var/lib/apt/lists/* 

# Install OpenCL and MSDK
RUN echo "deb [trusted=yes arch=amd64] https://repositories.intel.com/graphics/ubuntu focal main" > /etc/apt/sources.list.d/intel-graphics.list && \ 
   apt-get update && apt-get install -y --no-install-recommends \
      intel-media-va-driver-non-free \
      libmfx1 \
      libmfx-tools 

RUN echo 'LIBVA_DRIVERS_PATH=/usr/lib/x86_64-linux-gnu/dri' >> /etc/environment && \ 
    echo 'LIBVA_DRIVER_NAME=iHD' >> /etc/environment && \ 
   ldconfig

