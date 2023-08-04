# Copyright 2023 Kirixetamine <revelation@krxt.dev>
# Distributed under the terms of the ISC License

EAPI=8

inherit go-module

DESCRIPTION="An expressive programming language and interactive shell"
HOMEPAGE="https://elv.sh/"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/elves/elvish"
else
	SRC_URI="
		https://github.com/elves/elvish/archive/v${PV}.tar.gz -> ${P}.tar.gz
		https://dist.krxt.dev/app-shells/elvish/elvish-${PV}-vendor.tar.xz"
	S="${WORKDIR}/${P}"
	KEYWORDS="~amd64"
fi

LICENSE="BSD-2"
SLOT="0"

RESTRICT="test"

src_unpack() {
	if [[ ${PV} == 9999 ]]; then
		git-r3_src_unpack
		go-module_live_vendor
		go-module_src_unpack
	else
		go-module_src_unpack
	fi
}

src_compile() {
	ego build ./cmd/elvish
}

src_install() {
	dobin elvish
}
