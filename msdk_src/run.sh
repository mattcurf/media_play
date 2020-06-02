#/bin/bash

# Media from:
# $ cd
# $ wget https://download.blender.org/peach/bigbuckbunny_movies/big_buck_bunny_1080p_h264.mov
# $ ffmpeg -i big_buck_bunny_1080p_h264.mov -an -vcodec copy -bsf h264_mp4toannexb -f h264 big_buck_bunny_1080p_h264.264

docker build -t msdk .
docker run -it --rm --privileged --net=host -e LD_LIBRARY_PATH=/opt/intel/mediasdk/lib -e DISPLAY=$DISPLAY -v $HOME:/home msdk /tmp/msdk/build/__bin/Release/sample_decode h264 -i /home/big_buck_bunny_1080p_h264.264 -r
