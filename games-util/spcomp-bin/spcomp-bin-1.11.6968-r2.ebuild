# Copyright 2024 Kirixetamine <revelation@krxt.dev>
# Distributed under the terms of the ISC License

EAPI=8

DESCRIPTION="SourcePawn compiler developed by the SourceMod team"
HOMEPAGE="https://sourcemod.net/"

MAJ_VER="1.11"
MIN_VER="0"
GITREV="6968"
SRC_URI="
	https://sm.alliedmods.net/smdrop/${MAJ_VER}/sourcemod-${MAJ_VER}.${MIN_VER}-git${GITREV}-linux.tar.gz -> ${P}.tar.gz
	"
S="${WORKDIR}"

LICENSE="GPL-2+ GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"

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
