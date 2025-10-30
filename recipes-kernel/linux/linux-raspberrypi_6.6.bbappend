FILESEXTRAPATHS:prepend := "${SULKA_KMETA_LOCATION}:"

SRC_URI:append = " \
    file://sulka-kmeta;type=kmeta;name=sulka-kmeta;destsuffix=sulka-kmeta \
"

KERNEL_FEATURES:append = " \
    features/security/security.cfg \
    features/sulka-security/audit.scc \
    features/sulka-security/sulka-cut-attack-surface.scc \
    features/sulka-security/sulka-harden-userspace.scc \
    features/sulka-security/sulka-security-policy.scc \
    features/sulka-security/sulka-self-protection.scc \
"

KERNEL_FEATURES:append = " \
    features/sulka-security/sulka-cut-graphics.scc \
"
