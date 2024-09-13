# Copyright 2024 Kirixetamine <revelation@krxt.dev>
# Distributed under the terms of the ISC License

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( pypy python3_{3..13} )

inherit distutils-r1 pypi

DESCRIPTION="Python Library for Tom's Obvious, Minimal Language"
HOMEPAGE="
	https://github.com/uiri/toml
	https://pypi.org/project/toml/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="mirror"

distutils_enable_tests pytest

python_test() {
	epytest tests
}
