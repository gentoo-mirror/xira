# What is this?
This ebuild installs DaVinci Resolve properly using makeresolvedeb. Taken from https://bugs.gentoo.org/718070, including the makeresolvedeb patch in `files/`. I edited it a bit to properly resolve glib/gio issues on startup.

> [!NOTE]
> This works on Studio as well, the ebuild accepts either of the zipped files in `${DISTDIR}`.
> To use beta versions, install `media-video/davinci-resolve-beta` instead.

> [!IMPORTANT]
> This and the beta ebuild block each other, to avoid installing both in the same directory.
