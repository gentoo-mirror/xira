# Copyright 1999-2023 Kirixetamine <revelation@krxt.dev>
# Distributed under the terms of the ISC License.

EAPI=8

inherit xdg-utils desktop

DESCRIPTION="Visual context programming language"
HOMEPAGE="https://processing.org/"
LICENSE="GPL-2 LGPL-2.1"
SLOT="0"

MY_PN="processing"
MY_PV="1293-${PV}"
MY_P="${MY_PN}-${MY_PV}"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/benfry/processing4"
else
	SRC_URI="https://github.com/benfry/processing4/releases/download/${MY_P}/${MY_PN}-${PV}-linux-x64.tgz"
	S="${WORKDIR}/${MY_PN}-${PV}"
	KEYWORDS="~amd64"
fi

RESTRICT="mirror strip"

src_install() {
	einstalldocs

	domenu "${FILESDIR}/${MY_PN}.desktop"

	local dest=/opt/${MY_P}

	dodir "${dest}"
	insinto "${dest}"
	doins -r .

	dodir /usr/bin
	for command in processing processing-java; do
		dosym "${dest}"/${command} /usr/bin/${command} || die
	done
	chmod a+x "${D}/${dest}"/java/bin/* || die
	chmod a+x "${D}/${dest}"/processing* || die
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}
