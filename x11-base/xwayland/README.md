# Credits
Credits go to the Gentoo X11 project maintainers.

# Info
These are modified versions of main repo ebuilds, introducing the famous [DPI scaling patch](https://gitlab.freedesktop.org/xorg/xserver/-/merge_requests/733). Although, this file actually uses a patch from the [Hyprland](https://github.com/hyprwm/Hyprland/blob/main/nix/patches/xwayland-hidpi.patch) repo.
The patch has been minimally modified from the original GitLab MR, as the `xwayland-screen.c` file has changed contents, giving hunk failures.
