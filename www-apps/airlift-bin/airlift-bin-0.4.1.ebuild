# Copyright 2023 Kirixetamine <revelation@krxt.dev>
# Distributed under the terms of the ISC License

EAPI=8

DESCRIPTION="A self-hosted file upload and sharing service"
HOMEPAGE="https://github.com/moshee/airlift"

SRC_URI="https://github.com/moshee/airlift/releases/download/v0.4.1/airliftd-v${PV}-linux_amd64.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}

LICENSE="BSD-3"
SLOT="0"
KEYWORDS="amd64"
RESTRICT="mirror test"

src_install() {
	dobin ${WORKDIR}/airliftd
}

pkg_postinst() {
	einfo "The binary is installed under /usr/bin/airliftd."
}
