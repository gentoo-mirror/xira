# Copyright 2023 Kirixetamine <revelation@krxt.dev>
# Distributed under the terms of the ISC License

EAPI=8

DISTUTILS_USE_PEP517="poetry"
PYTHON_COMPAT=( pypy3 python3_{8..11} )

inherit distutils-r1 pypi

DESCRIPTION="Client library to connect to the LangSmith LLM Tracing and Evaluation Platform"
HOMEPAGE="
	https://github.com/langchain-ai/langsmith
	https://smith.langchain.com/
	https://pypi.org/project/langsmith
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="-test -docs"

RESTRICT="mirror"

RDEPEND="
	dev-python/pydantic
	dev-python/requests
"

BDEPEND="
	dev-python/poetry
"
