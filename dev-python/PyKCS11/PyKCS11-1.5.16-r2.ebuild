# Copyright 2024 Kirixetamine <revelation@krxt.dev>
# Distributed under the terms of the ISC License

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{7..13} )

inherit distutils-r1 pypi

DESCRIPTION="Full PKCS#11 wrapper for Python"
HOMEPAGE="
	https://github.com/LudovicRousseau/PyKCS11
	https://pypi.org/project/PyKCS11
"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="
	dev-lang/swig
"
RDEPEND="
	dev-python/asn1crypto[${PYTHON_USEDEP}]
"
RESTRICT="mirror"

distutils_enable_tests pytest
