FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

# Boot from the separate boot slots that dm-verity needs. A patch rather
# than a copy of meta-rugix's boot.cmd.in, so that do_patch fails when
# upstream changes the lines it relies on.
SRC_URI:append = " file://0001-boot.cmd-Boot-from-the-boot-slots-of-the-boot-group.patch"
