# Copyright 2023-2024 Kirixetamine <revelation@krxt.dev>
# Distributed under the terms of the ISC License.

EAPI=8

inherit xdg desktop savedconfig

DESCRIPTION="Software reverse engineering (SRE) framework"
HOMEPAGE="https://nsa.gov/ghidra"

DATE="20240709"
MY_PN="ghidra"
MY_PV="${PV}_PUBLIC_${DATE}"
MY_P="${MY_PN}_${MY_PV}"

SRC_URI="https://github.com/NationalSecurityAgency/ghidra/releases/download/Ghidra_${PV}_build/${MY_P}.zip -> ${P}.zip"
S="${WORKDIR}/${MY_PN}_${PV}_PUBLIC"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

IUSE="+opengl +optimal-maxmemory"

RESTRICT="mirror strip"

BDEPEND="
	app-alternatives/awk
	app-arch/unzip
	media-gfx/imagemagick
	sys-apps/coreutils
	sys-apps/findutils
	sys-apps/gendesk
	sys-apps/grep
	sys-apps/sed
"

RDEPEND="
	opengl? ( virtual/opengl )
"

src_prepare() {
	if use optimal-maxmemory; then
		einfo   "USE=\"optimal-maxmemory\" enabled."
		ewarn	"Please keep in mind this ONLY sets the max Java heap memory"
		ewarn	"that can be used, through setting -Xmx. This flag will NOT"
		ewarn	"affect the decompiler."
	fi

	elog "Generating desktop file with gendesk"
	gendesk -f -n \
		--pkgname="${PN}"			\
		--name="${MY_PN^}"			\
		--comment="${DESCRIPTION}"	\
		--exec="${MY_PN}-gui"		\
		--icon="${MY_PN}"			\
		--categories="Utility"
	mv "${S}"/ghidra.desktop "${S}"/${PN}.desktop
	elog "Desktop file generated."

	default
	restore_config support/launch.properties
}

src_install() {
	local dest=/opt/${MY_PN}

	if use opengl; then
		# Lets GUI icons render properly on some systems, per the manual
		einfo "OpenGL enabled, setting \"-DSun.java2d.opengl=true\" in VMARGS"
		sed -i -e 's/VMARGS=-Dsun\.java2d\.opengl=false/VMARGS=-Dsun\.java2d\.opengl=true/' \
			"${S}"/support/launch.properties || die "Could not replace OpenGL launch argument"
	fi

	einfo "Installing files to temporary directory"
	insinto "${dest}"
	dodir "${dest}"
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
	domenu "${S}/${PN}.desktop"

	# Is this really the best solution...? >~>
	einfo "Finding all ELF files and running \`chmod\` on them, this can take a while."
	find "${D}"${dest}/ -type f -exec file {} \; | grep 'ELF' | cut -d: -f1 | xargs chmod a+x || die
	chmod -R a+x "${D}"/${dest}/support/* || die
	chmod a+x "${D}"/${dest}/ghidraRun	|| die

	if use optimal-maxmemory; then
		# Ghidra recommends setting 1/4th the amount of physical memory as a limit
		# if the default unlimited memory doesn't suffice for a user.
		local physmem=$(free --giga -h | awk '/^Mem:/ {sub("G", "", $2); print $2}')
		local maxmem=$((physmem / 4))
		einfo "Setting optimal memory limit (${maxmem}GB)"
		sed -i -e "s/#MAXMEM=2G/MAXMEM=${maxmem}G/" "${D}"${dest}/ghidraRun
	fi
	save_config support/launch.properties

	einstalldocs
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update

	einfo   ""
	einfo	"The \"support/launch.properties\" file in the install directory"
	einfo	"provides many startup options that can be tweaked, such as:"
	einfo	""
	einfo	">> -Dcpu.core.override		- Max CPUs Ghidra can use"
	einfo	">> -Dfont.size.override	- Overrides the Java Swing font size"
	einfo	""
	if use savedconfig; then
		ewarn   ""
		ewarn	"*Only* the support/launch.properties file is used, ghidraRun is not."
		ewarn	"This means if you change MAXMEM, that will be lost on the next update."
		ewarn	"This is in case ghidraRun changes after an update, and the program won't launch."
		ewarn   ""
	else
		einfo   "It is advised to enable the \"savedconfig\" USE flag"
		einfo	"to save your \"support/launch.properties\" settings during updates."
		einfo	"More information: https://wiki.gentoo.org/wiki/Savedconfig"
	fi
}
