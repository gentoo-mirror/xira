# Copyright 2023 Kirixetamine <revelation@krxt.dev>
# Distributed under the terms of the ISC License

EAPI=8

inherit gnome2-utils cargo xdg xdg-utils

DESCRIPTION="Cross-platform GUI using ADB to debloat non-rooted Android devices"

HOMEPAGE="https://github.com/0x192/universal-android-debloater"

REPO_URI="https://github.com/0x192/universal-android-debloater"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="${REPO_URI}"
else
	SRC_URI="${REPO_URI}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${P}"
fi

LICENSE="GPL-3"
SLOT="0"

DEPEND="
	dev-util/android-tools
"

RDEPEND="${DEPEND}"

BDEPEND="
	=virtual/rust-1.72.0-r1
"

RESTRICT="test"

src_prepare() {
	default
	xdg_environment_reset
}

src_unpack() {
	if [[ ${PV} == 9999 ]]; then
		git-r3_src_unpack
		cargo_live_src_unpack
	else
		cargo_src_unpack
	fi
}

src_install() {
	default
	dobin target/release/uad_gui
}

pkg_postinst() {
	gnome2_schemas_update
	xdg_icon_cache_update
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}

pkg_postrm() {
   gnome2_schemas_update
   xdg_icon_cache_update
   xdg_desktop_database_update
   xdg_mimeinfo_database_update
}
