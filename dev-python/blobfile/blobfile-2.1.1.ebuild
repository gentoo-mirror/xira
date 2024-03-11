# Copyright 2023 Kirixetamine <revelation@krxt.dev>
# Distributed under the terms of the ISC License

EAPI=8

DISTUTILS_USE_PEP517="setuptools"
PYTHON_COMPAT=( pypy3 python3_{8..11} )

inherit distutils-r1 pypi

DESCRIPTION="Read Google Cloud Storage, Azure Blobs, and local paths with the same interface"
HOMEPAGE="
	https://github.com/blobfile/blobfile
	https://pypi.org/project/blobfile
"

LICENSE="Unlicense"
SLOT="0"
KEYWORDS="-test -docs"

RESTRICT="mirror"

RDEPEND="
	dev-python/pycryptodomex
	dev-python/urllib3
	dev-python/lxml
	dev-python/filelock
"

BDEPEND="
	dev-python/setuptools
"

distutils_enable_tests pytest

python_test() {
	epytest testing
}
