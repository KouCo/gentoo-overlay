# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit systemd cargo

DESCRIPTION="mirakc"
HOMEPAGE="https://github.com/mirakc/mirakc"
SRC_URI="https://github.com/mirakc/mirakc/archive/${PV}.tar.gz"

LICENSE="MIT Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="network-sandbox"
IUSE="systemd debug"
REQUIRED_USE="systemd"

RDEPEND="media-tv/mirakc-arib
         net-misc/socat
"
DEPEND="${RDEPEND}
        || (
            dev-lang/rust-bin
            dev-lang/rust
        )
"

src_unpack() {
	cargo_src_unpack

	rm ${ECARGO_HOME}/config

	pushd "${S}" > /dev/null || die
	CARGO_HOME="${ECARGO_HOME}" cargo fetch || die
	CARGO_HOME="${ECARGO_HOME}" cargo vendor "${ECARGO_VENDOR}" || die
	popd > /dev/null || die

	cargo_gen_config
}

src_compile() {
	cargo_src_compile
}

src_install() {
	cargo_src_install

	insinto /etc/mirakc
	newins ${S}/docker/config.yml config.yml
	newins ${S}/resources/strings.yml strings.yml
	newins ${FILESDIR}/mirakurun.openapi-3.3.1.json mirakurun.openapi.json

	keepdir /var/lib/mirakc/epg

	if use systemd; then
		systemd_newunit ${FILESDIR}/mirakc.service mirakc.service
	fi
}
