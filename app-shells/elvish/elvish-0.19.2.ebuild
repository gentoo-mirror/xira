# Copyright 2023 Kirixetamine <revelation@krxt.dev>
# Distributed under the terms of the ISC License

EAPI=8

inherit go-module

DESCRIPTION="An expressive programming language and interactive shell"
HOMEPAGE="https://elv.sh/"
SRC_URI="
	https://github.com/elves/elvish/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://dist.krxt.dev/app-shells/elvish/elvish-${PV}-vendor.tar.xz
"

KEYWORDS="~amd64"
LICENSE="BSD-2"
SLOT="0"

RESTRICT="test"

src_compile() {
	ego build ./cmd/elvish
}

src_install() {
	dobin elvish
}
