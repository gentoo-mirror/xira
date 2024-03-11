# Copyright 2023 Kirixetamine <revelation@krxt.dev>
# Distributed under the terms of the ISC License

EAPI=8

DISTUTILS_USE_PEP517="poetry"
PYTHON_COMPAT=( pypy3 python3_{8..11} )

inherit distutils-r1 pypi

DESCRIPTION="⚡ Building applications with LLMs through composability ⚡"
HOMEPAGE="
	https://github.com/langchain-ai/langchain
	https://python.langchain.com/
	https://pypi.org/project/langchain-core
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="-test -docs"
IUSE="jinja"

RESTRICT="mirror"

RDEPEND="
	dev-python/pydantic
	dev-python/langsmith
	dev-python/tenacity
	dev-python/anyio
	dev-python/pyyaml
	dev-python/packaging
	dev-python/jsonpatch
	jinja? (
		dev-python/jinja
	)
"

BDEPEND="
	dev-python/poetry
"
