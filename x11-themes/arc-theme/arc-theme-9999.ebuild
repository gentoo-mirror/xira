# Copyright 2023 Kirixetamine
# Distributed under the terms of the ISC License

EAPI=8

inherit meson

DESCRIPTION="A flat theme with transparent elements"
HOMEPAGE="https://github.com/jnsh/arc-theme"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/jnsh/arc-theme"
	LIVE_DEPEND="media-gfx/inkscape"
else
	SRC_URI="https://github.com/jnsh/arc-theme/archive/${PV}.tar.gz"
	S="${WORKDIR}/${P}"
fi

IUSE="+gtk2 +gtk3 +gtk4 +transparency gnome-shell cinnamon xfce"

LICENSE="GPL-3.0"
SLOT="0"

DEPEND="
	x11-themes/gtk-engines-murrine
	x11-themes/gnome-themes-standard
"
RDEPEND="${DEPEND}"

MY_BDEPEND="
	${PYTHON_DEPS}
	dev-util/meson
	dev-lang/sassc
	dev-libs/glib
	cinnamon? ( gnome-extra/cinnamon )
"

if [[ ${PV} == 9999 ]]; then
	BDEPEND="
		${MY_BDEPEND}
		${LIVE_DEPEND}
	"
else
	BDEPEND="
		${MY_BDEPEND}
	"
fi

src_configure() {
	local themes=$(
		printf "%s," \
			$(usev cinnamon "cinnamon metacity") \
			$(usev gnome-shell) \
			$(usev gtk2) \
			$(usev gtk3) \
			$(usev gtk4) \
			$(usev xfce "xfwm")
	)
	local emesonargs=(
		-Dthemes="${themes%,}"
		$(meson_use gnome-shell "gnome_shell_gresource")
		$(meson_use transparency)
	)
	meson_src_configure
}
