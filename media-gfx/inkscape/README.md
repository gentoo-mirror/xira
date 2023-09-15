# Notice
This ebuild was not written by me, therefore I have not changed the GPLv2 header to ISC.
This ebuild was copied from the Gentoo repository, living [here](https://gitweb.gentoo.org/repo/gentoo.git/tree/media-gfx/inkscape/inkscape-1.2.2.ebuild).
I am also not a C++ dev, at least currently, and made the changes with help of reference websites and SO, combined with what I think should be changed.

# Why?
Inkscape does not seem to build using LLVM/Clang, due to C++17 removal of `std::binary_function` and `std::unary_function`, so I have made a patch converting lines using those two to use `std::function`, which Clang can compile. The patch is added to the ebuild, using EAPI 6's `PATCHES` array.
