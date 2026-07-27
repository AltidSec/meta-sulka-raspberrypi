# meta-sulka-raspberrypi

This meta-layer is the integration layer that reconciles Sulka with the Raspberry Pi 4, 64-bit.

Sulka is a Yocto Linux distribution that focuses on security hardening.
It ships hardened defaults across the kernel, the bootloader and the userspace, and expects the integrator to consciously relax hardening where their product requires it, rather than the other way round.

Bootloader and kernel metadata are board specific, so most of the work of porting Sulka to a new board lands in a layer like this one. It is worth reading as a template for your own port.

## What This Layer Provides

### Kernel

`recipes-kernel/linux/linux-raspberrypi_6.18.bbappend` inherits the `sulka-kernel-hardening` class from [meta-sulka-kernel](https://codeberg.org/AltidSec/meta-sulka-kernel), which is all that is needed to bring the Sulka kernel hardening onto a different kernel recipe.

On top of that it adds its own kernel metadata under `recipes-kernel/linux/files/sulka-raspberrypi-kmeta/`, describing the machine to the kernel tooling and carrying a `sulka-raspberrypi` feature that reconciles the Sulka hardening with the board:

- Restores the linux security modules that the Raspberry Pi defconfig removes, so that SELinux and the other LSMs Sulka expects are available.
- Disables the static usermode helper, which currently has no implementation available.
- Disables the ARM SMMU options, as that hardware is not present on the Raspberry Pi 4.

### Bootloader

`recipes-bsp/u-boot/u-boot_2026.01.bbappend` supplies the board-specific configuration that the [meta-sulka-bsp](https://codeberg.org/AltidSec/meta-sulka-bsp) U-Boot hardening needs in order to still boot the Pi.

Since that hardening restricts the U-Boot console to an allowlist of commands, the allowlist has to name the commands the Raspberry Pi boot flow actually uses. A second configuration fragment is applied when the firmware update support is enabled, extending the allowlist for the update flow and moving the U-Boot environment into FAT storage so the A/B slot state can persist across reboots.

### Firmware Update Integration

`dynamic-layers/meta-rugix/` activates only when `meta-rugix-core` is part of the build. It adjusts the Rugix system configuration in two ways: it disables the Rugix overlay, because the overlayfs it relies on does not work well with SELinux, and it installs the signature root certificate when one has been configured.

See the [firmware update guide](https://altidsec.com/sulka/documentation/firmware-update.html) for how to run the update example and how to point the build at your certificate.

## Layer Information

| | |
|---|---|
| Layer name | `meta-sulka-raspberrypi` |
| Priority | 15 |
| Yocto compatibility | Wrynose (`LAYERSERIES_COMPAT = "wrynose"`) |
| Declared layer dependencies | None |
| Target machine | `raspberrypi4-64` |

The layer expects to be built alongside `meta-raspberrypi` and the Sulka layers, and it appends to recipes owned by them, so it is not useful on its own. Only the default Sulka init manager, `systemd`, is supported.

The supported way to use this layer is through the [Raspberry Pi reference project](https://codeberg.org/AltidSec/kas-sulka-raspberrypi-example), which wires it together with the rest of the build.

## Documentation

To get started with Sulka, read [the quick start guide](https://altidsec.com/sulka/documentation/quick-start.html).
More information can be found in [the user guide](https://altidsec.com/sulka/documentation/user-guide.html) and the [firmware update guide](https://altidsec.com/sulka/documentation/firmware-update.html), including the full list of [configuration variables](https://altidsec.com/sulka/documentation/user-guide.html#configuration-variables).

If the website is unavailable, the same content can be read from [the documentation repository](https://codeberg.org/AltidSec/sulka-docs/src/branch/main/source).

## Contributing

Send pull requests, patches, comments or questions to the AltidSec repositories in Codeberg, and feel free to open issues to start discussions. Use `*-next` branches as pull request targets.

Maintainer:
Esa Jääskelä <esa.jaaskela@suomi24.fi>

## License

The metadata in this layer is licensed under the MIT license. See [COPYING.MIT](COPYING.MIT) for the full text.
Individual recipes fetch and build upstream components under their own licenses.
