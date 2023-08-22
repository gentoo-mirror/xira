# `sys-libs/libcxxabi`
This is a modified version of the main repository ebuild, modified to mitigate build failures related to flag-o-matic removing `--unwindlib`.  
## TODO
- [*] Remove *FLAGS local vars, or replace them with something better.
- [*] Add `custom-cflags` USE flag, maybe?
- [ ] Possibly remove modified cmake arguments for compiler-rt (revert to default)

## Info
By default these ebuilds will pull libcxx from this overlay.

## Credits
All credits go to the LLVM package maintainers <llvm@gentoo.org>
