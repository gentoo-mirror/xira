# Copyright 2023 Kirixetamine <revelation@krxt.dev>
# Distributed under the terms of the ISC License

EAPI=8

DISTUTILS_USE_PEP517="setuptools"
PYTHON_COMPAT=( pypy3 python3_{5..11} )

inherit distutils-r1 pypi

DESCRIPTION="The official Python library for the OpenAI API"
HOMEPAGE="
	https://github.com/ilevkivskyi/typing_inspect
	https://pypi.org/project/typing-inspect
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="-test -docs"

RESTRICT="mirror"

RDEPEND="
	dev-python/mypy_extensions
	dev-python/typing-extensions
"

BDEPEND="
	dev-python/hatchling
"
