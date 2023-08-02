# Why use `package.mask`?
Currently, `=sys-devel/llvm-18.0.0.9999` does not even start compiling, instead crashing due to "Specified distribution component 'llvm-tapi-diff' doesn't have an install target". Since this build fails, `emerge --keep-going` can't install any other LLVM 18 packages, logically.

For now, LLVM 17's live ebuild is used to mitigate this, and it's still a live package.
