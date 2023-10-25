# Copyright 2023 Kirixetamine <revelation@krxt.dev>
# Distributed under the terms of the ISC License

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( pypy3 python3_{7..12} )

inherit distutils-r1 pypi

DESCRIPTION="Open, Search, Extract and Create VPKs in python"
HOMEPAGE="
	https://github.com/ValvePython/vpk
	https://pypi.org/project/vpk
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="-test"

RDEPEND="
	test? (
		dev-python/coverage
		dev-python/pytest-cov
	)
"

distutils_enable_tests pytest

python_test() {
	epytest tests
}
