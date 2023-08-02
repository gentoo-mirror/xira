# >> KRXT :: portlay
~ An LLVM-centric Portage overlay, with focus on live ebuilds ~

## ⚠️ Experimentalism ahead ⚠️
I don't advise you using this overlay, unless you want to or are using one of the LLVM profiles provided by the Gentoo repository or my modified ones.

This project is also in a very early stage, I will probably change things in here a lot over time, most notably I'd like to implement something like `make.conf.lto` and related concepts from [Gentoo-LTO](https://github.com/InBetweenNames/gentooLTO), which hasn't been updated since Dec. 2022, at time of writing this. (2023-08-02)

## Why?
Mostly to learn, and because I like using bleeding-edge software :3 ~~then crying when it doesn't work~~

## What's in here?
A directory structure and explanations are listed below.
```sh
KRXT_portlay
├── [ebuild categories]
├── metadata
├── profiles
│   ├── features
│   │   └── llvm-live
│   ├── llvm-desktop
│   └── llvm-systemd-desktop
└── sets
    ├── llvm-complete
    ├── mail-prequisites
    └── openwrt-prequisites
```
I will omit ebuild categories and metadata, as those are self-explanatory.
- profiles
    - This is a list of profiles in the overlay you can use, all of them are marked as experimental, so you need to pass `--force` to eselect.  
    Currently there is an `llvm-desktop` and `llvm-systemd-desktop` profile. These profiles combine the main repository's 23.0 LLVM feature set, this repository's modified version of it (as I don't want to copy anything directly), and the main repository's desktop target.  
    I can confirm that both the normal OpenRC and systemd profiles work, as I tried them both.
    - features/llvm-live
        - This is, for now slightly, a modified version of the Gentoo repository's `features/llvm` profile. Mostly it is used to unmask live versions of anything in `@llvm-complete`. This will be expanded in the future.
- sets
    - This is a list of sets you can pass to `emerge`, to install a group of packages, just like `@world` or `@system`.  
    The `llvm-complete` set has all packages related to LLVM, some of which aren't in the `gentoo:features/llvm` profile's system set. I have mostly made this for ease of updating and compiling for my binpkg host.  
    The `mail-prequisites` and `openwrt-prequisites` sets are to install mailserver related packages (no POP3, it's 202X), and packages required for OpenWrt image compilation, respectively.  
    There might be more sets in the future, if one is suggested or if I can think of one :3

### Binary cache/host
If you for whatever reason desire to, you can use my [binpkg host](https://gencache.krxt.dev/). Information about system information below:

- Compilers
    - CC: `clang`
    - CXX: `clang++`

- Compiler options
    - CFLAGS: `-O3 -march=x86-64-v3 -flto=thin -maes -pipe`
    - CXXFLAGS: `${CFLAGS} -stdlib=libc++`
    - RUSTFLAGS: `-Ctarget-cpu=x86-64-v3 -Copt-level=3 -Cembed-bitcode=yes -Clto=thin -Clinker-plugin-lto=true -Cstrip=symbols -Clink-arg=-Wl,-z,pack-relative-relocs`
    - LDFLAGS: `-Wl,-O1 -Wl,--as-needed -Wl,-z,pack-relative-relocs -fuse-ld=lld -rtlib=compiler-rt -unwindlib=libunwind`

- Portage variables
    - VIDEO_CARDS: `amdgpu radeonsi intel radeon`
    - LLVM_TARGETS: `${LLVM_TARGETS} AMDGPU`
    - INPUT_DEVICES: `libinput`
    - L10N: `en pl da el`
    - BINPKG_FORMAT: `gpkg`
    - BINPKG_COMPRESS: `zstd`
        - A working `app-arch/zstd` installation is required

This is used by me to not compile packages such as LibreWolf or LLVM on a `x86-64-v3` compatible laptop.
Note that packages are not GPG signed despite using `gpkg`, due to a bug in either GPG or Portage about file access to the key file, that I could not solve.
