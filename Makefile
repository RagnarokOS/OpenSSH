# Ragnarok-specific Makefile for OpenSSH
# $Ragnarok: Makefile,v 1.3 2024/12/05 19:06:40 lecorbeau Exp $

MAKE	= make -C
PKG	= openssh
VERSION	= 9.2p1

DEBIAN	= debian

src:
	/usr/bin/apt-get source openssh

# Building a deb package
deb: src
	cp -r ${DEBIAN} ${PKG}-${VERSION}/
	patch -d ${PKG}-${VERSION} < patches/get-proper-clang-version.diff
	cd ${PKG}-${VERSION}; \
		dch -n -p; \
		/usr/bin/debuild -aamd64 -Ppkg.openssh.nognome -us -uc -b
