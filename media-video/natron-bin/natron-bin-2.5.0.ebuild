# Copyright 2024 Kirixetamine <revelation@krxt.dev>
# Distributed under the terms of the ISC License

EAPI=8

inherit xdg-utils

MY_PN=${PN%-bin}
PROG_NAME=${MY_PN^}

DESCRIPTION="Node-graph based open-source compositing software"
HOMEPAGE="https://natrongithub.github.io"

SRC_URI="https://github.com/NatronGitHub/${PROG_NAME}/releases/download/v${PV}/${PROG_NAME}-${PV}-Linux-x86_64-no-installer.tar.xz -> ${P}.tar.xz"
S="${WORKDIR}/Natron-${PV}-Linux-x86_64-no-installer"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"

DEPEND="
    virtual/glu
    sys-libs/libxcrypt
    x11-themes/hicolor-icon-theme
"
RDEPEND="${DEPEND}"

BDEPEND="
    sys-apps/gendesk
    media-gfx/imagemagick
"

RESTRICT="mirror strip"

src_prepare() {
    # Generate desktop file
    gendesk -f -n \
        --pkgname="${MY_PN}"        \
        --pkgdesc="${DESCRIPTION}"  \
        --name="${PROG_NAME}"       \
        --comment="${DESCRIPTION}"  \
        --exec="${PROG_NAME}"       \
        --icon="${MY_PN}"           \
        --categories='Graphics'     \
        --mimetypes="application/x-${MY_PN}"
    default
}

src_install() {
    mkdir -p "${ED}/usr/share/applications"         || die
    mkdir -p "${ED}/usr/share/mime/application"     || die
    mkdir -p "${ED}/opt/${PN}"                      || die
    mkdir -p "${ED}/usr/bin"                        || die

    cp -r * "${ED}/opt/${PN}/"                                          || die
    cp "${S}/${MY_PN}.desktop" "${ED}/usr/share/applications"           || die
    cp "${FILESDIR}/x-${MY_PN}.xml" "${ED}/usr/share/mime/application"  || die
    ln -sf "/opt/${PN}/${PROG_NAME}" "${ED}/usr/bin/${PROG_NAME}"       || die

    for i in 16 22 24 32 48 64 96 128 256; do
        magick "${ED}/opt/${PN}/Resources/pixmaps/${MY_PN}Icon256_linux.png" \
            -resize "${i}x${i}" "${S}/icon_app${i}.png"             || die
        mkdir -p "${ED}/usr/share/icons/hicolor/${i}x${i}/apps/"    || die
        cp "${S}/icon_app${i}.png" "${ED}/usr/share/icons/hicolor/${i}x${i}/apps/${MY_PN}.png"  || die
    done
    for i in 16 22 24 32 48 64 96 128 256; do
        magick "${ED}/opt/${PN}/Resources/pixmaps/${MY_PN}ProjectIcon_linux.png" \
            -resize "${i}x${i}" "${S}/icon_mime${i}.png"                || die
        mkdir -p "${ED}/usr/share/icons/hicolor/${i}x${i}/mimetypes"    || die
        cp "${S}/icon_mime${i}.png" "${ED}/usr/share/icons/hicolor/${i}x${i}/mimetypes/${MY_PN}.png" || die
    done
}

pkg_postinst() {
    xdg_icon_cache_update
    xdg_desktop_database_update
}

pkg_postrm() {
    xdg_icon_cache_update
    xdg_desktop_database_update
}
