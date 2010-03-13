# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="ReplicatorG is a simple, open source machine controller"
HOMEPAGE="http://replicat.org/"
SRC_URI="http://replicatorg.googlecode.com/files/replicatorg-${PV}-linux-v1.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=dev-embedded/avrdude-5.8
>=dev-java/rxtx-2.1.7.2"
RDEPEND="${DEPEND}"

src_install() {
	cd replicatorg-${PV}
	dobin replicatorg
	dolib lib/*
	dodoc *.txt

	dodir /opt /opt/replicatorg /opt/replicatorg/lib /opt/replicatorg/bin \
	/opt/replicatorg/firmware /opt/replicatorg/tools

	mv "${D}/usr/lib" "${D}/opt/replicatorg/"
	mv "${D}/usr/bin/replicatorg" "${D}/opt/replicatorg/bin/"
	sed --in-place 's/dirname \$0.*/dirname \$0`\/../' \
	"${D}/opt/replicatorg/bin/replicatorg"
	sed --in-place 's/lib\/RXTXcomm.jar/`java-config -p rxtx-2`/'\
	"${D}/opt/replicatorg/bin/replicatorg"
	sed --in-place 's/^LD_LIBRARY_PATH.*/LD_LIBRARY_PATH=\/usr\/lib\/rxtx-2\//'\
	"${D}/opt/replicatorg/bin/replicatorg"
	mv "${D}/usr/share/doc/replicatorg-bin-${PV}" "${D}/opt/replicatorg/doc"
	mv firmware firmware.xml "${D}/opt/replicatorg/"
	mv machines.xml "${D}/opt/replicatorg/" || die "no machines.xml installed"

	# replicatorg expects avrdude in the tools dir
	ln -s /etc/avrdude.conf "${D}/opt/replicatorg/tools/avrdude.conf"
	ln -s /usr/bin/avrdude  "${D}/opt/replicatorg/tools/avrdude"

}
