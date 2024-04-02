# Copyright 2024 Kirixetamine <revelation@krxt.dev>
# Distributed under the terms of the ISC License

EAPI=8

DESCRIPTION="POSIX shell fork of lddtree.sh from Gentoo's pax-utils"
HOMEPAGE="https://github.com/ncopa/lddtree"
LICENSE="GPL-2"
SLOT="0"

RESTRICT="mirror"

if [[ ${PV} = 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/ncopa/lddtree.git"
else
	SRC_URI="https://github.com/ncopa/lddtree/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/lddtree-${PV}"
	KEYWORDS="~amd64"

fi

IUSE="test"

BDEPEND="
	test? (
		dev-util/kyua
		dev-util/shellcheck
	)
"

RDEPEND="
	|| ( sys-devel/binutils app-misc/pax-utils )
"

PATCHES="${FILESDIR}/respect-library-path-envvar.patch"

src_compile() {
	# Nothing needs to be done here.
	# By default portage calls emake here, but the
	# Makefile is only used for testing.
	true
}

src_test() {
	emake || die
}

src_install() {
	# To not conflict with app-micsc/pax-utils
	# this will be called lddtree-sh.
	# If someone can come up with a better substitute
	# for the name, feel free to open an issue about it.
	mv lddtree.sh lddtree-sh
	dobin lddtree-sh
}
