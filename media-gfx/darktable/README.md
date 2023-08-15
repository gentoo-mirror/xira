# Credit
These ebuilds were copied from the official repository, with the license header unchanged as usual.

# Changes
Using `auto_ptr` is deprecated and clang does not compile projects using it.  
Therefore, any instance of `auto_ptr` is replaced with `unique_ptr`, alongside updating the `exiv2` dependency to 0.28.0.  
The 0.27.0 version of exiv2 has references to auto_ptr in `/usr/include`, failing darktable installation after compiling the entire program.

## Note
The 0.28.0 version of exiv2 is currently (08/16/2023) masked in the main repository due to a KDE dependency. It should be unmasked on your system.  
Keep in mind this overlay is not made in mind with using KDE (or GNOME for that part), so unmasking does not break anything, as we aren't using affected packages broken by said unmask.
