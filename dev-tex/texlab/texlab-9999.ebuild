# Copyright 2023 Kirixetamine <revelation@krxt.dev>
# Distributed under the terms of the ISC License

EAPI=8

inherit cargo

DESCRIPTION="An implementation of LSP for LaTeX"
HOMEPAGE="https://github.com/latex-lsp/texlab"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/latex-lsp/texlab"
else
	SRC_URI="https://github.com/latex-lsp/texlab/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
SLOT="0"

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

src_compile() {
	cargo_src_compile --frozen --all-features
}

src_install() {
	dobin target/release/${PN}
	einstalldocs
}
