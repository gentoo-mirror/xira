<h1 align="center">Stylism :: <i>Xira</i></h1>
<p align="center"><i>~ An LLVM-centric Portage overlay ~</i></p>

## License info
Every ebuild I wrote here is licensed under ISC.
Ebuilds I have copied from e.g. the main repository preserve their original GPLv2 header and authors.
I am not a legal expert. As far as I understand ISC is GPLv2 compatible, but if there are any issues, please message me [here](https://to.stylism.moe/#/@revelation:stylism.moe/), or make an issue on GitHub/Codeberg.

## ⚠️ Experimental nature ⚠️
I don't advise you using this overlay, unless you want to or are using one of the LLVM profiles provided by the Gentoo repository or my modified ones.

This project is also in its early stage, with frequent changes, and future plans.  
Most notably I'd like to implement something like `make.conf.lto` and related concepts from [Gentoo-LTO](https://github.com/InBetweenNames/gentooLTO), which hasn't been updated since Dec. 2022, at time of writing this. (2023-08-02)

### Requirements
- x86-64-v3 compatible machine
    - CFLAGS in profiles and some ebuilds explicitly state `-march=x86-64-v3`, as of now.
- LLVM profile
    - Best is to install using the LLVM stage3.
    - Use either the main repository LLVM profile, or the `llvm-desktop` profiles here (preferred).

## Why?
Because I can :3  
In all seriousness, this overlay exists because of:
- Me wanting to put my changes to existing ebuilds somewhere
- Wanting to compile as much as possible using `clang`
    - Also with ridiculous compiler flags
- In general, have a place for LLVM related things (profiles, ebuilds, ...)


## What's in here?
A directory structure and explanations are listed below.
```sh
xira
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
