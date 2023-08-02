# Copyright 2023 Kirixetamine <revelation@krxt.dev>
# Distributed under the terms of the ISC License

EAPI=8

inherit font

DESCRIPTION="An open source emoji font from Google"
HOMEPAGE="https://fonts.google.com/noto/specimen/Noto+Emoji"

PROPERTIES="live"

LICENSE="OTF-1.1"
SLOT="0"
KEYWORDS="~*"

S="${WORKDIR}"

FONT_SUFFIX="ttf"
FONT_CONF=(
		"${FILESDIR}/75-noto-color-emoji.conf"
)

get() {
	if hash curl 2>/dev/null; then
		curl -Lf --retry 3 --connect-timeout 30 --speed-limit 300 --speed-time 10 "$@"
	elif hash wget 2>/dev/null; then
		wget -O- "$@"
	else
		die
	fi
}

src_unpack() {
	get https://fonts.google.com/download?family=Noto%20Color%20Emoji > Noto_Color_Emoji.zip || die
	unzip Noto_Color_Emoji.zip NotoColorEmoji-Regular.ttf || die
}

src_install() {
	mkdir noto-emoji || die
	mv NotoColorEmoji-Regular.ttf noto-emoji/ || die

	FONT_S="${S}/noto-emoji" font_src_install
}
