# Copyright 2023 Kirixetamine <revelation@krxt.dev>
# Distributed under the terms of the ISC License

EAPI=8

DISTUTILS_USE_PEP517="poetry"
PYTHON_COMPAT=( pypy3 python3_{8..11} )

inherit distutils-r1 pypi optfeature

DESCRIPTION="⚡ Building applications with LLMs through composability ⚡"
HOMEPAGE="
	https://github.com/langchain-ai/langchain
	https://python.langchain.com/
	https://pypi.org/project/langchain
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="-test -docs"
IUSE="cli +core community"

RESTRICT="mirror"

RDEPEND="
	dev-util/ruff
	dev-util/codespell
	cli? (
		dev-python/langchain-cli
	)
	core? (
		dev-python/langchain-core
	)
	community? (
		dev-python/langchain-community
	)
"

BDEPEND="
	dev-python/poetry
"
