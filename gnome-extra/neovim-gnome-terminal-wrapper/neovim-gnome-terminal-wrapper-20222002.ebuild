# Copyright 2024 Kirixetamine <revelation@krxt.dev>
# Distributed under the terms of the ISC License

EAPI=8
PYTHON_COMPAT=( python3_{9..13} )

inherit desktop gnome2-utils python-single-r1 xdg

DESCRIPTION="Wrapper for running neovim in a separate instance of gnome-terminal"
HOMEPAGE="https://github.com/fmoralesc/neovim-gnome-terminal-wrapper"

REPO_URI="https://github.com/fmoralesc/neovim-gnome-terminal-wrapper"

SRC_URI="${REPO_URI}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${P}"


LICENSE="GPL-3"
SLOT="0"

DEPEND="
	dev-python/dbus-python
	x11-terms/gnome-terminal
	app-editors/neovim
"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="
	${DEPEND}
	${PYTHON_DEPS}
"

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
