# Copyright 2023 Kirixetamine <revelation@krxt.dev>
# Distributed under the terms of the ISC License

EAPI=8

DISTUTILS_USE_PEP517="setuptools"
PYTHON_COMPAT=( python3_{10..12} )
inherit distutils-r1 pypi

DESCRIPTION="Cryptographic library for Python"
HOMEPAGE="
	https://github.com/Legrandin/pycryptodome/
	https://www.pycryptodome.org
	https://pypi.org/project/pycryptodomex/"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64"
IUSE="test"
RESTRICT="mirror"

DOCS="README.rst"

BDEPEND="
	test? (
		dev-python/pytest[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

python_test() {
	epytest testing
}
