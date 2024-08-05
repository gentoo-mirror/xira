# Copyright 2024 Kirixetamine <revelation@krxt.dev>
# Distributed under the terms of the ISC License

EAPI=8

inherit go-module

DESCRIPTION="Generate .desktop files from the terminal"
HOMEPAGE="
	https://github.com/xyproto/gendesk
	https://gendesk.roboticoverlords.org
"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/xyproto/${PN}"
else
	SRC_URI="https://github.com/xyproto/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${P}"
	KEYWORDS="~amd64"
fi

LICENSE="BSD"
SLOT="0"
IUSE="man"

RDEPEND="
	sys-libs/glibc
"

BDEPEND="
	dev-lang/go
"

RESTRICT="mirror"

src_unpack() {
	if [[ ${PV} == 9999 ]]; then
		git-r3_src_unpack		|| die
		go-module_src_unpack	|| die
	else
		go-module_src_unpack	|| die
	fi
}

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
