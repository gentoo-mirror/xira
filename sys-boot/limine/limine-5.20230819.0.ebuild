# Copyright 2023 Kirixetamine <revelation@krxt.dev>
# Distributed under the terms of the ISC License

EAPI=8

inherit toolchain-funcs

DESCRIPTION="A modern, advanced, portable, multiprotocol bootloader"
HOMEPAGE="https://limine-bootloader.org"
SRC_URI="https://github.com/limine-bootloader/limine/releases/download/v${PV}/limine-${PV}.tar.xz"

KEYWORDS="~amd64"
LICENSE="BSD-2"
SLOT="0"
IUSE="-gnu +bios +bios-pxe +bios-cd +cd-efi +uefi32 +uefi64 -uefiaa64 custom-cflags clang"

MY_LLVM_TARGETS="AArch64 ARM X86"
MY_LLVM_FLAGS="llvm_targets_${MY_LLVM_TARGETS// /(-),llvm_targets_}(-)"

BDEPEND="
	app-alternatives/awk
	app-alternatives/gzip
	dev-lang/nasm
	sys-apps/coreutils
	sys-apps/findutils
	sys-apps/sed
	sys-devel/autoconf
	sys-devel/automake
	clang? (
		sys-devel/clang[${MY_LLVM_FLAGS}]
		sys-devel/lld
		sys-devel/llvm[${MY_LLVM_FLAGS}]
	)
	gnu? (
		sys-devel/binutils
		sys-devel/gcc
	)
	cd-efi? ( sys-fs/mtools )
"

pkg_setup() {
	if use clang && use gnu; then
		eerror
		eerror "Do not enable both \"clang\" and \"gnu\" USE flags."
		eerror "Instead, use either \"clang\" OR \"gnu\", to use"
		eerror "their respective toolchains."
		eerror
		die "both toolchains enabled"
	fi
}

src_configure() {
	if use clang; then
		TOOLCHAIN_FOR_TARGET=llvm
	elif use gnu; then
		TOOLCHAIN_FOR_TARGET=gnu
	fi

	# Flags passed to configure script
	local make_flags=(
		CC="$(tc-getCC)"
		LD="$(tc-getLD)"
		OBJCOPY="$(tc-getOBJCOPY)"
		READELF="$(tc-getREADELF)"
		CC_FOR_TARGET="${CC}"
		LD_FOR_TARGET="${LD}"
		OBJCOPY_FOR_TARGET="${OBJCOPY}"
		OBJDUMP_FOR_TARGET="${OBJDUMP}"
		READELF_FOR_TARGET="${READELF}"
	)
	if use custom-cflags; then
		make_flags=(
			CFLAGS="${CFLAGS}"
			CPPFLAGS="${CXXFLAGS}"
			LDFLAGS="${LDFLAGS}"
			CFLAGS_FOR_TARGET="${CFLAGS}"
			CPPFLAGS_FOR_TARGET="${CPPFLAGS}"
			#LDFLAGS_FOR_TARGET="${LDFLAGS}" #TODO: make this work?
			"${make_flags[@]}"
		)
	fi

	local targets=(
		"$(use_enable bios)"
		"$(use_enable bios-cd)"
		"$(use_enable bios-pxe)"

		"$(use_enable uefi32 uefi-ia32)"
		"$(use_enable uefi64 uefi-x86-64)"
		"$(use_enable uefiaa64 uefi-aarch64)"
		"$(use_enable cd-efi uefi-cd)"
	)

	econf "${make_flags[@]}" "${targets[@]}"
}
