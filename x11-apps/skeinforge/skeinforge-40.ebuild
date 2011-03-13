# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit distutils

DESCRIPTION="Skeinforge from ReplicatorG"
HOMEPAGE="http://replicat.org"
SRC_URI="http://fabmetheus.crsndoo.com/files/${PV}_reprap_python_beanshell.zip"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""
RDEPEND=""

#PYTHON_USE_WITH="xml"

pkg_setup() {
	#python_pkg_setup
	echo
}

src_compile() {
	echo
}


src_install() {
	cd skeinforge-40
	dodir /opt /opt/skeinforge 
	mv __init__.py fabmetheus.kdevelop  fabmetheus_utilities \
	skeinforge_application  test.stl \
	documentation  fabmetheus.kdevses   models terminal.sh \
	"${D}/opt/skeinforge/"
}
