# Copyright 2023 Kirixetamine <revelation@krxt.dev>
# Distributed under the terms of the ISC License

EAPI=8

inherit font

DESCRIPTION="The Inter font family"
HOMEPAGE="https://rsms.me/inter/"

# Replace underscore with hyphen
# Then replace beta20230713 to beta9h
#PV="${PV/\_/\-}"
#MY_PV="${PV/20230713/9h}"

SRC_URI="https://github.com/rsms/inter/releases/download/v${PV}/Inter-${PV}.zip -> ${P}.zip"
KEYWORDS="~amd64"
S="${WORKDIR}"

LICENSE="OFL-1.1"
SLOT="0"

BDEPEND="
	app-arch/unzip
"

src_install() {
	insinto /usr/share/fonts/Inter
	local font="InterVariable"
	doins ${font}.ttf
	doins ${font}-Italic.ttf
	einstalldocs
}
