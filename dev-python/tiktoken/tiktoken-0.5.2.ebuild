# Copyright 2023 Kirixetamine <revelation@krxt.dev>
# Distributed under the terms of the ISC License

EAPI=8

CRATES="
	aho-corasick@1.1.2
	autocfg@1.1.0
	bit-set@0.5.3
	bit-vec@0.6.3
	bitflags@1.3.2
	bstr@1.8.0
	cfg-if@1.0.0
	fancy-regex@0.11.0
	heck@0.4.1
	indoc@2.0.4
	libc@0.2.151
	lock_api@0.4.11
	memchr@2.6.4
	memoffset@0.9.0
	once_cell@1.19.0
	parking_lot@0.12.1
	parking_lot_core@0.9.9
	proc-macro2@1.0.71
	pyo3-build-config@0.20.0
	pyo3-ffi@0.20.0
	pyo3-macros-backend@0.20.0
	pyo3-macros@0.20.0
	pyo3@0.20.0
	quote@1.0.33
	redox_syscall@0.4.1
	regex-automata@0.4.3
	regex-syntax@0.8.2
	regex@1.10.2
	rustc-hash@1.1.0
	scopeguard@1.2.0
	serde@1.0.193
	serde_derive@1.0.193
	smallvec@1.11.2
	syn@2.0.43
	target-lexicon@0.12.12
	unicode-ident@1.0.12
	unindent@0.2.3
	windows-targets@0.48.5
	windows_aarch64_gnullvm@0.48.5
	windows_aarch64_msvc@0.48.5
	windows_i686_gnu@0.48.5
	windows_i686_msvc@0.48.5
	windows_x86_64_gnu@0.48.5
	windows_x86_64_gnullvm@0.48.5
	windows_x86_64_msvc@0.48.5
"

DISTUTILS_USE_PEP517="setuptools"
DISTUTILS_EXT=1
PYTHON_COMPAT=( pypy3 python3_{8..11} )

inherit cargo distutils-r1 pypi

DESCRIPTION="Tiktoken is a fast BPE tokeniser for use with OpenAI's models."
HOMEPAGE="
	https://github.com/openai/tiktoken
	https://pypi.org/project/tiktoken
"
SRC_URI="
	https://github.com/openai/tiktoken/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
	${CARGO_CRATE_URIS}
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="-test -docs"
IUSE="blobfile"

RESTRICT="mirror"

RDEPEND="
	dev-python/regex
	dev-python/requests
	blobfile? (
		dev-python/blobfile
	)
"

BDEPEND="
	dev-python/setuptools
	dev-python/wheel
	dev-python/setuptools-rust[${PYTHON_USEDEP}]
"

src_unpack() {
	#default
	cargo_src_unpack
}

src_prepare() {
	default
	distutils-r1_src_prepare
}

src_configure() {
	cargo_src_configure
	distutils-r1_src_configure
}

src_compile() {
	default
	cargo_src_compile --offline --all-features
	distutils-r1_src_compile
}

distutils_enable_tests pytest

src_install() {
	distutils-r1_src_install
}
