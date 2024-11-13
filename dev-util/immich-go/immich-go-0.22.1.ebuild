# Copyright 2024 Kirixetamine <revelation@krxt.dev>
# Distributed under the terms of the ISC License

EAPI=8

inherit go-module

DESCRIPTION="Go alternative for immich-CLI"
HOMEPAGE="
	https://github.com/simulot/immich-go
"

SRC_URI="
	https://github.com/simulot/immich-go/archive/${PV}.tar.gz -> ${P}.tar.gz
	https://dist.krxt.dev/dev-util/immich-go/${P}-vendor.tar.xz
	"
S="${WORKDIR}/${P}"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="mirror"

src_compile() {
	ego build -v -ldflags "-X 'main.version=${PV}' -X 'main.builtBy=xira'" -trimpath
}

src_install() {
	default
	dobin ${PN}

	einstalldocs
}
