Return-Path: <cygwin-patches-return-7381-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16868 invoked by alias); 22 May 2011 01:26:55 -0000
Received: (qmail 16857 invoked by uid 22791); 22 May 2011 01:26:54 -0000
X-SWARE-Spam-Status: No, hits=-6.7 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,SPF_HELO_PASS,T_RP_MATCHES_RCVD
X-Spam-Check-By: sourceware.org
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sun, 22 May 2011 01:26:39 +0000
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p4M1QcF6029131	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)	for <cygwin-patches@cygwin.com>; Sat, 21 May 2011 21:26:38 -0400
Received: from [10.3.113.64] (ovpn-113-64.phx2.redhat.com [10.3.113.64])	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id p4M1Qcad022886	for <cygwin-patches@cygwin.com>; Sat, 21 May 2011 21:26:38 -0400
Message-ID: <4DD8664D.2000407@redhat.com>
Date: Sun, 22 May 2011 01:26:00 -0000
From: Eric Blake <eblake@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc14 Lightning/1.0b3pre Mnenhy/0.8.3 Thunderbird/3.1.10
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: __xpg_strerror_r should not clobber strerror buffer
OpenPGP: url=http://people.redhat.com/eblake/eblake.gpg
Content-Type: multipart/signed; micalg=pgp-sha256; protocol="application/pgp-signature"; boundary="------------enig0939435C794C2CD7791A15C6"
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
X-SW-Source: 2011-q2/txt/msg00147.txt.bz2

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0939435C794C2CD7791A15C6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-length: 2163

POSIX says that no other function in the standard should clobber the
strerror buffer.  Our strerror_r is a GNU extension, so it can get away
with clobbering the buffer (but if we wanted to fix it, we would have to
separate _my_tls.locals.strerror_buf into two different buffers).
perror() is still broken, but that needs to be fixed in newlib.  But
__xpg_strerror_r, which is our POSIX strerror_r variant, has to be fixed
in cygwin.

Meanwhile, glibc just patched strerror this week to print negative
errnum as a negative 32-bit int, rather than as a positive unsigned
long; cygwin should do likewise.

2011-05-21  Eric Blake  <eblake@redhat.com>

	* errno.cc (strerror): Print unknown errno as int.
	(__xpg_strerror_r): Likewise, and don't clobber strerror buffer.

Index: errno.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/errno.cc,v
retrieving revision 1.82
diff -u -p -r1.82 errno.cc
--- errno.cc	18 May 2011 01:25:41 -0000	1.82
+++ errno.cc	22 May 2011 01:22:17 -0000
@@ -382,8 +382,8 @@ strerror (int errnum)
   char *errstr =3D strerror_worker (errnum);
   if (!errstr)
     {
-      __small_sprintf (errstr =3D _my_tls.locals.strerror_buf, "Unknown
error %u",
-		       (unsigned) errnum);
+      __small_sprintf (errstr =3D _my_tls.locals.strerror_buf, "Unknown
error %d",
+                       errnum);
       errno =3D _impure_ptr->_errno =3D EINVAL;
     }
   return errstr;
@@ -409,10 +409,10 @@ __xpg_strerror_r (int errnum, char *buf,
     return ERANGE;
   int result =3D 0;
   char *error =3D strerror_worker (errnum);
+  char tmp[sizeof "Unknown error -2147483648"];
   if (!error)
     {
-      __small_sprintf (error =3D _my_tls.locals.strerror_buf, "Unknown
error %u",
-		       (unsigned) errnum);
+      __small_sprintf (error =3D tmp, "Unknown error %d", errnum);
       result =3D EINVAL;
     }
   if (strlen (error) >=3D n)


--=20
Eric Blake   eblake@redhat.com    +1-801-349-2682
Libvirt virtualization library http://libvirt.org


--------------enig0939435C794C2CD7791A15C6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-length: 619

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iQEcBAEBCAAGBQJN2GZNAAoJEKeha0olJ0NqrbYH/jZOrX43sDM6aZGAi5rP0IcI
3McMUXwwE0PdZoSIYnQ42/M6ipI6XNBy+nClwy0knISApo8yQ/RlsTHMAEbI+IE0
UvlS7boQUAzlgonMaCLZ+fKBK2TglzPY7l/6z25+745fN44TDhvnM6CBmUOlkXkm
fc2qQ40v4vlc5zf012nlXDOLvh4D6mTvFmtjBg0aM07UZQcxhGbUkJ+zurOiF5l1
TKsZ36FS1WrYu9gGe6oiz+f4XLwVEVrkpjtUSOl02oqQdOKcWxWwqqGUs2XVzYO6
nIyXLoo9pSQO1tIY0gHvJDjXDaC/JR3bHmsrvB8wuxCQ3kokZnm7QqFoX02mfMo=
=pV7G
-----END PGP SIGNATURE-----

--------------enig0939435C794C2CD7791A15C6--
