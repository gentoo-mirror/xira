# Copyright 2023 Kirixetamine <revelation@krxt.dev>
# Distributed under the terms of the ISC License

EAPI=8

inherit git-r3

DESCRIPTION="Natron Community Plugins"
HOMEPAGE="
	https://github.com/NatronGitHub/natron-plugins
	https://discuss.pixls.us/c/software/natron
"

EGIT_REPO_URI="https://github.com/NatronGitHub/natron-plugins"
S="${WORKDIR}/${P}"

LICENSE="GPL-2 CC-BY-2.0"
SLOT="0"
RESTRICT="mirror"

RDEPEND="
	media-video/natron-bin
"

src_unpack() {
	git-r3_src_unpack
}

src_install() {
	mkdir -p "${ED}/opt/natron-bin/Plugins/${PN}"	|| die
	mkdir -p "${ED}/usr/share/licenses/${PN}"		|| die
	mkdir -p "${ED}/usr/OFX/Plugins/Shadertoy.ofx.bundle/Contents/Resources/presets/default" || die

	cp -r ${S}/Licenses/* "${ED}/usr/share/licenses/${PN}" || die

	mv ${S}/Shadertoy/Shadertoy.txt \
		${S}/Shadertoy/Shadertoy.txt.natron-plugins || die
	touch ${S}/Shadertoy/Shadertoy.txt.original		|| die

	cp -r ${S}/Shadertoy/* "${ED}/usr/OFX/Plugins/Shadertoy.ofx.bundle/Contents/Resources/presets/default" || die

	cp -r ${S}/* "${ED}/opt/natron-bin/Plugins/${PN}" || die
}

pkg_postinst() {
	einfo "By default, OFX uses /usr/OFX"
	einfo "This is why there is a QA warning."
	einfo "I am not sure as of writing if changing"
	einfo "the directory is possible."
	einfo ""
	einfo "If you know how to change this"
	einfo "please file an issue!"
}
