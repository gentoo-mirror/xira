# Copyright 2023 Kirixetamine <revelation@krxt.dev>
# Distributed under the terms of the ISC License

EAPI=8

inherit cargo

DESCRIPTION="Rust TUI client for steamcmd"
HOMEPAGE="https://github.com/dmadisetti/steam-tui/"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/dmadisetti/steam-tui/"
else
	SRC_URI="https://github.com/dmadisetti/steam-tui/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
			$(cargo_crate_uris)"
	S="${WORKDIR}/${P}"
fi

LICENSE="MIT"
SLOT="0"

RDEPEND="
	games-server/steamcmd
"
BDEPEND="
	virtual/rust
"

src_unpack() {
	if [[ ${PV} == 9999 ]]; then
		git-r3_src_unpack
		cargo_live_src_unpack
	else
		cargo_src_unpack
	fi
}

src_configure() {
	cargo_src_configure
}
