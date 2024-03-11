# Copyright 2023 Kirixetamine <revelation@krxt.dev>
# Distributed under the terms of the ISC License

EAPI=8

DISTUTILS_USE_PEP517="poetry"
PYTHON_COMPAT=( pypy3 python3_{8..11} )

inherit distutils-r1 pypi

DESCRIPTION="Community contributed LangChain integrations"
HOMEPAGE="
	https://github.com/langchain-ai/langchain
	https://python.langchain.com/
	https://pypi.org/project/langchain-community
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="-test -docs"

RESTRICT="mirror"

RDEPEND="
	dev-python/langchain-core
	dev-python/sqlalchemy
	dev-python/requests
	dev-python/pyyaml
	dev-python/numpy
	dev-python/aiohttp
	dev-python/dataclasses-json
	dev-python/langsmith
"

BDEPEND="
	dev-python/poetry
"
