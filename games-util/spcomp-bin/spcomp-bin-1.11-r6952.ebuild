# Copyright 2024 Kirixetamine <revelation@krxt.dev>
# Distributed under the terms of the ISC License

EAPI=8

DESCRIPTION="SourcePawn compiler developed by the SourceMod team"
HOMEPAGE="https://sourcemod.net/"

SUBVER="0"
GITREV="6952"
SRC_URI="https://sm.alliedmods.net/smdrop/${PV}/sourcemod-${PV}.${SUBVER}-git${GITREV}-linux.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2+ GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
S="${WORKDIR}"
RESTRICT="mirror"

src_unpack() {
	default
}

src_install() {
	pushd "${S}"
	for i in spcomp spcomp64; do
		dobin ./addons/sourcemod/scripting/${i}
	done
}
