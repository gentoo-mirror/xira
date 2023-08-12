# Copyright 2023 Kirixetamine <revelation@krxt.dev>
# Distributed under the terms of the ISC License

EAPI=8

inherit go-module systemd

DESCRIPTION="A second-generation Matrix homeserver written in Go"
HOMEPAGE="https://matrix-org.github.io/dendrite/"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/matrix-org/dendrite"
else
	SRC_URI="
		https://github.com/matrix-org/dendrite/archive/v${PV}.tar.gz -> ${P}.tar.gz
		https://dist.krxt.dev/net-matrix/${PN}/${P}-vendor.tar.xz"
	S="${WORKDIR}/${P}"
	KEYWORDS="~amd64"
fi

LICENSE="Apache-2.0"
SLOT="0"
IUSE="postgres systemd"

#RESTRICT="test"

RDEPEND="
	acct-group/dendrite
	acct-user/dendrite
	postgres? (
		dev-db/postgresql
	)
	systemd? (
		sys-apps/systemd:=
	)
"

OUT_GOPATH="${S}/go-path"

pkg_setup() {
	if ! use postgres; then
		ewarn
		ewarn "The \"postgres\" USE flag is currently disabled."
		ewarn "Without it, ${PN} can only use SQLite, which"
		ewarn "is compiled into ${PN}, and is NOT recommended"
		ewarn "by ${PN}'s developers."
		ewarn
		ewarn "Please consider enabling and using PostgreSQL"
		ewarn "together with ${PN}."
		ewarn
	fi
	ewarn
	ewarn "No OpenRC support for now, only"
	ewarn "a systemd unit is provided."
	ewarn "If you require OpenRC scripts,"
	ewarn "please contact the package maintainer."
	ewarn
}

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
	env \
		GOPATH="${OUT_GOPATH}":/usr/lib/go-gentoo \
		GOCACHE="${T}"/go-cache \
		CGO_ENABLED=1 \
		go build -trimpath -v -x -work -o bin/ "${S}"/cmd/... || die
}

src_test() {
	env \
		GOPATH="${OUT_GOPATH}":/usr/lib/go-gentoo \
		GOCACHE="${T}"/go-cache \
		go test -trimpath -v -x -work "${S}"/cmd/... || die
}

src_install() {
	local cmd
	for cmd in $(ls "${S}/bin/"); do
		dobin "${S}/bin/${cmd}"
	done

	dodir "/etc/dendrite"
	insinto /etc/dendrite
	doins "${S}/dendrite-sample.yaml"

	keepdir "/var/log/dendrite"
	fowners dendrite:dendrite "/var/log/dendrite"
	fowners dendrite:root "/etc/dendrite"

	if use postgres; then
		systemd_newunit "${FILESDIR}/${PN}-postgres.service" "${PN}.service"
	else
		systemd_newunit "${FILESDIR}/${PN}-sqlite.service" "${PN}.service"
	fi
}
