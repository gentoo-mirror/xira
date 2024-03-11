<h1 align="center"><i>Xira</i></h1>
<p align="center"><i>~ An LLVM-centric Portage overlay ~</i></p>

## Package count
2023-12-22 03:50 CEST: 72

Counted by:
```
ls -Fd */* | grep '/$' | grep -Ev '^(profiles|metadata)' | wc -l
```
<i>Taken from [another cool overlay](https://github.com/stefantalpalaru/gentoo-overlay)</i>

## ⚠️ Experimental nature ⚠️
I don't advise you use this overlay without the 17.1 clang/23.0 llvm profile selected, preferably the modified ones here, which use 23.0 llvm\[-systemd\] profiles.  
This project is also in its early stage, which might cause frequent changes, and future plans.  
#### Note
The LLVM profiles from here use the main repo ones as `parent`, but contain extra changes.  
Most notably setting `-fsplit-lto-unit` in C(XX)FLAGS, which requires e.g. LLVM and Qt packages being rebuilt, if they don't use it.

## Enabling
To enable this overlay, use [eselect-repository](https://wiki.gentoo.org/wiki/Eselect/Repository).

This overlay is now in the official list, so you can simply call this command:
```
eselect repository enable xira
```
*You can use `codeberg.org/kir68k/xira`, as well as my gitea instance*  
Afterwards, run `emaint` for synchronizing
```
emaint sync -r xira
```

## Information on stylize
This repository now also includes `sys-config/stylize`, a split off ltoize from the gentooLTO repository. For now it's slightly modified to meet Clang usage, but I plan on expanding it further, eventually replacing copied main repo ebuilds with patches in package.cflags from this package.
To enable, you also need to enable the `mv` overlay:
```
eselect repository enable mv
```
Afterwards, please remove `CFLAGS, CXXFLAGS, RUSTFLAGS, LDFLAGS` from your `make.conf`.
Or, if you want platform-specific CFLAGS, set these to:
```bash
CFLAGS="${CFLAGS} -march=native"
CXXFLAGS="${CFLAGS} [-your_changes]"
RUSTFLAGS="${RUSTFLAGS} [-your_changes]"
```
Currently, these are:
```bash
¥ portageq envvar CFLAGS RUSTFLAGS
-O3 -fno-semantic-interposition -flto=thin -maes -fsplit-lto-unit -DQT_NO_VERSION_TAGGING -fuse-linker-plugin
-Copt-level=3 -Cembed-bitcode=yes -Clto=thin -Clinker-plugin-lto=true -Cstrip=symbols -Clink-arg=-Wl,-z,pack-relative-relocs
```
CXXFLAGS is a superset of CFLAGS, with the addition of `-stdlib=libc++`, to use LLVM's C++ stdlib.

***PLEASE*** keep`LDFLAGS` same as your profile's. Using the LLVM profiles from here is recommended for use with this.
If you want to make changes to `LDFLAGS`, set as follows:
```bash
LDFLAGS="${LDFLAGS} [-your_changes]"
```
`LDFLAGS` Currently:
```bash
¥ portageq envvar LDFLAGS
-Wl,-O2 -Wl,-z,pack-relative-relocs -Wl,--as-needed -fuse-ld=lld -rtlib=compiler-rt --unwindlib=libunwind -Wl,--undefined-version
```

If this does not work, please contact me.

<i>~ All credit goes to the creator of gentooLTO, linked [here](https://github.com/InBetweenNames/gentooLTO) ~</i>

This project is kept as GPLv2, instead of ISC, as I am not sure whether I can change the license.

## Information
### License info
Every ebuild I wrote here is licensed under ISC.
Ebuilds I have copied from e.g. the main repository preserve their original GPLv2 header and authors.
I am not a legal expert. As far as I understand ISC is GPLv2 compatible, but if there are any issues, please message me [here](https://to.stylism.moe/#/@revelation:stylism.moe/), or make an issue on GitHub/Codeberg.

### Packages in here
Mostly packages I haven't seen anywhere else, like other overlays tend to do. As said, this overlay mostly focuses on existing ebuilds that don't build using clang with default or weird compiler options that I use, so:
- Clang build fixes
- Gnome apps I haven't seen anywhere else
- Live versions of existing ebuilds (main or overlays)

### Requirements
- x86-64-v3 compatible machine
    - CFLAGS in profiles and some ebuilds explicitly state `-march=x86-64-v3`, as of now.
- LLVM profile
    - Best is to install using the LLVM stage3.
    - Use either the main repository LLVM profile, or the `llvm-desktop` profiles here (preferred).
- GURU Overlay
    - Some ebuilds might have dependencies that exist only in the GURU overlay.

### Micro-commits
These are very small commits I might create at times, mostly for critical things required to be added or removed, without other additions.

### Why?
Because I can :3  
In all seriousness, this overlay exists because of:
- Me wanting to put my changes to existing ebuilds somewhere
- Wanting to compile as much as possible using `clang`
    - Also with ridiculous compiler flags
- In general, have a place for LLVM related things (profiles, ebuilds, ...)


### What's in here?
A directory structure and explanations are listed below.
```sh
xira
├── [ebuild categories]
├── metadata
├── profiles
│   ├── features
│   │   ├── llvm-live
│   │   └── stylize
│   ├── llvm-desktop
│   ├── llvm-systemd-desktop
│   ├── llvm-live-desktop
│   └── llvm-live-systemd-desktop
└── sets
    ├── llvm-complete
    ├── mail-prequisites
    └── openwrt-prequisites
```
- profiles
    - llvm-live
        - Unmasks Git versions of LLVM and everything in `@llvm-complete`
    - stylize<sup>†</sup>
        - Primary features, currently including: Better \*FLAGS, package masks
- sets
    - Package sets for convenience, e.g. to install all LLVM related packages.

## Features
- New ebuilds not in the main/guru repo
- Existing ebuilds fixed for use with Clang/libc++
    - Fixed here means either changing the ebuild itself, or simply passing patches to it.
- Stylize: Better compiler flags, package masks, and more to come. This is the main part of the overlay's profiles.
- ... More in the future, maybe?
