<h1 align="center"><i>kir68k/xira</i></h1>
<p align="center"><i>~ A Clang-optimized Portage overlay ~</i></p>
<p align="center">
    <img src="https://seal.stylism.moe/get/@kir68k.gh.xira?theme=asoul" />
</p>

### Package count
45 (2024-08-22 08:18 CEST)

Counted by:
```
ls -Fd */* | grep '/$' | grep -Ev '^(profiles|metadata)' | wc -l
```
<i>Taken from [a very cool overlay](https://github.com/stefantalpalaru/gentoo-overlay)</i>

# Overview
This is a personal portage overlay, which was initially created with a goal in mind of adding patches to C/C++ programs which can't compile on Clang either with default CFLAGS, or with my more extreme ones (per `features/stylize`).

Now this repo is *primarily* for packages related to gnome, such as video-trimmer or secrets, and Source Engine/SRCDS related tools. The rest is programs I haven't seen packaged in any other repo, that I use.

> [!NOTE]
> I want to keep this repo relatively minimal for ease of maintenance. Before remaking this README, there were 72 ebuilds in total.

## Enabling
To enable this overlay, use [eselect-repository](https://wiki.gentoo.org/wiki/Eselect/Repository).
```
eselect repository enable xira
emaint sync -r xira
```

## Information
### License info
Every ebuild I wrote here is licensed under the ISC License.
Ebuilds I have copied from e.g. the main repository preserve their original GPLv2 header and authors.
> [!IMPORTANT]
> I am not a legal expert. As far as I understand ISC is GPLv2 compatible, but if there are any issues, please make an issue or message me [here](https://to.stylism.moe/#/@revelation:stylism.moe/).

### Requirements
- GURU Overlay
    - Some ebuilds might have dependencies that exist only in the GURU overlay. [//]: # "TODO: Explain which ebuilds require this, please."
#### Recommendations
- LLVM profile
    - Best is to install using the LLVM stage3.
    - Use either the main repository LLVM profile, or the `llvm-desktop` profiles here. I personally use llvm-systemd-desktop-gnome on my systems.
- x86-64-v3 compatible machine
    - CFLAGS in profiles and some ebuilds explicitly state `-march=x86-64-v3`, as of 2024-04-08.

> [!NOTE]
> Everything in this repository should compile using either LLVM/Clang or GCC.\
> I only test using portage settings from `features/stylize`, i.e. ThinLTO, x86-64-v3, LLVM toolchain.

> [!WARNING]
> The LLVM profiles from here use the main Gentoo ones as `parent`, but contain extra changes, through `features/stylize`.
> Most notably, they set `-flto=thin` and `-fsplit-lto-unit` in C(XX)FLAGS.
>
> Due to `-fsplit-lto-unit`, **ALL** installed Qt dev-qt packages need to be rebuilt, if they don't use it.
> If you have any suggestions or think something's wrong with it, please make an issue or PR.

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
└── metadata/sets
    ├── llvm-complete
    ├── mail-prequisites
    └── openwrt-prequisites
```
- profiles
    - features/stylize
        - Primary features, currently including: \*FLAGS changes.
- metadata/sets
    - llvm-complete
        - Every package related to LLVM.
    - mail-prequisites
        - Packages related to creating a mail server.
        I recommend using Docker instead of bare-metal for the agony that mailservers are.
    - openwrt-prequisites
        - Packages required for compiling an OpenWrt image.
    - uup-prequisites
        - Packages for creating a Windows ISO through uupdump, if you need that.
