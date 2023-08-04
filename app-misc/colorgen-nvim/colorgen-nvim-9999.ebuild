# Copyright 2023 Kirixetamine <revelation@krxt.dev>
# Distributed under the terms of the ISC License

EAPI=8

inherit cargo

DESCRIPTION="Blazingly fast colorscheme generator for Neovim, written in Rust"
HOMEPAGE="https://github.com/LunarVim/colorgen-nvim/"
if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/LunarVim/colorgen-nvim"
	S="${WORKDIR}/${P}"
else
	SRC_URI="https://github.com/LunarVim/${PN}/archive/${PV}.tar.gz
			$(cargo_crate_uris)"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
SLOT="0"

BDEPEND="
	virtual/rust
"

#PATCHES=(
#	"${FILESDIR}/rustc-1.71-deps.patch"
#)

# PATCHES and src_prepare() can't be used for this
# Patches are applied AFTER fetching crates with old versions
src_unpack() {
	if [[ ${PV} == 9999 ]]; then
		git-r3_src_unpack
		eapply "${FILESDIR}/rustc-1.71-deps.patch" && cargo_live_src_unpack
	else
		eapply "${FILESDIR}/rustc-1.71-deps.patch" && cargo_src_unpack
	fi
}

src_configure() {
	cargo_src_configure
}

src_compile() {
	cargo_src_compile
}

src_install() {
	cargo_src_install
}
