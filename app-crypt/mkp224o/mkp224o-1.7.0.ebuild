# Copyright 2023 Kirixetamine <revelation@krxt.dev
# Distributed under the terms of the ISC License

EAPI=8

inherit autotools

DESCRIPTION="Vanity address generator for v3 onion hidden services"
HOMEPAGE="https://github.com/cathugger/mkp224o/"

REPO_URI="https://github.com/cathugger/mkp224o"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="${REPO_URI}"
else
	SRC_URI="${REPO_URI}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${P}"
fi

LICENSE="CC0-1.0"
SLOT="0"
RESTRICT="mirror"

BDEPEND="
	dev-libs/libsodium
	sys-devel/autoconf
	sys-devel/make
"

src_prepare() {
	default
	eautoreconf
}

src_install() {
	insinto /usr/bin
	dobin mkp224o
}
