SUMMARY = "Board LED heartbeat gated by FMCOMMS5 AD9361 initialization"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI = "file://fmcomms5-heartbeat file://fmcomms5-heartbeat.init"
S = "${WORKDIR}"

inherit update-rc.d

INITSCRIPT_NAME = "fmcomms5-heartbeat"
INITSCRIPT_PARAMS = "start 99 2 3 4 5 . stop 01 0 1 6 ."
RDEPENDS:${PN} = "busybox"

do_install() {
    install -d ${D}${sbindir} ${D}${sysconfdir}/init.d
    install -m 0755 ${WORKDIR}/fmcomms5-heartbeat ${D}${sbindir}/fmcomms5-heartbeat
    install -m 0755 ${WORKDIR}/fmcomms5-heartbeat.init ${D}${sysconfdir}/init.d/fmcomms5-heartbeat
}
