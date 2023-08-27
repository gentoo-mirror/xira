# Copyright 2023 Kirixetamine <revelation@krxt.dev
# Distributed under the terms of the ISC License

EAPI=8

inherit qmake-utils

DESCRIPTION="Sioyek is a PDF viewer with a focus on textbooks and research papers"
HOMEPAGE="https://sioyek.info/"

REPO_URI="https://github.com/ahrm/sioyek"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="${REPO_URI}"
else
	SRC_URI="${REPO_URI}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${P}"
fi

LICENSE="GPL-3"
SLOT="0"

BDEPEND="
	dev-qt/qtbase
	dev-qt/qt3d
	media-libs/harfbuzz
"

src_compile() {
	eqmake5 "CONFIG+=linux_app_image" pdf_viewer_build_config.pro
	emake
}
