# Copyright 2023 Kirixetamine <revelation@krxt.dev>
# Distributed under the terms of the ISC License

EAPI=8

inherit autotools

DESCRIPTION="A lightweight multi-protocol download utility"
HOMEPAGE="https://aria2.github.io/"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/aria2/aria2"
else
	SRC_URI="https://github.com/aria2/aria2/releases/download/release-${PV}/${P}.tar.xz"
	S="${WORKDIR}/${P}"
fi

LICENSE="GPL-2+-with-openssl-exception"
SLOT="0"
IUSE="jemalloc tcmalloc"

REQUIRED_USE="
	?? ( jemalloc tcmalloc )
"

RESTRICT="test"

DEPEND="
	dev-libs/openssl
	net-dns/c-ares
	sys-libs/zlib
"
RDEPEND="${DEPEND}"
BDEPEND="
	dev-util/cppunit
	virtual/pkgconfig
"

PATCHES=(
	"${FILESDIR}/cxx17-functions.patch"
)

src_configure() {
	local conf=(
		--disable-xmltest
		--disable-websocket
		--enable-libaria2
		--with-libz
		--with-openssl
		--with-ca-bundle="${EPREFIX}/etc/ssl/certs/ca-certificates.crt"

		$(use_with jemalloc)
		$(use_with tcmalloc)
	)

	econf "${conf[@]}" || die
}

src_install() {
	default
}
