
Debian
====================
This directory contains files used to package xelonmuskd/xelonmusk-qt
for Debian-based Linux systems. If you compile xelonmuskd/xelonmusk-qt yourself, there are some useful files here.

## xelonmusk: URI support ##


xelonmusk-qt.desktop  (Gnome / Open Desktop)
To install:

	sudo desktop-file-install xelonmusk-qt.desktop
	sudo update-desktop-database

If you build yourself, you will either need to modify the paths in
the .desktop file or copy or symlink your xelonmusk-qt binary to `/usr/bin`
and the `../../share/pixmaps/xelonmusk128.png` to `/usr/share/pixmaps`

xelonmusk-qt.protocol (KDE)

