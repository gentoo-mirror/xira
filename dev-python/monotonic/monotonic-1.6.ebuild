# Copyright 2023 Kirixetamine <revelation@krxt.dev>
# Distributed under the terms of the ISC License

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( pypy3 python3_{3..12} )

inherit distutils-r1 pypi

DESCRIPTION="An implementation of time.monotonic() for Python 2 & < 3.3"
HOMEPAGE="
	https://github.com/atdt/monotonic
	https://pypi.org/project/monotonic
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="-test"
RESTRICT="mirror"
