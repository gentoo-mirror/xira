# Copyright 2023 Kirixetamine <revelation@krxt.dev>
# Distributed under the terms of the ISC License

EAPI=8

PYTHON_COMPAT=( python3_{9..12} )

inherit python-any-r1

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
	dev-python/attrs
	sys-apps/yarn
"

src_compile() {
	yarn build
}

src_install() {
	local themes=(
		macOS-BigSur
		macOS-BigSur-White
		macOS-Monterey
		macOS-Monterey-White
	)
	insinto /usr/share/icons
	for theme in ${themes[@]}; do
		doins -r "themes/${theme}"
	done
	einstalldocs
}
