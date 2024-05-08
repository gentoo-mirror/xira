# Why a copy of an existing ebuild?
I copied this from [stefantalpalaru's](https://github.com/stefantalpalaru/gentoo-overlay) overlay to introduce experimental GIMP 3 support, through the added `gimp3` USE flag. Note that GIMP 2.99.18 is required for this, the live package does not seem to work properly due to the way gmic-qt handles functions based on GIMP versions. I might make a patch for this if I understand the code clearly enough.

# Credits
<i>This ebuild originates from the [stefantalpalaru](https://github.com/stefantalpalaru/gentoo-overlay) overlay.</i>
