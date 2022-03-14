# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CMAKE_MAKEFILE_GENERATOR="ninja"

inherit git-r3 cmake-utils

DESCRIPTION="mirakc-tools for Japanese TV broadcast contents"
HOMEPAGE="https://github.com/mirakc/mirakc-arib"
#SRC_URI="https://github.com/mirakc/mirakc-arib/archive/${PV}.tar.gz"
EGIT_REPO_URI="https://github.com/mirakc/mirakc-arib"
EGIT_SUBMODULES=('*')
EGIT_COMMIT="${PV}"

LICENSE="MIT Apache-2.0"
SLOT="0"
KEYWORDS="amd64"
RESTRICT="network-sandbox"
IUSE="debug"

RDEPEND=""
DEPEND="${RDEPEND}
        dev-util/ninja
"

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
