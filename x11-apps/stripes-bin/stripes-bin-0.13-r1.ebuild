# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

#inherit java-pkg-2

DESCRIPTION="A simple and fast java-based stripboard designer program"
HOMEPAGE="http://sites.google.com/site/libby8dev/stripes"
SRC_URI="http://sites.google.com/site/libby8dev/stripes/Stripes.jar"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_unpack() {
	mkdir -p "${S}"
	cp -L "${DISTDIR}/${A}" ${S}/. || die
}

src_install() {
	dodir "/opt/stripes/"
	insinto "/opt/stripes"
	cp -L ${A} "${D}/opt/stripes/"
	echo '#!/bin/bash' > "${D}/opt/stripes/stripes"
	echo 'java -jar /opt/stripes/Stripes.jar' >> "${D}/opt/stripes/stripes"
	chmod +x "${D}/opt/stripes/stripes"
}
