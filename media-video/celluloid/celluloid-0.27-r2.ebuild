# Copyright 2024 Kirixetamine <revelation@krxt.dev>
# Distributed under the terms of the ISC License

EAPI=8

DESCRIPTION="A simple GTK+ frontend for mpv"
HOMEPAGE="https://celluloid-player.github.io/"

inherit gnome2-utils meson xdg

SRC_URI="https://github.com/celluloid-player/${PN}/releases/download/v${PV}/${P}.tar.xz"
S="${WORKDIR}/${P}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	>=dev-libs/glib-2.66
	>=gui-libs/gtk-4.10
	>=gui-libs/libadwaita-1.4.0
	media-libs/libepoxy
	>=media-video/mpv-0.32:=[libmpv]
"
RDEPEND="${DEPEND}"
BDEPEND="
	dev-libs/appstream-glib
	virtual/pkgconfig
"

RESTRICT="mirror"

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
}
