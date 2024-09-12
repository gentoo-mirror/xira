# Copyright 2024 Kirixetamine <revelation@krxt.dev>
# Distributed under the terms of the ISC License

EAPI=8

DESCRIPTION="A Risk of Rain 2 Mod Manager in Bash"
HOMEPAGE="https://github.com/Foldex/r2mod_cli"
SRC_URI="https://github.com/Foldex/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${P}"

KEYWORDS="~amd64"

LICENSE="GPL-3"
SLOT="0"

RESTRICT="mirror"

src_compile() {
	sed -i -e "s/io.github.Foldex.r2mod//g" "${S}"/completions/bash/r2mod.sh
}

src_install() {
	emake DESTDIR="${D}" PREFIX="/usr" install
}
