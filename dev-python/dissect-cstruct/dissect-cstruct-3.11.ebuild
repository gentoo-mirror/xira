# Copyright 2023 Kirixetamine <revelation@krxt.dev>
# Distributed under the terms of the ISC License

EAPI=8

DISTUTILS_USE_PEP517="setuptools"
PYTHON_COMPAT=( pypy3 python3_{8..11} )

inherit distutils-r1 pypi

MY_PN="dissect.cstruct"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A Dissect module implementing a parser for C-like structures"
HOMEPAGE="
	https://github.com/fox-it/dissect.cstruct
	https://pypi.org/project/dissect.cstruct
"

SRC_URI="
	https://files.pythonhosted.org/packages/1e/4f/3849fd754b5650f075ab69f154da5112ff742ace83d73f7badaa7332fc7e/${MY_P}.tar.gz
"
S="${WORKDIR}/${MY_P}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="-test -docs"

RESTRICT="mirror"

BDEPEND="
	dev-python/setuptools
	dev-python/setuptools-scm
"

distutils_enable_tests pytest

python_test() {
	epytest testing
}
