# Copyright 2024 Kirixetamine <revelation@krxt.dev>
# Distributed under the terms of the GNU General Public License v2

# Auto-Generated by cargo-ebuild 0.5.4

EAPI=8

RESTRICT="mirror"

CRATES="
	cfg-if-1.0.0
	getrandom-0.2.7
	libc-0.2.126
	ppv-lite86-0.2.16
	rand-0.8.5
	rand_chacha-0.3.1
	rand_core-0.6.3
	size-0.4.0
	wasi-0.11.0+wasi-snapshot-preview1
	windows-sys-0.42.0
	windows_aarch64_gnullvm-0.42.1
	windows_aarch64_msvc-0.42.1
	windows_i686_gnu-0.42.1
	windows_i686_msvc-0.42.1
	windows_x86_64_gnu-0.42.1
	windows_x86_64_gnullvm-0.42.1
	windows_x86_64_msvc-0.42.1
"

GIT_COMMIT="89e6e08f442eadb7c2655d5390e008a861bae8f1"

inherit cargo

DESCRIPTION="Benchmark drive writes with non-compressible data or wipe disks with random content"
# Double check the homepage as the cargo_metadata crate
# does not provide this value so instead repository is used
HOMEPAGE="https://github.com/mqudsi/hddrand/"
SRC_URI="
	$(cargo_crate_uris)
	https://github.com/mqudsi/hddrand/archive/${GIT_COMMIT}.tar.gz
"
S="${WORKDIR}/${PN}-${GIT_COMMIT}"

# License set may be more restrictive as OR is not respected
# use cargo-license for a more accurate license picture
LICENSE="Apache-2.0 Apache-2.0-with-LLVM-exceptions MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

# rust does not use *FLAGS from make.conf, silence portage warning
# update with proper path to binaries this crate installs, omit leading /
QA_FLAGS_IGNORED="usr/bin/${PN}"