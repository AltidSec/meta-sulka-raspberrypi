FILESEXTRAPATHS:append := "${THISDIR}/files:"

SRC_URI:append = " \
    file://sulka_raspberrypi.cfg \
    ${@bb.utils.contains("DISTRO_FEATURES", "rugix", "file://sulka_raspberrypi_rugix.cfg", "", d)} \
"
