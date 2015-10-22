#!/bin/bash

#...testing. systemctl 
# systemctl list-unit-files --type=service | grep usbc
# systemctl daemon-reload
# systemctl start usbcamera.service
#
# Minimally you should see the following.
#root@am335x-evm:/etc/systemd/system# lsmod
#Module                  Size  Used by
#uvcvideo               58266  0
#v4l2_common             5537  0
#videobuf2_vmalloc       1566  0
#vvideobuf2_memops        2096  1 videobuf2_vmalloc
#v4l2_int_device         1894  0
#v4l2_mem2mem            6137  0
#videobuf2_core         18239  1 v4l2_mem2mem
#videodev               70905  2 v4l2_common,uvcvideo


function usage()
{
        echo "Usage: "
        echo "   $0 start|stop|restart "
        exit 1
}

function startcamera()
{
    while read cmd ; do
        [ -n "$cmd" ] && [[ ! $cmd =~ ^# ]] && $cmd
    done < /etc/methode/v4l2_modules.conf
}


function stopcamera()
{
    rmmod hid_keytouch uvcvideo v4l2_common  videobuf2_vmalloc
    rmmod videobuf2_memops v4l2_int_device v4l2_mem2mem
    rmmod videobuf2_core videodev
}


case "$1" in
   start)
        startcamera
        ;;
   stop)
        stopcamera
        ;;
   restart)
        stopcamera
        startcamera
        ;;
   *)
        usage
        ;;
esac

exit 0
