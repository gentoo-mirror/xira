# Copyright 2023 Kirixetamine <revelation@krxt.dev>
# Distributed under the terms of the ISC License

EAPI=8
PYTHON_COMPAT=( python3_{9..12} )

inherit desktop gnome2-utils python-single-r1 xdg xdg-utils

DESCRIPTION="Wrapper for running neovim in a separate instance of gnome-terminal"
HOMEPAGE="https://github.com/fmoralesc/neovim-gnome-terminal-wrapper"

REPO_URI="https://github.com/fmoralesc/neovim-gnome-terminal-wrapper"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="${REPO_URI}"
else
	SRC_URI="${REPO_URI}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${P}"
fi

LICENSE="GPL-3"
SLOT="0"

# Nettle compiled with SHA x86 flag causes SIGILL
# when opening "Manage presets"
# Only thing I could find about this is an issue for
# another program suffering from the same issue.
# https://gitlab.com/gnutls/gnutls/-/issues/1496
DEPEND="
	dev-python/dbus-python
	x11-terms/gnome-terminal
	app-editors/neovim
"

RDEPEND="${DEPEND}"

BDEPEND="
	${PYTHON_DEPS}
"

RESTRICT="test"

src_prepare() {
	default
	xdg_environment_reset
}

src_configure() {
	default
	sed -i 's/Icon=neovim/Icon=nvim/g' neovim.desktop
}

src_install() {
	python_optimize
	dobin nvim-wrapper
	newmenu neovim.desktop neovim-gnome.desktop
	insinto /usr/share/icons/
	newins neovim.svg neovim-gnome.svg
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
