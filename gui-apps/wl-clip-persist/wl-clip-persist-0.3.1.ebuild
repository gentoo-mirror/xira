# Copyright 2023 Kirixetamine <revelation@krxt.dev>
# Distributed under the terms of the ISC License

# Crates autogenerated by pycargoebuild 0.13.2

EAPI=8

CRATES="
	aho-corasick@0.7.18
	atty@0.2.14
	autocfg@1.1.0
	bit-set@0.5.3
	bit-vec@0.6.3
	bitflags@1.3.2
	cfg-if@1.0.0
	clap@3.2.19
	clap_derive@3.2.18
	clap_lex@0.2.4
	dlib@0.5.0
	downcast-rs@1.2.0
	env_logger@0.9.0
	fancy-regex@0.10.0
	filedescriptor@0.8.2
	hashbrown@0.12.3
	heck@0.4.0
	hermit-abi@0.1.19
	humantime@2.1.0
	indexmap@1.9.1
	libc@0.2.132
	libloading@0.7.3
	log@0.4.17
	memchr@2.5.0
	memoffset@0.6.5
	nix@0.24.2
	once_cell@1.13.1
	os_str_bytes@6.3.0
	pkg-config@0.3.25
	proc-macro-error-attr@1.0.4
	proc-macro-error@1.0.4
	proc-macro2@1.0.43
	quote@1.0.21
	regex-syntax@0.6.27
	regex@1.6.0
	scoped-tls@1.0.0
	smallvec@1.9.0
	strsim@0.10.0
	syn@1.0.99
	termcolor@1.1.3
	textwrap@0.15.0
	thiserror-impl@1.0.33
	thiserror@1.0.33
	unicode-ident@1.0.3
	version_check@0.9.4
	wayland-client@0.29.5
	wayland-commons@0.29.5
	wayland-protocols@0.29.5
	wayland-scanner@0.29.5
	wayland-sys@0.29.5
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.5
	winapi-x86_64-pc-windows-gnu@0.4.0
	winapi@0.3.9
	xml-rs@0.8.4
"

inherit cargo

DESCRIPTION="Keep Wayland clipboard after programs close"
HOMEPAGE="https://github.com/Linus789/wl-clip-persist"

COMMIT="6ba11a2aa295d780f0b2e8f005cf176601d153b0"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Linus789/wl-clip-persist"
else
	SRC_URI="
		https://github.com/Linus789/wl-clip-persist/archive/${COMMIT}.tar.gz -> ${PN}-${COMMIT}.tar.gz
		${CARGO_CRATE_URIS}"
	S="${WORKDIR}/${PN}-${COMMIT}"
	KEYWORDS="~amd64"
fi

LICENSE="MIT"
# Dependent crate licenses
LICENSE+=" ISC MIT Unicode-DFS-2016"
SLOT="0"
RESTRICT="mirror"

src_unpack() {
	if [[ ${PV} == 9999 ]]; then
		git-r3_src_unpack
		cargo_live_src_unpack
	else
		cargo_src_unpack
	fi
}

QA_PRESTRIPPED="/usr/bin/${PN}"
