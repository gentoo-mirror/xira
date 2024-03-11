# Copyright 2023 Kirixetamine <revelation@krxt.dev>
# Distributed under the terms of the ISC License

EAPI=8

DISTUTILS_USE_PEP517="poetry"
PYTHON_COMPAT=( pypy python3_{7..12} )

inherit distutils-r1 pypi

DESCRIPTION="Plugin for Poetry to enable dynamic versioning based on VCS tags"
HOMEPAGE="
	https://github.com/mtkennerly/poetry-dynamic-versioning
	https://pypi.org/project/poetry-dynamic-versioning
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="-test"

RESTRICT="mirror"

RDEPEND="
	dev-python/packaging
	dev-python/importlib-metadata[${PYTHON_USEDEP}]
	test? (
		dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/pytest-cov[${PYTHON_USEDEP}]
		dev-vcs/pre-commit[${PYTHON_USEDEP}]
		dev-python/black[${PYTHON_USEDEP}]
		dev-python/mypy[${PYTHON_USEDEP}]
		dev-util/ruff[${PYTHON_USEDEP}]
	)
"

BDEPEND="
	dev-python/poetry[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest

python_test() {
	epytest tests
}
