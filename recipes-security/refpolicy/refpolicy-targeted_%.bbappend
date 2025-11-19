FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append = " file://0200-sulka-raspberrypi-selinux.patch "
