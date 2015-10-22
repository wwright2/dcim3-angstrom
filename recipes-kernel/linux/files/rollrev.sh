#!/bin/bash

r=24
if [ -n $1 ] ; then
	r=$1
fi

cd linux || exit 1

echo "make clean " 
make clean
cd ..
echo "tar rev=$1"
tar -czvf linux-dcim-3.2.x-r$1.tar.gz linux
echo "cp  linux-dcim-3.2.x-r$1.tar.gz /usr/share/nginx/html/dcim3-pkgs"
sudo cp linux-dcim-3.2.x-r$1.tar.gz /usr/share/nginx/html/dcim3-pkgs
echo "md5sum linux-dcim-3.2.x-r$1.tar.gz"
cat linux-dcim-3.2.x-r$1.tar.gz | md5sum

