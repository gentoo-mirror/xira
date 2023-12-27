# Copyright 2023 Kirixetamine <revelation@krxt.dev>
# Distributed under the terms of the ISC License

EAPI=8

DISTUTILS_USE_PEP517="poetry"
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1 pypi python-r1

DESCRIPTION="Python module created for code generation using machine learning"
HOMEPAGE="
	https://github.com/gpt-engineer-org/gpt-engineer
	https://pypi.org/project/gpt-engineer
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="-test -docs"

RESTRICT="mirror"

RDEPEND="
	$(python_gen_impl_dep 'tk(+)')

	test? (
		dev-python/pytest
		dev-python/pytest-cov
	)
	=dev-python/openai-0.28.0
	dev-python/typer
	dev-python/rudder-sdk-python
	dev-python/dataclasses-json
	dev-python/tiktoken
	dev-python/langchain[core,community]
	dev-python/python-dotenv
	dev-python/termcolor
"

BDEPEND="
	dev-python/poetry
"

distutils_enable_tests pytest

python_test() {
	epytest tests
}
