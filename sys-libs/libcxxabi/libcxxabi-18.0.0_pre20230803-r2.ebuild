# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )
inherit cmake-multilib flag-o-matic llvm llvm.org python-any-r1 \
	toolchain-funcs

DESCRIPTION="Low level support for a standard C++ library"
HOMEPAGE="https://libcxxabi.llvm.org/"

LICENSE="Apache-2.0-with-LLVM-exceptions || ( UoI-NCSA MIT )"
SLOT="0"
KEYWORDS=""
IUSE="+clang +static-libs +experimental custom-cflags test"
REQUIRED_USE="test? ( clang )"
RESTRICT="!test? ( test )"

# in 15.x, cxxabi.h is moving from libcxx to libcxxabi
# Using -r2 should force usage of libcxx from KRXT_portlay
RDEPEND+="
	!<sys-libs/libcxx-15
	=sys-libs/libcxx-${PV}-r2
"
DEPEND="
	${RDEPEND}
	sys-devel/llvm:${LLVM_MAJOR}
"
BDEPEND="
	clang? (
		sys-devel/clang:${LLVM_MAJOR}
	)
	!test? (
		${PYTHON_DEPS}
	)
	test? (
		$(python_gen_any_dep 'dev-python/lit[${PYTHON_USEDEP}]')
	)
"

LLVM_COMPONENTS=( runtimes libcxx{abi,} llvm/cmake cmake )
LLVM_TEST_COMPONENTS=( llvm/utils/llvm-lit )
llvm.org_set_globals

python_check_deps() {
	use test || return 0
	python_has_version "dev-python/lit[${PYTHON_USEDEP}]"
}

pkg_setup() {
	# darwin prefix builds do not have llvm installed yet, so rely on bootstrap-prefix
	# to set the appropriate path vars to LLVM instead of using llvm_pkg_setup.
	if [[ ${CHOST} != *-darwin* ]] || has_version sys-devel/llvm; then
		LLVM_MAX_SLOT=${LLVM_MAJOR} llvm_pkg_setup
	fi
	python-any-r1_pkg_setup
}

multilib_src_configure() {
	if use clang; then
		local -x CC=${CHOST}-clang
		local -x CXX=${CHOST}-clang++
		if use experimental; then
			ewarn
			ewarn "\"experimental\" USE flag is currently enabled."
			ewarn "This flag is enabled by default, due to the overlay it resides in."
			ewarn
			local -x CFLAGS="-O3 -maes -flto=thin -pipe -march=x86-64-v3"
			local -x CXXFLAGS="${CFLAGS}" # -stdlib is not needed here
			local -x LDFLAGS="-Wl,-O2 -Wl,--as-needed -Wl,-z,pack-relative-relocs -fuse-ld=lld -rtlib=compiler-rt --unwindlib=libunwind"
		elif use custom-cflags; then
			local -x CFLAGS="${CFLAGS}"
			local -x CXXFLAGS="${CXXFLAGS}"
			local -x LDFLAGS="${LDFLAGS}"
		else
			# Use default flags of the LLVM profile
			# DO NOT strip unsupported flags
			local -x CFLAGS="-O2 -pipe"
			local -x CXXFLAGS="${CFLAGS}"
			local -x LDFLAGS="-fuse-ld=lld -rtlib=compiler-rt --unwindlib=libunwind -Wl,--as-needed"
		fi
	fi

	local libdir=$(get_libdir)
	local mycmakeargs=(
		-DCMAKE_CXX_COMPILER_TARGET="${CHOST}"
		-DPython3_EXECUTABLE="${PYTHON}"
		-DLLVM_ENABLE_RUNTIMES="libcxxabi;libcxx"
		-DLLVM_INCLUDE_TESTS=OFF
		-DLLVM_LIBDIR_SUFFIX=${libdir#lib}
		-DLIBCXXABI_ENABLE_SHARED=ON
		-DLIBCXXABI_ENABLE_STATIC=$(usex static-libs)
		-DLIBCXXABI_INCLUDE_TESTS=$(usex test)

		# upstream is omitting standard search path for this
		# probably because gcc & clang are bundling their own unwind.h
		-DLIBCXXABI_LIBUNWIND_INCLUDES="${EPREFIX}"/usr/include

		-DLIBCXX_LIBDIR_SUFFIX=
		-DLIBCXX_ENABLE_SHARED=ON
		-DLIBCXX_ENABLE_STATIC=OFF
		-DLIBCXX_CXX_ABI=libcxxabi
		-DLIBCXX_ENABLE_ABI_LINKER_SCRIPT=OFF
		-DLIBCXX_HAS_MUSL_LIBC=$(usex elibc_musl)
		-DLIBCXX_HAS_GCC_S_LIB=OFF
		-DLIBCXX_INCLUDE_BENCHMARKS=OFF
		-DLIBCXX_INCLUDE_TESTS=OFF
	)
	if use test; then
		mycmakeargs+=(
			-DLLVM_EXTERNAL_LIT="${EPREFIX}/usr/bin/lit"
			-DLLVM_LIT_ARGS="$(get_lit_flags)"
			-DPython3_EXECUTABLE="${PYTHON}"
		)
	fi
	if use experimental; then
		mycmakeargs+=(
			-DLIBCXXABI_USE_COMPILER_RT=ON
		)
	else
		# UNTESTED.
		mycmakeargs+=(
			-DLIBCXXABI_USE_COMPILER_RT=OFF
		)
	fi
	cmake_src_configure
}

multilib_src_compile() {
	cmake_build cxxabi
}

multilib_src_test() {
	local -x LIT_PRESERVES_TMP=1
	cmake_build check-cxxabi
}

multilib_src_install() {
	DESTDIR="${D}" cmake_build install-cxxabi
}
