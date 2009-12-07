# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit distutils

DESCRIPTION="Skeinforge from ReplicatorG"
HOMEPAGE="http://replicat.org"
SRC_URI="http://replicatorg.googlecode.com/files/skeinforge-0006-r1.zip"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""
RDEPEND=""

pkg_setup() {
	distutils_python_tkinter
}


src_install() {
	cd skeinforge-0006-r1
	dodir /opt /opt/skeinforge 
	mv __init__.py  defaults  documentation  prefs  skeinforge.py \
	skeinforge_tools "${D}/opt/skeinforge/"
}
