# Copyright 2023 Kirixetamine <revelation@krxt.dev>
# Distributed under the terms of the ISC License

EAPI=8

DESCRIPTION="Open source macOS cursors"
HOMEPAGE="https://github.com/ful1e5/apple_cursor"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/ful1e5/apple_cursor"
else
	SRC_URI="https://github.com/ful1e5/apple_cursor/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${P}"
	KEYWORDS="amd64 x86"
fi

LICENSE="GPL-2"
SLOT="0"

BDEPEND="
	>=dev-lang/python-3.7
	>=dev-python/clickgen-2.1.2
	sys-apps/yarn
"

src_compile() {
	yarn build
}

src_install() {
	insinto /usr/share/icons
	doins -r "themes/*"
	einstalldocs
}
