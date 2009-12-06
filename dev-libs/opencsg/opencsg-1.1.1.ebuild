# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="OpenCSG is a library that does image-based CSG rendering using OpenGL."
HOMEPAGE="OpenCSG is a library that does image-based CSG rendering using OpenGL."
SRC_URI="http://www.opencsg.org/OpenCSG-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

QTVER="4.5.1"

DEPEND="media-libs/glew
	>=sci-mathematics/cgal-3.3.1
	>=x11-libs/qt-core-${QTVER}:4"
RDEPEND="${DEPEND}"


src_compile() {
	cd OpenCSG-${PV}
	emake || die "main emake failed"
}

src_install() {
	cd OpenCSG-${PV}
	dolib lib/* 
	dodir /usr /usr/include/
	install include/* ${D}/usr/include/
	dodoc build.txt changelog.txt license.txt version.txt
	dohtml index.html news.html publications.html
}
