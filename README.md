<h1 align="center"><i>Xira</i></h1>
<p align="center"><i>~ An LLVM-centric Portage overlay ~</i></p>

## Package count
2023-12-22 03:50 CEST: 72

Counted by:
```
ls -Fd */* | grep '/$' | grep -Ev '^(profiles|metadata)' | wc -l
```
<i>Taken from [a very cool overlay](https://github.com/stefantalpalaru/gentoo-overlay)</i>

#### Note
The LLVM profiles from here use the main repo ones as `parent`, but contain extra changes, through `features/stylize`.
Most notably setting `-fsplit-lto-unit` in C(XX)FLAGS, which requires e.g. LLVM and Qt packages being rebuilt, if they don't use it.

If you have any suggestions or think something's wrong with it, please make an issue or PR.

## Enabling
To enable this overlay, use [eselect-repository](https://wiki.gentoo.org/wiki/Eselect/Repository).
```
eselect repository enable xira
emaint sync -r xira
```

## Information
### License info
Every ebuild I wrote here is licensed under ISC.
Ebuilds I have copied from e.g. the main repository preserve their original GPLv2 header and authors.
I am not a legal expert. As far as I understand ISC is GPLv2 compatible, but if there are any issues, please make an issue or message me [here](https://to.stylism.moe/#/@revelation:stylism.moe/).

### Requirements
- x86-64-v3 compatible machine
    - CFLAGS in profiles and some ebuilds explicitly state `-march=x86-64-v3`, as of 2024-04-08.
- LLVM profile
    - Best is to install using the LLVM stage3.
    - Use either the main repository LLVM profile, or the `llvm-desktop` profiles here. I personally use llvm-systemd-desktop-gnome on my systems.
- GURU Overlay
    - Some ebuilds might have dependencies that exist only in the GURU overlay.

### What's in here?
A directory structure and explanations are listed below.
```sh
xira
├── [ebuild categories]
├── metadata
├── profiles
│   ├── features
│   │   └── stylize
│   ├── llvm-desktop
│   ├── llvm-desktop-gnome
│   ├── llvm-systemd-desktop
│   └── llvm-systemd-desktop-gnome
└── sets
    ├── llvm-complete
    ├── mail-prequisites
    └── openwrt-prequisites
```
- profiles
    - features/stylize<sup>†</sup>
        - Primary features, currently including: \*FLAGS changes.
- sets
    - llvm-complete
        - Every package related to LLVM.
    - mail-prequisites
        - Packages related to creating a mail server.
        I recommend using Docker instead of bare-metal for the agony that mailservers are.
    - openwrt-prequisites
        - Packages required for compiling an OpenWrt image.
    - uup-prequisites
        - Packages for creating a Windows ISO through uupdump, if you need that.
