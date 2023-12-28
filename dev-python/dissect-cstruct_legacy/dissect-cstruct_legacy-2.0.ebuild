# Copyright 2023 Kirixetamine <revelation@krxt.dev>
# Distributed under the terms of the ISC License

EAPI=8

DISTUTILS_USE_PEP517="setuptools"
PYTHON_COMPAT=( pypy3 python3_{8..11} )

inherit distutils-r1 pypi

DESCRIPTION="A no-nonsense c-like structure parsing library for Python"
HOMEPAGE="
	https://github.com/fox-it/dissect.cstruct_legacy
"

SRC_URI="
	https://github.com/fox-it/dissect.cstruct_legacy/releases/download/${PV}/dissect.cstruct-${PV}.tar.gz -> ${P}.tar.gz
"
S="${WORKDIR}/dissect.cstruct-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="-test -docs"

RESTRICT="mirror"

BDEPEND="
	dev-python/setuptools
	dev-python/wheel
	dev-python/setuptools-scm
"

distutils_enable_tests pytest

python_test() {
	epytest testing
}
