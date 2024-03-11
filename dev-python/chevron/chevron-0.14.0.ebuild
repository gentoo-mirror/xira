# Copyright 2023 Kirixetamine <revelation@krxt.dev>
# Distributed under the terms of the ISC License

EAPI=8

DISTUTILS_USE_PEP517="setuptools"
PYTHON_COMPAT=( pypy3 python3_{8..11} )

inherit distutils-r1 pypi

MY_PN="dissect.cstruct"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Mustache templating language renderer"
HOMEPAGE="
	https://github.com/noahmorrison/chevron
	https://pypi.org/project/chevron
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="-test -docs"

RESTRICT="mirror"

BDEPEND="
	dev-python/setuptools
"

distutils_enable_tests pytest

python_test() {
	epytest testing
}
