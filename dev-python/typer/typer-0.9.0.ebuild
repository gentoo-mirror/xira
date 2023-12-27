# Copyright 2023 Kirixetamine <revelation@krxt.dev>
# Distributed under the terms of the ISC License

EAPI=8

DISTUTILS_USE_PEP517="flit"
PYTHON_COMPAT=( pypy3 python3_{6..11} )

inherit distutils-r1 pypi

DESCRIPTION="Typer, build great CLIs. Easy to code. Based on Python type hints"
HOMEPAGE="
	https://github.com/tiangolo/typer
	https://pypi.org/project/typer
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="-test -docs"

RESTRICT="mirror"

RDEPEND="
	dev-python/click
	dev-python/colorama
	dev-python/rich
	dev-python/shellingham
	dev-python/typing-extensions
"

BDEPEND="
	dev-python/flit-core
"
