# Copyright 2023 Kirixetamine <revelation@krxt.dev>
# Distributed under the terms of the ISC License

EAPI=8

inherit go-module bash-completion-r1

DESCRIPTION="A Go based command line tool for exercism.org"
HOMEPAGE="
	https://exercism.org
	https://github.com/exercism/cli
"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/exercism/cli/"
else
	SRC_URI="
		https://github.com/${PN}/cli/archive/v${PV}.tar.gz -> ${P}.tar.gz
		https://dist.krxt.dev/dev-util/${PN}/${P}-vendor.tar.xz"
	S="${WORKDIR}/cli-${PV}"
	KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0"

RDEPEND="
	sys-libs/glibc
"

BDEPEND="
	dev-lang/go
"

src_unpack() {
	if [[ ${PV} == 9999 ]]; then
		git-r3_src_unpack		|| die
		go-module_live_vendor	|| die
		go-module_src_unpack	|| die
	else
		go-module_src_unpack	|| die
	fi
}

src_compile() {
	ego build -o out/exercism exercism/main.go
}

src_install() {
	default
	dobin out/exercism

	newbashcomp "shell/${PN}_completion.bash" "${PN}"

	insinto /usr/share/zsh/site-functions
	newins "shell/${PN}_completion.zsh" "_${PN}"
}
