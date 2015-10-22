#!/bin/bash


if grep '/home/wwright/dev/dcim3.x/angstrom/build/tmp-angstrom' rbconfig.rb >/dev/null ; then
 
     cat rbconfig.rb | sed 's/\/home\/wwright\/dev\/dcim3.x\/angstrom\/build\/tmp-angstrom_v2014_12-glibc\/sysroots\/am335x-evm/\//g' >t.t

     cp t.t rbconfig.rb
fi

