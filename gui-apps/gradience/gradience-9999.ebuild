# Copyright 2023 Kirixetamine <revelation@krxt.dev>
# Distributed under the terms of the ISC License

EAPI=8
PYTHON_COMPAT=( python3_{9..12} )

inherit gnome2-utils meson python-single-r1 xdg xdg-utils

DESCRIPTION="Change the look of Adwaita, with ease"
HOMEPAGE="https://github.com/GradienceTeam/Gradience"

REPO_URI="https://github.com/GradienceTeam/Gradience"

MY_PV="${PV/\_/\-}"


# gtk3 apply patch taken from here
# https://github.com/GradienceTeam/Gradience/pull/813
if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="${REPO_URI}"
	PATCHES=(
		"${FILESDIR}/fix-gtk3-apply-crashing.patch"
	)
else
	SRC_URI="${REPO_URI}/archive/${MY_PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/Gradience-${MY_PV}"
	if [[ ${PV} == "0.8.0_beta1" ]]; then
		PATCHES=(
			"${FILESDIR}/exclude-submodules-meson.patch"
			"${FILESDIR}/fix-gtk3-apply-crashing.patch"
		)
	fi
fi

LICENSE="GPL-3"
SLOT="0"

# Nettle compiled with SHA x86 flag causes SIGILL
# when opening "Manage presets"
# Only thing I could find about this is an issue for
# another program suffering from the same issue.
# https://gitlab.com/gnutls/gnutls/-/issues/1496
DEPEND="
	dev-libs/libportal[gtk]
	dev-libs/nettle[-cpu_flags_x86_sha]
	>=gui-libs/libadwaita-1.3.3
	gui-libs/gtk
	net-libs/libsoup
	dev-python/anyascii
	dev-python/material-color-utilities
	dev-python/pygobject
	dev-python/svglib
	dev-python/yapsy
	dev-python/jinja
	dev-python/libsass
"

RDEPEND="${DEPEND}"

BDEPEND="
	${PYTHON_DEPS}
	dev-lang/sassc
	dev-libs/gobject-introspection
	dev-libs/glib:2
	net-libs/libsoup
	dev-util/blueprint-compiler
"

RESTRICT="test"

src_prepare() {
	default
	xdg_environment_reset
}

src_install() {
	meson_src_install
	python_optimize
    mv "${ED}"/usr/share/appdata "${ED}"/usr/share/metainfo || die
}

src_test() {
	virtx meson_src_test
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
