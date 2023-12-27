# Copyright 2023 Kirixetamine <revelation@krxt.dev>
# Distributed under the terms of the ISC License

EAPI=8

DISTUTILS_USE_PEP517="standalone"
PYTHON_COMPAT=( pypy3 python3_{7..11} )

inherit distutils-r1 pypi

DESCRIPTION="Easily serialize dataclasses to and from JSON"
HOMEPAGE="
	https://github.com/lidatong/dataclasses-json
	https://pypi.org/project/dataclasses-json
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="-test -docs"

RESTRICT="mirror"

RDEPEND="
	dev-python/typing-inspect
	dev-python/marshmallow
"

BDEPEND="
	dev-python/poetry
	dev-python/poetry-dynamic-versioning
"

distutils_enable_tests pytest

python_test() {
	epytest tests
}
