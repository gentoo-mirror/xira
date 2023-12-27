# Copyright 2023 Kirixetamine <revelation@krxt.dev>
# Distributed under the terms of the ISC License

EAPI=8

DISTUTILS_USE_PEP517="setuptools"
PYTHON_COMPAT=( pypy3 python3_{10..11} )

inherit distutils-r1 pypi

DESCRIPTION="The official Python library for the OpenAI API"
HOMEPAGE="
	https://github.com/openai/openai-python
	https://pypi.org/project/openai
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="-test -docs"

RESTRICT="mirror"

RDEPEND="
	test? (
		dev-python/pytest
		dev-python/pytest-cov
	)
	dev-python/httpx
	dev-python/pydantic
	dev-python/typing-extensions
	dev-python/anyio
	dev-python/distro
	dev-python/sniffio
	dev-python/tqdm
"

BDEPEND="
	dev-python/setuptools
"

distutils_enable_tests pytest

python_test() {
	epytest tests
}
