#!/bin/sh

export TSLIB_PLUGINDIR=/usr/lib/ts
export TSLIB_CALIBFILE=/etc/pointercal
export TSLIB_CONFFILE=/etc/ts.conf
export TSLIB_FBDEVICE=/dev/fb0
export TSLIB_CONSOLEDEVICE=none
export TSLIB_TSEVENTTYPE=INPUT
export TSLIB_TSDEVICE=/dev/input/event0

#export QT_QPA_PLATFORM=eglfs
#export QT_QPA_GENERIC_PLUGINS=libinput
#export QT_QPA_EGLFS_HIDECURSOR=1
#export QT_QPA_EGLFS_DISABLE_INPUT=1