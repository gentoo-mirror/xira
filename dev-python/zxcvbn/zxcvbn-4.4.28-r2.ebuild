# Copyright 2024 Kirixetamine <revelation@krxt.dev>
# Distributed under the terms of the ISC License

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{6..13} )

inherit distutils-r1 pypi

DESCRIPTION="A realistic password strength estimator"
HOMEPAGE="
	https://github.com/dwolfhub/zxcvbn-python/
	https://pypi.org/project/zxcvbn/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="mirror"
