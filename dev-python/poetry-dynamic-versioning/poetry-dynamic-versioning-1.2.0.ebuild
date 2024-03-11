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
	dev-python/dunamai
	dev-python/tomlkit
	dev-python/jinja
	dev-python/poetry

	test? (
		dev-python/pytest
		dev-vcs/pre-commit
		dev-python/black
		dev-python/mypy
		dev-util/ruff
	)
"

distutils_enable_tests pytest

python_test() {
	epytest tests
}
