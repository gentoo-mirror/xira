# Copyright 2023 Kirixetamine <revelation@krxt.dev>
# Distributed under the terms of the ISC License

EAPI=8
PYTHON_COMPAT=( python3_{9..12} )

inherit gnome2-utils meson python-single-r1 xdg-utils

DESCRIPTION="A password manager made for the GNOME desktop"
HOMEPAGE="https://gitlab.gnome.org/World/secrets/"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.gnome.org/World/secrets"
else
	SRC_URI="https://gitlab.gnome.org/World/secrets/-/archive/${PV}/secrets-${PV}.tar.gz"
	S="${WORKDIR}/${P}"
fi

LICENSE="GPL-3"
SLOT="0"

RDEPEND="
	${PYTHON_DEPS}
	>=dev-libs/glib-2.73.1
	>=dev-libs/gobject-introspection-1.66.0
	>=gui-libs/gtk-4.9
	>=gui-libs/libadwaita-1.4_beta
	>=dev-python/pykeepass-4.0.6
	dev-python/pyotp
	dev-python/validators
	dev-python/zxcvbn
"
BDEPEND="${RDEPEND}" # Redundant?

RESTRICT="test"

src_prepare() {
	default

	# Prevents python being unable to find module
	# ModuleNotFoundError: No module named 'Cryptodome'
	sed -i 's/Cryptodome/Crypto/g' gsecrets/utils.py	|| die
	sed -i '/gnome.post_install/,$d' meson.build		|| die
}

src_install() {
	meson_src_install
	python_optimize

	sed -i '1s/.*/#!\/usr\/bin\/env python3/' "${D}/usr/bin/secrets"
}

src_test() {
	virtx meson_src_test
}

# Required, else won't start
pkg_postinst() {
	gnome2_schemas_update
	xdg_icon_cache_update
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}

# Clean unnecessary things
pkg_postrm() {
   gnome2_schemas_update
   xdg_icon_cache_update
   xdg_desktop_database_update
   xdg_mimeinfo_database_update
}
