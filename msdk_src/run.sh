#/bin/bash

# Media from:
# $ cd
# $ wget https://download.blender.org/peach/bigbuckbunny_movies/big_buck_bunny_1080p_h264.mov
# $ ffmpeg -i big_buck_bunny_1080p_h264.mov -an -vcodec copy -bsf h264_mp4toannexb -f h264 big_buck_bunny_1080p_h264.264

docker build -t msdk:18.04 -f ubuntu_18.04/Dockerfile .
docker build -t msdk_runtime:18.04 -f ubuntu_18.04/Dockerfile_runtime .

docker build -t msdk:20.04 -f ubuntu_20.04/Dockerfile .
docker build -t msdk_runtime:20.04 -f ubuntu_20.04/Dockerfile_runtime .

docker run -it --rm --privileged --net=host -e LD_LIBRARY_PATH=/opt/intel/mediasdk/lib -e DISPLAY=$DISPLAY -v $HOME:/home msdk_runtime:18.04 /opt/intel/mediasdk/share/mfx/samples/sample_decode h264 -i /home/big_buck_bunny_1080p_h264.264 -r -rgb4

docker run -it --rm --privileged --net=host -e LD_LIBRARY_PATH=/opt/intel/mediasdk/lib -e DISPLAY=$DISPLAY -v $HOME:/home msdk_runtime:20.04 /opt/intel/mediasdk/share/mfx/samples/sample_decode h264 -i /home/big_buck_bunny_1080p_h264.264 -r -rgb4


