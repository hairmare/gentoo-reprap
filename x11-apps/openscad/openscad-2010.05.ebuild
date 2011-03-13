# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="OpenSCAD is a software for creating solid 3D CAD objects."
HOMEPAGE="http://openscad.org/"
SRC_URI="http://github.com/downloads/openscad/openscad/openscad-${PV}.src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=dev-libs/opencsg-1.3.0
>=sci-mathematics/cgal-3.5
>=dev-cpp/eigen-2.0.11"
RDEPEND="${DEPEND}"

src_compile() {
	cd openscad-${PV}
	qmake && make
}

src_install() {
	cd openscad-${PV}
	#rm release/lib/openscad/libGLEW.so.1.5 release/lib/openscad/libopencsg.so.1	release/lib/openscad/libCGAL.so.2
	#dolib release/lib/openscad/*
	dobin openscad
	dodoc README
	mv examples "${D}/usr/share/doc/openscad-${PV}/examples"
}
