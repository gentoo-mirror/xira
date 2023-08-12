# Copyright 2023 Kirixetamine <revelation@krxt.dev>
# Distributed under the terms of the ISC License

EAPI=8

inherit cargo

DESCRIPTION="Keep Wayland clipboard after programs close"
HOMEPAGE="https://github.com/Linus789/wl-clip-persist"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Linus789/wl-clip-persist"
else
	EGIT_COMMIT="${COMMIT}"
	SRC_URI="
		https://github.com/Linus789/wl-clip-persist/archive/${EGIT_COMMIT}.tar.gz -> ${PN}-${EGIT_COMMIT}.tar.gz
		$(cargo_crate_uris)"
	S="${WORKDIR}/${PN}-${EGIT_COMMIT}"
	KEYWORDS="~amd64"
fi

LICENSE="MIT"
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
