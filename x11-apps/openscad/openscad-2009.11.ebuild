# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="OpenSCAD is a software for creating solid 3D CAD objects."
HOMEPAGE="http://openscad.org/"
SRC_URI="http://openscad.org/download/openscad-${PV}.src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=">=dev-libs/opencsg-1.1.1
>=sci-mathematics/cgal-3.4"
RDEPEND="${DEPEND}"

src_compile() {
	cd openscad-${PV}.src
	sh release-linux.sh
}

src_install() {
	cd openscad-${PV}.src
	#dobin release/bin/*
	#rm release/lib/openscad/libGLEW.so.1.5 release/lib/openscad/libopencsg.so.1	release/lib/openscad/libCGAL.so.2
	#dolib release/lib/openscad/*
	dobin release/lib/openscad/openscad
	dodoc README
	mv examples "${D}/usr/share/doc/openscad-${PV}/examples"
}
