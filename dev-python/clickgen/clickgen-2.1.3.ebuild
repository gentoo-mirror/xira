# Copyright 2023 Kirixetamine <revelation@krxt.dev>
# Distributed under the terms of the ISC License

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( pypy3 python3_{7..12} )

inherit distutils-r1 pypi

DESCRIPTION="The hassle-free cursor building toolbox"
HOMEPAGE="
	https://github.com/ful1e5/clickgen/
	https://pypi.org/project/clickgen/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

RDEPEND="
	>=dev-python/pillow-8.1.1
	dev-python/tomli
	>=dev-python/numpy-1.21.6
"

distutils_enable_tests pytest

python_test() {
	epytest tests
}
