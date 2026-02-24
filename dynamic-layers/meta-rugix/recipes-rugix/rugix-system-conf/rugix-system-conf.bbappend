# Add state configuration file that disables the Rugix overlay.
# The overlay utilizes overlayfs that does not play well with
# SELinux. If SELinux is disabled, the overlay can be used.
FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:append = " file://state.toml"

do_install:append() {
    install -m 0644 ${WORKDIR}/state.toml ${D}${sysconfdir}/rugix/
}
