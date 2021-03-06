# Common code for generating core reference images
#
# Copyright (C) 2007-2011 Linux Foundation

LIC_FILES_CHKSUM = "file://${COREBASE}/LICENSE;md5=4d92cd373abda3937c2bc47fbc49d690 \
                    file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420"

# IMAGE_FEATURES control content of the core reference images
# 
# By default we install packagegroup-core-boot and packagegroup-base packages - this gives us
# working (console only) rootfs.
#
# Available IMAGE_FEATURES:
#
# - x11                 - X server
# - x11-base            - X server with minimal environment
# - x11-sato            - OpenedHand Sato environment
# - tools-debug         - debugging tools
# - eclipse-debug       - Eclipse remote debugging support
# - tools-profile       - profiling tools
# - tools-testapps      - tools usable to make some device tests
# - tools-sdk           - SDK (C/C++ compiler, autotools, etc.)
# - nfs-server          - NFS server
# - ssh-server-dropbear - SSH server (dropbear)
# - ssh-server-openssh  - SSH server (openssh)
# - qt4-pkgs            - Qt4/X11 and demo applications
# - hwcodecs            - Install hardware acceleration codecs
# - package-management  - installs package management tools and preserves the package manager database
# - debug-tweaks        - makes an image suitable for development, e.g. allowing passwordless root logins
# - dev-pkgs            - development packages (headers, etc.) for all installed packages in the rootfs
# - dbg-pkgs            - debug symbol packages for all installed packages in the rootfs
# - doc-pkgs            - documentation packages for all installed packages in the rootfs
# - read-only-rootfs    - tweaks an image to support read-only rootfs
#
# ##### 
# WW - I did not understand PACKAGE_GROUP so I renamed to PACKAGE_PACKAGES_x11-browser and added below 
#//see: http://git.yoctoproject.org/cgit/cgit.cgi/meta-web-kiosk/about/
#PACKAGE_GROUP_x11-browser=”packagegroup-core-x11-browser”
#PACKAGE_PACKAGES_x11-browser = "packagegroup-core-x11-browser"
##### 

FEATURE_PACKAGES_x11 = "packagegroup-core-x11"
FEATURE_PACKAGES_x11-base = "packagegroup-core-x11-base"
FEATURE_PACKAGES_x11-sato = "packagegroup-core-x11-sato"
PACKAGE_PACKAGES_x11-browser = "packagegroup-core-x11-browser"
FEATURE_PACKAGES_tools-debug = "packagegroup-core-tools-debug"
FEATURE_PACKAGES_eclipse-debug = "packagegroup-core-eclipse-debug"
FEATURE_PACKAGES_tools-profile = "packagegroup-core-tools-profile"
FEATURE_PACKAGES_tools-testapps = "packagegroup-core-tools-testapps"
FEATURE_PACKAGES_tools-sdk = "packagegroup-core-sdk packagegroup-core-standalone-sdk-target"
FEATURE_PACKAGES_nfs-server = "packagegroup-core-nfs-server"
FEATURE_PACKAGES_ssh-server-dropbear = "packagegroup-core-ssh-dropbear"
FEATURE_PACKAGES_ssh-server-openssh = "packagegroup-core-ssh-openssh"
FEATURE_PACKAGES_qt4-pkgs = "packagegroup-core-qt-demoapps"
FEATURE_PACKAGES_hwcodecs = "${MACHINE_HWCODECS}"


# IMAGE_FEATURES_REPLACES_foo = 'bar1 bar2'
# Including image feature foo would replace the image features bar1 and bar2
IMAGE_FEATURES_REPLACES_ssh-server-openssh = "ssh-server-dropbear"

# IMAGE_FEATURES_CONFLICTS_foo = 'bar1 bar2'
# An error exception would be raised if both image features foo and bar1(or bar2) are included

MACHINE_HWCODECS ??= ""

CORE_IMAGE_BASE_INSTALL = '\
    packagegroup-core-boot \
    packagegroup-base-extended \
    \
    ${CORE_IMAGE_EXTRA_INSTALL} \
    '

CORE_IMAGE_EXTRA_INSTALL ?= ""

IMAGE_INSTALL ?= "${CORE_IMAGE_BASE_INSTALL}"

inherit image

# Create /etc/timestamp during image construction to give a reasonably sane default time setting
ROOTFS_POSTPROCESS_COMMAND += "rootfs_update_timestamp ; "

# Zap the root password if debug-tweaks feature is not enabled
ROOTFS_POSTPROCESS_COMMAND += '${@base_contains("IMAGE_FEATURES", "debug-tweaks", "", "zap_empty_root_password ; ",d)}'

# Tweak the mount options for rootfs in /etc/fstab if read-only-rootfs is enabled
ROOTFS_POSTPROCESS_COMMAND += '${@base_contains("IMAGE_FEATURES", "read-only-rootfs", "read_only_rootfs_hook; ", "",d)}'
