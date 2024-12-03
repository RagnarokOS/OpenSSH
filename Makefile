# Ragnarok-specific Makefile for OpenSSH
# $Ragnarok: Makefile,v 1.1 2024/12/03 23:41:34 lecorbeau Exp $

MAKE	= make -C
PKG	= openssh
VERSION	= 9.2p1

DEBIAN	= changelog control rules

src:
	/usr/bin/apt-get source openssh

# Building a deb package
deb: src
	cp ${DEBIAN} ${PKG}-${VERSION}/debian/
	patch -d ${PKG}-${VERSION} < patches/get-proper-clang-version.diff
	patch -d ${PKG}-${VERSION}/debian/ < patches/get-proper-clang-version.diff
	cd ${PKG}-${VERSION}; \
		dch -n -p; \
		/usr/bin/debuild -aamd64 -us -uc -b
