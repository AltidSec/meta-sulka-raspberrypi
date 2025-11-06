FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

inherit sulka-kernel-hardening

SRC_URI:append = " \
    file://sulka-raspberrypi-kmeta;type=kmeta;name=sulka-raspberrypi-kmeta;destsuffix=sulka-raspberrypi-kmeta \
"

KERNEL_FEATURES:append = " features/sulka-raspberrypi/sulka-raspberrypi.scc"
