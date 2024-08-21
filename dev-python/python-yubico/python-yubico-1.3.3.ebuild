# Copyright 2024 Kirixetamine <revelation@krxt.dev>
# Distributed under the terms of the ISC License

EAPI=8

DISTUTILS_USE_PEP517=setuptools
# It's ""compatible""... potentially fragile.
PYTHON_COMPAT=( python3_{7..12} )

inherit distutils-r1 pypi

DESCRIPTION="Python code for talking to Yubico's YubiKeys"
HOMEPAGE="
	https://github.com/Yubico/python-yubico
	https://pypi.org/project/python-yubico
"

SRC_URI="https://files.pythonhosted.org/packages/source/p/${PN}/${P}.tar.gz"
S="${WORKDIR}/${P}"
LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/pyusb[${PYTHON_USEDEP}]
"
## Disabling tests due to portage output below (this library is old, and I hope I can remove it someday)
# * QA Notice: setuptools warnings detected:
# *
# * Unknown distribution option: 'test_suite'
RESTRICT="test mirror"
PATCHES=(
	"${FILESDIR}"/suppress-qa-notice.patch
)
