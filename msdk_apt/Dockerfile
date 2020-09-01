FROM ubuntu:20.04
ENV DEBIAN_FRONTEND=noninteractive
 
# Install a few minimal prerequisites 
RUN apt-get update && apt-get install -y --no-install-recommends \
      software-properties-common \
      ca-certificates \
      lsb-release \
      xutils \
      libva-x11-2 \
      libva-drm2 \
      xorg

# Install OpenCL and MSDK
RUN echo "deb [trusted=yes arch=amd64] https://repositories.intel.com/graphics/ubuntu focal main" > /etc/apt/sources.list.d/intel-graphics.list && \ 
   apt-get update && apt-get install -y --no-install-recommends \
      intel-opencl-icd \
      intel-media-va-driver-non-free \
      libmfx1 \
      libmfx-tools \
      clinfo

#RUN echo 'LIBVA_DRIVERS_PATH=/opt/intel/mediasdk/lib' >> /etc/environment && \
#    echo 'LIBVA_DRIVER_NAME=iHD' >> /etc/environment && \
#    echo 'LIBRARY_PATH=/opt/intel/mediasdk/lib:${LIBRARY_PATH}' >> /etc/environment && \
#    echo 'PKG_CONFIG_PATH=/usr/lib/x86_64-linux-gnu/pkgconfig:/opt/intel/mediasdk/lib64/pkgconfig' >> /etc/environment && \
#   ldconfig

RUN echo 'LIBVA_DRIVER_NAME=iHD' >> /etc/environment 
