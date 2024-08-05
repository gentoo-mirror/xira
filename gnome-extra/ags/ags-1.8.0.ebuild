# Copyright 2024 Kirixetamine <revelation@krxt.dev>
# Distributed under the terms of the ISC License

EAPI=7

inherit meson gnome2-utils

DESCRIPTION="A customizable and extensible shell"
HOMEPAGE="https://github.com/Aylur/ags"

MY_NODE_D="node_modules"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Aylur/ags"
	EGIT_SUBMODULES=( "subprojects/gvc" )
else
	SRC_URI="
		https://github.com/Aylur/ags/releases/download/v${PV}/${PN}-v${PV}.tar.gz -> ${P}.tar.gz
		https://github.com/Aylur/ags/releases/download/v${PV}/${MY_NODE_D}-v${PV}.tar.gz
	"
	S="${WORKDIR}/${PN}"
	KEYWORDS="~amd64"
fi


LICENSE="GPL-3"
RESTRICT="mirror"
SLOT="0"
IUSE="hyprland"

DEPEND="
	dev-libs/gjs
	x11-libs/gtk+
	gui-libs/gtk-layer-shell[introspection]
	net-wireless/gnome-bluetooth

	sys-power/upower
	net-misc/networkmanager
	dev-libs/gobject-introspection
	dev-libs/libdbusmenu[gtk3]
"
BDEPEND="
	net-libs/nodejs
	dev-lang/typescript
"

# FIXME: This should probably be avoided...
# It's possibly redundant, ags is mostly used on hyprland.
RDEPEND="
	hyprland? ( gui-wm/hyprland )
"

src_unpack() {
	if [[ ${PV} == 9999 ]]; then
		git-r3_src_unpack
		default
	else
		default
	fi
}

# See https://github.com/mesonbuild/meson#9300
PATCHES=(
	"${FILESDIR}"/meson-add-run_command-check.patch
)

BUILD_DIR="${S}/build"
MY_NODE_DIR="${S}/${MY_NODE_D}"

src_prepare() {
	default
	# Move node_modules dir to use them correctly.
	einfo "Moving node_modules dir"
	mv "${WORKDIR}/${MY_NODE_D}" "${MY_NODE_DIR}" || die "Couldn't move node_modules to ${S}"
	einfo "node_modules dir moved"
}

src_configure() {
	default
	local emesonargs=(
		-Dbuild_types="true"
	)
	meson_src_configure || die
}

src_compile() {
	default
	meson_src_compile || die
}

src_install() {
	meson_src_install --destdir "${D}" # Can't use die on this, due to custom script
}

pkg_postinst() {
	elog "To learn on how to use ags, please read"
	elog "https://aylur.github.io/ags-docs/"
	elog "which describes its usage and configuration."
}
