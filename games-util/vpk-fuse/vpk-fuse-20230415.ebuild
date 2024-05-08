# Copyright 2023 Kirixetamine <revelation@krxt.dev>
# Distributed under the terms of the ISC License

EAPI=8

inherit linux-info

DESCRIPTION="FUSE filesystem to read Valve VPK files"
HOMEPAGE="https://github.com/ElementW/vpk_fuse"

MY_PN="${PN/\-/\_}"
COMMIT_HASH="4e7e4b78d73f9e09287079d3e62f53cbc5d04a37"
REPO_URI="${HOMEPAGE}"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="${REPO_URI}"
else
	SRC_URI="${REPO_URI}/archive/${COMMIT_HASH}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${MY_PN}-${COMMIT_HASH}"
fi

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="mirror"

BDEPEND="
	dev-build/make
	virtual/pkgconfig
	sys-fs/fuse:0=
"

CONFIG_CHECK="FUSE_FS"

src_compile() {
	emake
}

src_install() {
	dobin vpk_fuse
}
