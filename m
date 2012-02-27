Return-Path: <cygwin-patches-return-7608-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20738 invoked by alias); 27 Feb 2012 23:25:57 -0000
Received: (qmail 20688 invoked by uid 22791); 27 Feb 2012 23:25:55 -0000
X-SWARE-Spam-Status: No, hits=-6.9 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,SPF_HELO_PASS,T_RP_MATCHES_RCVD
X-Spam-Check-By: sourceware.org
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 27 Feb 2012 23:25:37 +0000
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q1RNPbYY025195	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)	for <cygwin-patches@cygwin.com>; Mon, 27 Feb 2012 18:25:37 -0500
Received: from [10.3.113.13] ([10.3.113.13])	by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id q1RNPauf021607	for <cygwin-patches@cygwin.com>; Mon, 27 Feb 2012 18:25:37 -0500
Message-ID: <4F4C10F0.3080306@redhat.com>
Date: Mon, 27 Feb 2012 23:25:00 -0000
From: Eric Blake <eblake@redhat.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: fix tcgetsid return type
OpenPGP: url=http://people.redhat.com/eblake/eblake.gpg
Content-Type: multipart/signed; micalg=pgp-sha256; protocol="application/pgp-signature"; boundary="------------enigF6A663E6C89019B22AD7AA8A"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2012-q1/txt/msg00031.txt.bz2

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF6A663E6C89019B22AD7AA8A
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-length: 3688

Detected by gnulib's unit tests.  POSIX requires tcgetsid to return
pid_t, not int.

2012-02-27  Eric Blake  <eblake@redhat.com>

	* include/sys/termios.h (tcgetsid): Fix return type.
	* termios.cc (tcgetsid): Likewise.
	* fhandler_termios.cc (fhandler_termios::tcgetsid): Likewise.
	* fhandler.h (fhandler_base): Likewise.
	* fhandler.cc (fhandler_base::tcgetsid): Likewise.

diff --git a/winsup/cygwin/fhandler.cc b/winsup/cygwin/fhandler.cc
index ef25a07..c3bca4f 100644
--- a/winsup/cygwin/fhandler.cc
+++ b/winsup/cygwin/fhandler.cc
@@ -1464,7 +1464,7 @@ fhandler_base::tcgetpgrp ()
   return -1;
 }

-int
+pid_t
 fhandler_base::tcgetsid ()
 {
   set_errno (ENOTTY);
diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index 605f59b..3b186bd 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -383,7 +383,7 @@ public:
   virtual int tcgetattr (struct termios *t);
   virtual int tcsetpgrp (const pid_t pid);
   virtual int tcgetpgrp ();
-  virtual int tcgetsid ();
+  virtual pid_t tcgetsid ();
   virtual bool is_tty () const { return false; }
   virtual bool ispipe () const { return false; }
   virtual pid_t get_popen_pid () const {return 0;}
@@ -1155,7 +1155,7 @@ class fhandler_termios: public fhandler_base
   virtual void __release_output_mutex (const char *fn, int ln) {}
   void echo_erase (int force =3D 0);
   virtual _off64_t lseek (_off64_t, int);
-  int tcgetsid ();
+  pid_t tcgetsid ();

   fhandler_termios (void *) {}

diff --git a/winsup/cygwin/fhandler_termios.cc
b/winsup/cygwin/fhandler_termios.cc
index c218fde..36017dc 100644
--- a/winsup/cygwin/fhandler_termios.cc
+++ b/winsup/cygwin/fhandler_termios.cc
@@ -1,7 +1,7 @@
 /* fhandler_termios.cc

    Copyright 1999, 2000, 2001, 2002, 2003, 2004, 2005, 2008, 2009,
-   2010, 2011 Red Hat, Inc.
+   2010, 2011, 2012 Red Hat, Inc.

 This file is part of Cygwin.

@@ -401,7 +401,7 @@ fhandler_termios::sigflush ()
     tcflush (TCIFLUSH);
 }

-int
+pid_t
 fhandler_termios::tcgetsid ()
 {
   if (myself->ctty !=3D -1 && myself->ctty =3D=3D tc ()->ntty)
diff --git a/winsup/cygwin/include/sys/termios.h
b/winsup/cygwin/include/sys/termios.h
index a0d1b24..a87f9de 100644
--- a/winsup/cygwin/include/sys/termios.h
+++ b/winsup/cygwin/include/sys/termios.h
@@ -1,7 +1,7 @@
 /* sys/termios.h

    Copyright 1997, 1998, 1999, 2000, 2001, 2002, 2003, 2005, 2006,
-   2007, 2008, 2009, 2010, 2011 Red Hat, Inc.
+   2007, 2008, 2009, 2010, 2011, 2012 Red Hat, Inc.

 This file is part of Cygwin.

@@ -14,6 +14,8 @@ details. */
 #ifndef	_SYS_TERMIOS_H
 #define _SYS_TERMIOS_H

+#include <sys/types.h>
+
 #define	TIOCMGET	0x5415
 #define	TIOCMBIS	0x5416
 #define	TIOCMBIC	0x5417
@@ -328,7 +330,7 @@ int tcsendbreak (int, int);
 int tcdrain (int);
 int tcflush (int, int);
 int tcflow (int, int);
-int tcgetsid (int);
+pid_t tcgetsid (int);
 void cfmakeraw (struct termios *);
 speed_t cfgetispeed(const struct termios *);
 speed_t cfgetospeed(const struct termios *);
diff --git a/winsup/cygwin/termios.cc b/winsup/cygwin/termios.cc
index 3096513..0fb0de2 100644
--- a/winsup/cygwin/termios.cc
+++ b/winsup/cygwin/termios.cc
@@ -1,7 +1,7 @@
 /* termios.cc: termios for WIN32.

    Copyright 1996, 1997, 1998, 2000, 2001, 2002, 2003, 2004, 2005, 2006,
-   2007, 2008, 2009, 2010, 2011 Red Hat, Inc.
+   2007, 2008, 2009, 2010, 2011, 2012 Red Hat, Inc.

    Written by Doug Evans and Steve Chamberlain of Cygnus Support
    dje@cygnus.com, sac@cygnus.com
@@ -207,7 +207,7 @@ tcgetpgrp (int fd)
   return res;
 }

-extern "C" int
+extern "C" pid_t
 tcgetsid (int fd)
 {
   int res;

--=20
Eric Blake   eblake@redhat.com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--------------enigF6A663E6C89019B22AD7AA8A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-length: 620

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQEcBAEBCAAGBQJPTBDwAAoJEKeha0olJ0Nq/eoH/1zzkJa4cYdHfd+/cKAIdXgB
/YtXd1RoGSl5BPHBvY1rcYh2tIa1md4z0CLYha9jqYPix5bxor0eQ/a7kBD/BWJ/
1TXuNeJ0/HCTUWXlzRp+ZKKYLIvGxS9zSGMBX7GHmrLY5V7bShAlKc4jnsZE0RHD
MpVQOkBA5xTBs0L3u9ADh3w5BBhgKf5XfnohAhEgthOyVVU9cAlTOhPS2xHOV5Ol
LjpBdm+lqg+6uwTavrolqApEnMaSAIyAbGeuSiwRtwKFzcP9ynrgVVyAblHkRDa5
JOUPMQqo3l14XcTEErM2Pd93OL6AMAhk92AJsDapmdIXB8ZrqISaO8vW8myy3tM=
=IP7O
-----END PGP SIGNATURE-----

--------------enigF6A663E6C89019B22AD7AA8A--
