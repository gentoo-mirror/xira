# Copyright 2023 Kirixetamine <revelation@krxt.dev>
# Distributed under the terms of the ISC License

EAPI=8

DESCRIPTION="A Risk of Rain 2 Mod Manager in Bash"
HOMEPAGE="https://github.com/Foldex/r2mod_cli"
LICENSE="GPL-3"
SLOT="0"

RESTRICT="mirror"

if [[ ${PV} = 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Foldex/${PN}.git"
else
	SRC_URI="https://github.com/Foldex/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

src_configure() {
	# emake install DESTDIR="${D}" does not work, for some reason.
	sed -i -e "s@DESTDIR = \/usr@DESTDIR = ${ED}@" Makefile
	sed -i -e "s/io.github.Foldex.r2mod//g" "${S}"/completions/bash/r2mod.sh
	default
}

src_install() {
	emake -j1 install PREFIX="/usr"
}
