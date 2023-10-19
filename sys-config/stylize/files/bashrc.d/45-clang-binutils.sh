CLANG_BINUTILS() {
    if [[ ${CLANG_BINUTILS} -eq 1 ]]; then
        export CC="clang"
        export CXX="clang++"
        export AR="llvm-ar"
        export AS="clang -c"
        export CPP="clang-cpp"
        export NM="llvm-nm"
        export STRIP="llvm-strip"
        export RANLIB="llvm-ranlib"
        export OBJCOPY="llvm-objcopy"
        export STRINGS="llvm-strings"
        export OBJDUMP="llvm-objdump"
        export READELF="llvm-readelf"
        export ADDR2LINE="llvm-addr2line"

        # GHC workaround
        unset CTARGET
        export EXTRA_ECONF="CC=clang"
    fi
}

BashrcdPhase setup CLANG_BINUTILS
BashrcdPhase configure CLANG_BINUTILS
