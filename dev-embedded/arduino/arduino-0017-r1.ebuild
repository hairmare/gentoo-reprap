# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/arduino/arduino-0017.ebuild,v 1.1 2009/10/17 18:15:07 nixphoeni Exp $

EAPI=2
inherit eutils

SNG_PV="1.4-r1"
REPRAP_PV="1.2"

DESCRIPTION="Arduino is an open-source AVR electronics prototyping platform"
HOMEPAGE="http://arduino.cc/"
SRC_URI="http://www.arduino.cc/files/${P}.tgz
sanguino? ( http://sanguino.googlecode.com/files/sanguino-software-${SNG_PV}.zip )
reprap? (
http://downloads.sourceforge.net/project/reprap/Gen3%20Firmware/v${REPRAP_PV}/reprap-gen3-firmware-${REPRAP_PV}.zip )"
LICENSE="GPL-2 LGPL-2 CCPL-Attribution-ShareAlike-3.0"
SLOT="0"
KEYWORDS="~x86 ~amd64"
RESTRICT="strip binchecks"
IUSE="java sanguino reprap"
RDEPEND="dev-embedded/avrdude sys-devel/crossdev"
DEPEND="${RDEPEND} java? ( virtual/jre dev-embedded/uisp dev-java/jikes dev-java/rxtx dev-java/antlr )"

pkg_setup() {
	[ ! -x /usr/bin/avr-g++ ] && ewarn "Missing avr-g++; you need to crossdev -s4 avr"
}

pkg_postinst() {
	pkg_setup
	einfo "Copy /usr/share/${P}/hardware/cores/arduino/Makefile and edit it to suit the project"
}

src_prepare() {
	epatch "${FILESDIR}"/Makefile-${PV}.patch
	rm -rf hardware/tools/avrdude*
	if ! use java; then
		rm -rf lib
		rm -f arduino
	else
		# fix the provided arduino script to call out the right
		# libraries, remove resetting of $PATH, and fix its
		# reference to LD_LIBRARY_PATH (see bug #189249)
		epatch "${FILESDIR}"/arduino-script-${PV}.patch
	fi
}

src_install() {
	mkdir -p "${D}/usr/share/${P}/" "${D}/usr/bin"
	cp -a "${S}" "${D}/usr/share/"
	fowners -R root:uucp "/usr/share/${P}/hardware"
	if use java; then
		sed -e  s@__PN__@${P}@g < "${FILESDIR}"/arduino > "${D}/usr/bin/arduino"
		chmod +x "${D}/usr/bin/arduino"

		# get rid of libraries provided by other packages
		rm -f "${D}/usr/share/${P}/lib/RXTXcomm.jar"
		rm -f "${D}/usr/share/${P}/lib/librxtxSerial.so"
		rm -f "${D}/usr/share/${P}/lib/antlr.jar"
		rm -f "${D}/usr/share/${P}/lib/ecj.jar"

		# use system avrdude
		# patching class files is too hard
		dosym /usr/bin/avrdude "/usr/share/${P}/hardware/tools/avrdude"
		dosym /etc/avrdude.conf "/usr/share/${P}/hardware/tools/avrdude.conf"

		# IDE tries to compile these libs at first start up
		fperms -R g+w "/usr/share/${P}/hardware/libraries"
	fi
	if use sanguino; then
		cp -a "${S}/../sanguino-software-${SNG_PV}/cores/sanguino" \
		"${D}/usr/share/${P}/hardware/cores/sanguino"
		cp -a "${S}/../sanguino-software-${SNG_PV}/bootloaders/atmega644p" \
		"${D}/usr/share/${P}/hardware/bootloaders/atmeg644p"

		# remove libs that have sanguino replacements
		rm -rf "${D}/usr/share/${P}/hardware/libraries/Ethernet"
		cp -a "${S}/../sanguino-software-${SNG_PV}/libraries/Ethernet" \
		"${D}/usr/share/${P}/hardware/libraries/Ethernet"

		rm -rf "${D}/usr/share/${P}/hardware/libraries/Servo"
		cp -a "${S}/../sanguino-software-${SNG_PV}/libraries/Servo" \
		"${D}/usr/share/${P}/hardware/libraries/Servo"

		rm -rf "${D}/usr/share/${P}/hardware/libraries/Wire"
		cp -a "${S}/../sanguino-software-${SNG_PV}/libraries/Wire" \
		"${D}/usr/share/${P}/hardware/libraries/Wire"

		cat "${S}/../sanguino-software-${SNG_PV}/boards.txt" >> \
		"${D}/usr/share/${P}/hardware/boards.txt"
	fi
	if use reprap; then
	RepRapSDCard/ SimplePacket/
		cp -a "${S}/../reprap-gen3-firmware-2009-08-05/libraries/RepRapSDCard" \
		"${D}/usr/share/${P}/hardware/libraries/RepRapSDCard"

		cp -a "${S}/../reprap-gen3-firmware-2009-08-05/libraries/SimplePacket" \
		"${D}/usr/share/${P}/hardware/libraries/SimplePacket"
	fi

	dodoc readme.txt
}
