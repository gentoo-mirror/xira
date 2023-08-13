# Copyright 2023 Kirixetamine <revelation@krxt.dev>
# Distributed under the terms of the ISC License

EAPI=8

inherit cargo

DESCRIPTION="A fast screenshot tool for wlroots based compositors"
HOMEPAGE="https://git.sr.ht/~shinyzenith/wayshot"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://git.sr.ht/~shinyzenith/wayshot"
else
	SRC_URI="
		https://git.sr.ht/~shinyzenith/wayshot/archive/${PV}.tar.gz -> ${P}.tar.gz
		$(cargo_crate_uris)"
	S="${WORKDIR}/${P}"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="BSD-2"
SLOT="0"
IUSE="man"

BDEPEND="
	virtual/rust

	man? (
		app-text/scdoc
	)
"

src_unpack() {
	if [[ ${PV} == 9999 ]]; then
		git-r3_src_unpack
		eapply "${FILESDIR}/virtual-workspace-resolver-live.patch" && cargo_live_src_unpack
	else
		eapply "${FILESDIR}/virtual-workspace-resolver-live.patch" && cargo_src_unpack
	fi
}

src_compile() {
	cargo_src_compile --all-features
}

src_install() {
	dobin target/release/${PN}
	einstalldocs
}
