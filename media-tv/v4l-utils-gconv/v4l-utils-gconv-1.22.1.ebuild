# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit flag-o-matic udev xdg-utils

DESCRIPTION="Separate utilities ebuild from upstream v4l-utils package"
HOMEPAGE="https://git.linuxtv.org/v4l-utils.git"
SRC_URI="https://linuxtv.org/downloads/v4l-utils/v4l-utils-${PV}.tar.bz2"

S="${WORKDIR}/v4l-utils-${PV}"

LICENSE="GPL-2+ LGPL-2.1+"
SLOT="0"
KEYWORDS="amd64 ~arm arm64 ~ppc64 ~sparc x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"
BDEPEND="
	sys-devel/gettext
	virtual/pkgconfig"

src_configure() {
	econf \
		--prefix=/opt/v4l-utils \
		--disable-static \
		--enable-gconv \
		--disable-doxygen-doc \
		--disable-doxygen-dot \
		--disable-doxygen-html \
		--disable-doxygen-ps \
		--disable-doxygen-pdf \
		--disable-libdvbv5 \
		--disable-dyn-libv4l \
		--disable-v4l-utils \
		--disable-v4l2-compliance-libv4l \
		--disable-v4l2-ctl-libv4l \
		--disable-v4l2-ctl-stream-to \
		--disable-qv4l2 \
		--disable-qvidcap \
		--disable-bpf
}

src_compile() {
	emake -C contrib/gconv
}

src_install() {
	emake -C contrib/gconv DESTDIR="${D}" install

	newenvd - "99${PN}" <<-_EOF_
		GCONV_PATH=${EPREFIX}/opt/v4l-utils/lib64/gconv:${EPREFIX}/opt/v4l-utils/lib/gconv
	_EOF_
}

pkg_postinst() { xdg_icon_cache_update; }
pkg_postrm() { xdg_icon_cache_update; }
