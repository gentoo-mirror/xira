# Copyright 2023 Kirixetamine <revelation@krxt.dev>
# Distributed under the terms of the ISC License

EAPI=8

DISTUTILS_USE_PEP517="poetry"
PYTHON_COMPAT=( pypy3 python3_{8..11} )

inherit distutils-r1 pypi

DESCRIPTION="The official CLI for LangChain"
HOMEPAGE="
	https://github.com/langchain-ai/langchain
	https://python.langchain.com/
	https://pypi.org/project/langchain-cli
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="-test -docs"

RESTRICT="mirror test"

RDEPEND="
	dev-python/langserve
	dev-util/ruff
	dev-python/GitPython
	dev-python/tomlkit
	dev-python/typer
	dev-python/uvicorn
"

BDEPEND="
	dev-python/poetry
"
