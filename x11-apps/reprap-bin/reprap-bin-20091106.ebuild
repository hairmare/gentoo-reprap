# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

REPRAP_GENERATION="mendel"

DESCRIPTION="RepRap is the hardware and software for a 3D printer that can print the majority of its own parts."
HOMEPAGE="http://reprap.org"
#SRC_URI="http://sourceforge.net/projects/reprap/files/reprap-${REPRAP_GENERATION}-${PV}.zip"
SRC_URI="mirror://sourceforge/reprap/reprap-mendel-20091106.zip"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=dev-java/rxtx-2.1.7.2"
RDEPEND="${DEPEND}"

src_install() {
	cd reprap-${REPRAP_GENERATION}-${PV}
	insinto /opt/reprap
	doins *
	chmod +x ${D}/opt/reprap/reprap
	mv mendel ${D}/opt/reprap/mendel
}
