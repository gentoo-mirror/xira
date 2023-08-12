# Copyright 2023 Kirixetamine <revelation@krxt.dev>
# Distributed under the terms of the ISC License

EAPI=8

inherit cmake

DESCRIPTION="A wlroots-compatible Wayland color picker that does not suck."
HOMEPAGE="https://github.com/hyprwm/hyprpicker"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/hyprwm/hyprpicker"
else
	SRC_URI="https://github.com/hyprwm/hyprpicker/releases/download/v${PV}/v${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${P}"
fi

LICENSE="BSD"
SLOT="0"

BDEPEND="
	dev-libs/wayland
	dev-libs/wayland-protocols
	dev-util/cmake
	dev-util/wayland-scanner
	media-libs/libglvnd
	media-libs/libjpeg-turbo
	x11-libs/cairo
	x11-libs/pango
"

src_configure() {
	if tc-is-gcc; then
		[[ $(gcc-major-version) -ge 12 ]] && [[ $(gcc-minor-version) -ge 1 ]] && export CC_IS_GCC=1 || die "Hyprpicker requires GCC >= 12.1 for C++23 support"
	elif tc-is-clang; then
		[[ $(clang-major-version) -ge 16 ]] && \
			export CC_IS_CLANG=1 && \
			# Clang 16, at least 16.0.6 for me, does not accept "-std=c++23"
			# But accepts "-std=c++2b"
			eapply "${FILESDIR}/clang16-cxx23.patch" \
			|| die "Hyprpicker requires Clang >= 16 for C++23 support, 17 being preferred"
	fi
	cmake_src_configure
}

src_compile() {
	emake protocols
	cmake_src_compile
}

src_install() {
dobin "${BUILD_DIR}/${PN}"
}
