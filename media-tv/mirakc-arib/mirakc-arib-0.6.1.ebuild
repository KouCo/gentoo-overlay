# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CMAKE_MAKEFILE_GENERATOR="ninja"

inherit cmake-utils

DESCRIPTION="mirakc-tools for Japanese TV broadcast contents"
HOMEPAGE="https://github.com/masnagam/mirakc-arib"
SRC_URI="https://github.com/masnagam/mirakc-arib/archive/${PV}.tar.gz"

LICENSE="MIT Apache-2.0"
SLOT="0"
KEYWORDS="amd64"
RESTRICT="network-sandbox"
IUSE="debug"

RDEPEND=""
DEPEND="${RDEPEND}
        dev-util/ninja
"

PATCHES=(
	"${FILESDIR}/${PV}-pat-assert.patch"
)

src_configure() {
	if use debug; then
		CMAKE_BUILD_TYPE="Debug"
	else
		CMAKE_BUILD_TYPE="Release"
	fi

	cmake-utils_src_configure
}

src_compile() {
	eninja -C ${BUILD_DIR} vendor
	eninja -C ${BUILD_DIR}
}

src_install() {
	dobin ${BUILD_DIR}/bin/mirakc-arib
}
