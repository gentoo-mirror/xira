# Copyright 2023 Kirixetamine <revelation@krxt.dev>
# Distributed under the terms of the ISC License

EAPI=8

DISTUTILS_USE_PEP517="setuptools"
PYTHON_COMPAT=( pypy3 python3_{6..11} )

inherit distutils-r1 pypi

DESCRIPTION="Python SDK for event streaming in RudderStack"
HOMEPAGE="
	https://github.com/rudderlabs/rudder-sdk-python
	https://pypi.org/project/rudder-sdk-python
"

SRC_URI="
	https://files.pythonhosted.org/packages/source/r/${PN}/${P}.tar.gz
"
S="${WORKDIR}/${P}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="-test -docs"

RESTRICT="mirror"

RDEPEND="
	test? (
		dev-python/mock
		dev-python/pylint
		dev-python/flake8
	)

	dev-python/requests
	dev-python/monotonic
	dev-python/backoff
	dev-python/python-dateutil
	dev-python/python-dotenv
	dev-python/deprecation
"

distutils_enable_tests pytest

python_test() {
	epytest test.py
}
