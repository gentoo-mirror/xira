# Copyright 2024 Kirixetamine <revelation@krxt.dev>
# Distributed under the terms of the ISC License

EAPI=8

inherit go-module

DESCRIPTION="Generate .desktop files from the terminal"
HOMEPAGE="
	https://github.com/xyproto/gendesk
	https://gendesk.roboticoverlords.org
"

SRC_URI="https://github.com/xyproto/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${P}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="man"

RESTRICT="mirror"

src_compile() {
	ego build -mod=vendor -v -trimpath
}

src_install() {
	default
	dobin ${PN}

	if use man; then
		doman ${PN}.1
	fi

	einstalldocs
}
