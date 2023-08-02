# >> KRXT :: portlay
~ An LLVM-centric Portage overlay, with focus on live ebuilds ~

## Why?
Mostly to learn, and because I like using bleeding-edge software :3 ~~then crying when it doesn't work~~

### Binary cache/host
If you for whatever reason desire to, you can use my [binpkg host](https://gencache.krxt.dev/). Information about system information below:

- Compilers
    - CC: `clang`
    - CXX: `clang++`

- Compiler options
    - CFLAGS: `-O3 -march=x86-64-v3 -flto=thin -maes -pipe`
    - CXXFLAGS: `-${CFLAGS} -stdlib=libc++`
    - RUSTFLAGS: `-Ctarget-cpu=x86-64-v3 -Copt-level=3 -Cembed-bitcode=yes -Clto=thin -Clinker-plugin-lto=true -Cstrip=symbols -Clink-arg=-Wl,-z,pack-relative-relocs`
    - LDFLAGS: `-Wl,-O1 -Wl,--as-needed -Wl,-z,pack-relative-relocs -fuse-ld=lld -rtlib=compiler-rt -unwindlib=libunwind`

- Portage variables
    - VIDEO_CARDS: `amdgpu radeonsi intel radeon`
    - LLVM_TARGETS: `"${LLVM_TARGETS} AMDGPU`
    - INPUT_DEVICES: `libinput`
    - L10N: `en pl da el`
    - BINPKG_FORMAT: `gpkg`
    - BINPKG_COMPRESS: `zstd`
        - A working `app-arch/zstd` installation is required

This is used by me to not compile packages such as Librewolf or LLVM on a `x86-64-v3` compatible laptop.
Note that packages are not GPG signed despite using `gpkg`, due to a bug in either GPG or Portage about file access to the key file, that I could not solve.
