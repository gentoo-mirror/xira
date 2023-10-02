# Copyright 2023 Kirixetamine <revelation@krxt.dev>
# Distributed under the terms of the ISC License

EAPI=8
PYTHON_COMPAT=( python3_{9..12} )

inherit gnome2-utils meson cargo xdg xdg-utils

DESCRIPTION="Trim videos quickly"

HOMEPAGE="https://gitlab.gnome.org/YaLTeR/video-trimmer"

REPO_URI="https://gitlab.gnome.org/YaLTeR/video-trimmer"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="${REPO_URI}"
	PATCHES=("${FILESDIR}/cargo-frozen-flag.patch")
else
	SRC_URI="${REPO_URI}/-/archive/${P}.tar.gz"
	S="${WORKDIR}/${P}"
fi

LICENSE="GPL-3"
SLOT="0"

DEPEND="
	>=gui-libs/libadwaita-1.4.0
	gui-libs/gtk
"

RDEPEND="${DEPEND}"

BDEPEND="
	virtual/rust
	dev-util/blueprint-compiler
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

src_configure() {
	meson_src_configure # Required for config.rs.in replacements
	cargo_src_configure
}

# Both meson and cargo compile commands are needed
# As we heavily modify the repo, but meson is still needed for configuration
# outside of src_configure (wish it wasn't here though)
src_compile() {
	meson_src_compile
	cargo_src_compile
}

src_install() {
	meson_src_install
	cargo_src_install
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
