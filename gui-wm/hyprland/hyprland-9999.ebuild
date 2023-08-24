# Copyright 2023 Kirixetamine <revelation@krxt.dev>
# Distributed under the terms of the ISC License

EAPI=8

inherit meson systemd

DESCRIPTION="Dynamic tiling Wayland compositor that doesn't sacrifice on its looks."
HOMEPAGE="https://hyprland.org"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/hyprwm/Hyprland"
else
	SRC_URI="https://github.com/hyprwm/Hyprland/releases/download/v${PV}/source-v${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/hyprland-source"
	KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0"
IUSE="systemd X hidpi"

DEPEND="
	dev-libs/libevdev
	dev-libs/libinput
	dev-libs/libliftoff
	dev-libs/wayland
	gui-libs/gtk-layer-shell
	media-libs/glm
	media-libs/mesa:=[gles2,wayland,X?]
	media-libs/libdisplay-info
	media-libs/libglvnd[X?]
	media-libs/libjpeg-turbo
	media-libs/libpng
	media-libs/freetype:=[X?]
	>=x11-libs/libdrm-2.4.114:=
	x11-libs/gtk+:3=[wayland,X?]
	x11-libs/cairo:=[X?,svg(+)]
	x11-libs/libxkbcommon:=[X?]
	x11-libs/pixman
	systemd? (
		sys-apps/systemd
	)
	X? (
		x11-libs/libxcb
		x11-base/xorg-proto
		x11-base/xcb-proto
		>=x11-base/xwayland-23.2.0
	)
"
RDEPEND="
	${DEPEND}
	x11-misc/xkeyboard-config
"
BDEPEND="
	app-misc/jq
	>=dev-libs/wayland-protocols-1.27
	virtual/pkgconfig
"

pkg_setup() {
	if use hidpi; then
		ewarn "Xwayland scaling patches are NOT SUPPORTED by upstream"
		ewarn "Use the \"hidpi\" flag at your own discertion."
	fi
}

src_configure() {
	if tc-is-gcc; then
		[[ $(gcc-major-version) -ge 12 ]] && [[ $(gcc-minor-version) -ge 1 ]] && export CC_IS_GCC=1 || die "Hyprland requires GCC >= 12.1 for C++23 support"
	elif tc-is-clang; then
		[[ $(clang-major-version) -ge 16 ]] && export CC_IS_CLANG=1 || die "Hyprland requires Clang >= 16 for C++23 support"
	fi

	if use hidpi; then
		eapply -Np1 "${FILESDIR}/0001-xwayland-support-HiDPI-scale.patch"
		eapply -Np1 "${FILESDIR}/0002-Fix-configure_notify-event.patch"
		eapply -Np1 "${FILESDIR}/0003-Fix-size-hints-under-Xwayland-scaling.patch"
	fi

	meson_src_configure
}

src_install() {
	meson_src_install --skip-subprojects
}
