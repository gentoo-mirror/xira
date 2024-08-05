# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MAJOR_VER="$(ver_cut 1-4)"

if [[ "${PN}" == "davinci-resolve-studio" ]] ; then
	BASE_NAME="DaVinci_Resolve_Studio_${MAJOR_VER}_Linux"
	CONFLICT_PKG="!!media-video/davinci-resolve"
elif [[ "${PN}" == "davinci-resolve-beta" ]] ; then
	BASE_NAME="DaVinci_Resolve_${MAJOR_VER}_Linux"
	CONFLICT_PKG="
		!!media-video/davinci-resolve
		!!media-video/davinci-resolve-studio"
else
	BASE_NAME="DaVinci_Resolve_${MAJOR_VER}_Linux"
	CONFLICT_PKG="!!media-video/davinci-resolve-studio"
fi

ARC_NAME="${BASE_NAME}.zip"
MRD_VER=1.6.4
inherit udev xdg

DESCRIPTION="Professional A/V post-production software suite"
HOMEPAGE="
	https://www.blackmagicdesign.com/support/family/davinci-resolve-and-fusion
"
SRC_URI="${ARC_NAME}
	https://www.danieltufvesson.com/download/?file=makeresolvedeb/makeresolvedeb_${MRD_VER}_multi.sh.tar.gz"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="-* ~amd64"
IUSE="doc udev +system-glib"

RESTRICT="strip mirror bindist fetch userpriv"

RDEPEND="
	virtual/glu
	x11-libs/gtk+:=
	virtual/libcrypt:=
	${CONFLICT_PKG}
"

DEPEND="
	dev-libs/apr-util
	app-arch/libarchive
	dev-libs/openssl-compat
	dev-qt/qtcore:5/5.15.3
	dev-qt/qtsvg:5/5.15
	dev-qt/qtwebengine:5/5.15
	dev-qt/qtwebsockets:5/5.15
	dev-qt/qtvirtualkeyboard:5/5.15
	media-libs/gstreamer
	media-libs/libpng
	sys-fs/fuse:3[suid]
	udev? ( virtual/udev )
	virtual/opencl
	x11-misc/xdg-user-dirs
	${RDEPEND}
"

BDEPEND="
	app-arch/unzip
	dev-util/patchelf
"

S="${WORKDIR}"
DR="${WORKDIR}/davinci-resolve_${MAJOR_VER}-mrd${MRD_VER}_amd64"

QA_PREBUILT="*"

pkg_nofetch() {
	einfo "Please download installation file"
	einfo "  - ${ARC_NAME}"
	einfo "from ${HOMEPAGE} and place it in \$\{DISTDIR\}."
	einfo "===="
	einfo "Please download installation file"
	einfo "  - makeresolvedeb_${MRD_VER}_multi.sh.tar.gz"
	einfo "from https://www.danieltufvesson.com/makeresolvedeb and place it in \$\{DISTDIR\}."
}

src_prepare() {
	mv "${WORKDIR}"/makeresolvedeb*.sh "${WORKDIR}"/makeresolvedeb.sh
	eapply -p0 "${FILESDIR}/makeresolvedeb_gentoo_${MRD_VER}.patch"

	eapply_user

	sed -i -e "s!#LIBDIR#!$(get_libdir)!" "${WORKDIR}"/makeresolvedeb.sh || die "Sed failed!"
}

_adjust_sandbox() {
	addwrite /dev
	addread /dev
	addpredict /root
	addpredict /etc
	addpredict /lib
	addpredict /usr
	addpredict /sys
	addpredict "/var/BlackmagicDesign"
	addpredict "/var/BlackmagicDesign/DaVinci Resolve"
}

src_compile() {
	_adjust_sandbox
	cd "${WORKDIR}"
	chmod u+x ${BASE_NAME}.run
	CI_TEST="1" "${WORKDIR}"/makeresolvedeb.sh ${BASE_NAME}.run
}

src_install() {
	cp -a "${DR}"/lib "${ED}" || die
	cp -a "${DR}"/opt "${ED}" || die
	cp -a "${DR}"/usr "${ED}" || die
	mv "${ED}"/usr/lib "${ED}"/usr/lib64 || die
	#cp -a ${DR}/var "${ED}" || die

	if use doc ; then
		dodoc *.pdf
	fi

	# See bug 718070 for reason for the next line.
	if use system-glib ; then
		rm -f "${ED}"/opt/resolve/libs/libglib-*
		rm -f "${ED}"/opt/resolve/libs/libgio-2.0.so*
		rm -f "${ED}"/opt/resolve/libs/libgmodule-2.0.so*
    fi
}

pkg_preinst() {
	xdg_pkg_preinst
}

pkg_postinst() {
	xdg_pkg_postinst
	udev_reload
}

pkg_postrm() {
	xdg_pkg_postrm
	udev_reload
}
