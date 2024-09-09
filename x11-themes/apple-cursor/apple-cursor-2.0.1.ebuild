# Copyright 2024 Kirixetamine <revelation@krxt.dev>
# Distributed under the terms of the ISC License

EAPI=8

DESCRIPTION="Open source macOS cursors"
HOMEPAGE="https://github.com/ful1e5/apple_cursor"

SRC_URI="https://github.com/ful1e5/apple_cursor/releases/download/v${PV}/macOS.tar.xz -> ${P}.tar.xz"
S="${WORKDIR}"

LICENSE="GPL-2"
SLOT="0"

RESTRICT="mirror"

src_install() {
	local themes=(
		macOS
		macOS-White
	)

	insinto /usr/share/icons
	for theme in ${themes[@]}; do
		doins -r "${S}/${theme}"
	done
}
