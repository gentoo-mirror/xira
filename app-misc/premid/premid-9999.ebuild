# Copyright 2023 Kirixetamine <revelation@krxt.dev>
# Distributed under the terms of the ISC License

EAPI=8

inherit xdg-utils

DESCRIPTION="PreMiD adds Discord Rich Presence support to a lot of services you use and love"
HOMEPAGE="https://github.com/PreMiD/Linux"
#EPOCH_STAMP="1703429315"
#MY_PV="${PV}-${EPOCH_STAMP}"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/PreMiD/Linux"
	S="${WORKDIR}/${P}"
else
	SRC_URI="
		https://github.com/PreMiD/Linux/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	"
	S="${WORKDIR}/Linux-${PV}"
	KEYWORDS="~amd64"
fi

LICENSE="MPL-2.0"
SLOT="0"
RESTRICT="mirror build-online? ( network-sandbox )"

DEPEND="
	net-libs/nodejs
"

BDEPEND="
	sys-apps/yarn
"

IUSE="+build-online"

src_unpack() {
	if [[ ${PV} == 9999 ]]; then
		git-r3_src_unpack
	else
		default
	fi
}

src_configure() {
	if ! use build-online ; then
		eerror "PreMiD does not provide node_modules, and USE flag build-online"
		eerror "is not enabled. Please enable the build-online flag."
		eerror "Aborting."
		die
	fi
	yarn config set disable-self-update-check		       				|| die
	mv ${HOME}/.yarnrc ${S}/.yarnrc						    			|| die
	yarn install --frozen-lockfile ${NETWORK_MODE}				        || die
}

src_compile() {
	yarn run dist ${NETWORK_MODE} || die
	yarn run electron-builder --project ./dist/app/ build --dir -p never || die
}

src_install() {
	mkdir -p "${ED}/opt/${PN}"
	mkdir -p "${ED}/usr/bin"
	mkdir -p "${ED}/usr/share/applications"
	mkdir -p "${ED}/usr/share/pixmaps"

	pushd ${S}/dist/app/dist/linux-unpacked || die
		# QA notice about proper XDG Icon entry
		sed -i 's/Icon=premid\.png/Icon=premid/' assets/premid.desktop

		cp -r * "${ED}/opt/${PN}/"
		cp assets/appIcon.png "${ED}/usr/share/pixmaps/premid.png"
		cp assets/premid.desktop "${ED}/usr/share/applications"
	popd || die

	ln -sf /opt/premid/premid "${ED}/usr/bin/premid"

	einstalldocs
}

pkg_postinst() {
	xdg_icon_cache_update
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_icon_cache_update
	xdg_desktop_database_update
}
