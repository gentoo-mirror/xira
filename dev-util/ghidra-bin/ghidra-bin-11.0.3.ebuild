# Copyright 1999-2023 Kirixetamine <revelation@krxt.dev>
# Distributed under the terms of the ISC License.

EAPI=8

inherit xdg-utils desktop

DESCRIPTION="Ghidra is a software reverse engineering (SRE) framework"
HOMEPAGE="https://nsa.gov/ghidra"
LICENSE="Apache-2.0"
SLOT="0"

DATE="20240410"
MY_PN="ghidra"
MY_PV="${PV}_PUBLIC_${DATE}"
MY_P="${MY_PN}_${MY_PV}"

SRC_URI="https://github.com/NationalSecurityAgency/ghidra/releases/download/Ghidra_${PV}_build/${MY_P}.zip -> ${P}.zip"
S="${WORKDIR}/${MY_PN}_${PV}_PUBLIC"

KEYWORDS="~amd64"

RESTRICT="mirror strip"

BDEPEND="
	media-gfx/imagemagick
"

src_install() {
	einstalldocs

	domenu "${FILESDIR}/${MY_PN}.desktop"

	# Lets GUI icons render properly on some systems, per the manual
	sed -i -e 's/VMARGS=-Dsun\.java2d\.opengl=false/VMARGS=-Dsun\.java2d\.opengl=true/' ${S}/support/launch.properties

	local dest=/opt/${MY_PN}

	dodir "${dest}"
	insinto "${dest}"
	doins -r .

	dodir /usr/bin
	dosym ${dest}/support/launch.sh /usr/bin/ghidra-cli || die
	dosym ${dest}/ghidraRun /usr/bin/ghidra-gui || die

	for i in 16 22 24 32 48 64 96 128 256; do
		magick "${ED}/opt/${MY_PN}/docs/images/GHIDRA_1.png" \
			-resize "${i}x${i}" "${S}/icon_app${i}.png"			|| die
		mkdir -p "${ED}/usr/share/icons/hicolor/${i}x${i}/apps/"	|| die
		cp "${S}/icon_app${i}.png" "${ED}/usr/share/icons/hicolor/${i}x${i}/apps/${MY_PN}.png"	|| die
	done

	elog "Finding all ELF files and running \`chmod\` on them... Please wait."
	find ${D}${dest}/ -type f -exec file {} \; | grep 'ELF' | cut -d: -f1 | xargs chmod a+x || die
	chmod -R a+x ${D}/${dest}/support/* || die
	chmod a+x ${D}/${dest}/ghidraRun	|| die
	elog "Finished."
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}
