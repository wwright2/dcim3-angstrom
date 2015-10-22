#!/bin/bash

#opkg install gstreamer1.0-plugins-good-jpeg
#opkg install gstreamer1.0-plugins-good-video4linux

debug="x"

#default
pic="capture1.jpeg"

# if filename.jpeg then change name of pic.
if [ -n "$1" ] ; then
   if [[ $1 =~ .jpeg$ ]] ; then
      pic="$1"
   else
      echo "Error expected snapshot.sh <path/fname.jpeg> ... no picture taken."
      exit
   fi
fi

[[ $debug ]] &&  echo "gst-launch-1.0 v4l2src num-buffers=1 ! jpegenc ! filesink location=$pic "

gst-launch-1.0  v4l2src num-buffers=1 extra-controls="c,brightness=100" ! jpegenc ! filesink location=$pic