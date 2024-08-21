# Copyright 2023-2024 Kirixetamine <revelation@krxt.dev>
# Distributed under the terms of the ISC License

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{7..12} )

inherit distutils-r1 pypi

DESCRIPTION="Python library to interact with keepass databases"
HOMEPAGE="
	https://github.com/libkeepass/pykeepass/
	https://pypi.org/project/pykeepass/
"

SRC_URI="$(pypi_sdist_url "${PN}" "${PV}.post1")"
S="${WORKDIR}/${P}.post1"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/argon2-cffi-23.1.0[${PYTHON_USEDEP}]
	>=dev-python/construct-2.10.70[${PYTHON_USEDEP}]
	>=dev-python/lxml-5.2.2[${PYTHON_USEDEP}]
	>=dev-python/pycryptodome-3.20.0[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"
RESTRICT="mirror"

src_prepare() {
	distutils-r1_src_prepare
	sed -i 's/Cryptodome/Crypto/g' pykeepass/kdbx_parsing/{common,twofish}.py || die
}
