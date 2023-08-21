# `sys-libs/libcxx`
This is a modified version of the main repository ebuild, modified to mitigate build failures related to flag-o-matic removing `--unwindlib`.  
## TODO
- [ ] Remove *FLAGS local vars, or replace them with something better.
- [ ] Add `custom-cflags` USE flag, maybe?

## Info
Use `sys-libs/libcxxabi` from this overlay with this.

## Credits
All credits go to the LLVM package maintainers <llvm@gentoo.org>
