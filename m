Return-Path: <cygwin-patches-return-7394-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21720 invoked by alias); 23 May 2011 23:28:54 -0000
Received: (qmail 21697 invoked by uid 22791); 23 May 2011 23:28:53 -0000
X-SWARE-Spam-Status: No, hits=-6.7 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,SPF_HELO_PASS,TW_CP,T_RP_MATCHES_RCVD
X-Spam-Check-By: sourceware.org
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 23 May 2011 23:28:38 +0000
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p4NNSbRx004172	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)	for <cygwin-patches@cygwin.com>; Mon, 23 May 2011 19:28:37 -0400
Received: from [10.3.113.142] (ovpn-113-142.phx2.redhat.com [10.3.113.142])	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id p4NNSbsx003225	for <cygwin-patches@cygwin.com>; Mon, 23 May 2011 19:28:37 -0400
Message-ID: <4DDAEDA4.9030005@redhat.com>
Date: Mon, 23 May 2011 23:28:00 -0000
From: Eric Blake <eblake@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc14 Lightning/1.0b3pre Mnenhy/0.8.3 Thunderbird/3.1.10
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: fix perror POSIX compliance
OpenPGP: url=http://people.redhat.com/eblake/eblake.gpg
Content-Type: multipart/signed; micalg=pgp-sha256; protocol="application/pgp-signature"; boundary="------------enigB5DE198DB7ED5ADA35D26E8F"
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
X-SW-Source: 2011-q2/txt/msg00160.txt.bz2

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB5DE198DB7ED5ADA35D26E8F
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-length: 4168

This depends on the newlib patch:
http://sourceware.org/ml/newlib/2011/msg00215.html

In fact, if that patch goes in, then this one is required to avoid a
link failure; this one can probably go in first but makes no difference
to perror without the newlib patch.

 winsup/cygwin/ChangeLog    |    6 +++
 winsup/cygwin/cygtls.h     |    1 +
 winsup/cygwin/errno.cc     |   43 ++++++++++++++++-------
 winsup/cygwin/tlsoffsets.h |   82
++++++++++++++++++++++----------------------
 4 files changed, 78 insertions(+), 54 deletions(-)

2011-05-23  Eric Blake  <eblake@redhat.com>

	* cygtls.h (strerror_r_buf): New buffer.
	* errno.cc (strerror): Move guts...
	(_strerror_r): ...to new function demanded by newlib.
	(strerror_r): Don't clobber strerror buffer.
	(_user_strerror): Drop unused declaration.
	* tlsoffsets.h: Regenerate.

diff --git a/winsup/cygwin/cygtls.h b/winsup/cygwin/cygtls.h
index 6359e7c..a1642b1 100644
--- a/winsup/cygwin/cygtls.h
+++ b/winsup/cygwin/cygtls.h
@@ -110,6 +110,7 @@ struct _local_storage

   /* strerror errno.cc */
   char strerror_buf[sizeof ("Unknown error -2147483648")];
+  char strerror_r_buf[sizeof ("Unknown error -2147483648")];

   /* times.cc */
   char timezone_buf[20];
diff --git a/winsup/cygwin/errno.cc b/winsup/cygwin/errno.cc
index aa311b7..f3b925e 100644
--- a/winsup/cygwin/errno.cc
+++ b/winsup/cygwin/errno.cc
@@ -360,8 +360,6 @@ seterrno (const char *file, int line)
   seterrno_from_win_error (file, line, GetLastError ());
 }

-extern char *_user_strerror _PARAMS ((int));
-
 static char *
 strerror_worker (int errnum)
 {
@@ -373,22 +371,38 @@ strerror_worker (int errnum)
   return res;
 }

-/* strerror: convert from errno values to error strings.  Newlib's
-   strerror_r returns "" for unknown values, so we override it to
-   provide a nicer thread-safe result string and set errno.  */
+/* Newlib requires this override for perror and friends to avoid
+   clobbering strerror() buffer, without having to differentiate
+   between strerror_r signatures.  This function is intentionally not
+   exported, so that only newlib can use it.  */
 extern "C" char *
-strerror (int errnum)
+_strerror_r (struct _reent *, int errnum, int internal, int *errptr)
 {
   char *errstr =3D strerror_worker (errnum);
   if (!errstr)
     {
-      __small_sprintf (errstr =3D _my_tls.locals.strerror_buf, "Unknown
error %d",
-                       errnum);
-      errno =3D _impure_ptr->_errno =3D EINVAL;
+      errstr =3D internal ? _my_tls.locals.strerror_r_buf
+        : _my_tls.locals.strerror_buf;
+      __small_sprintf (errstr, "Unknown error %d", errnum);
+      if (errptr)
+        *errptr =3D EINVAL;
     }
   return errstr;
 }

+/* strerror: convert from errno values to error strings.  Newlib's
+   strerror_r returns "" for unknown values, so we override it to
+   provide a nicer thread-safe result string and set errno.  */
+extern "C" char *
+strerror (int errnum)
+{
+  int error =3D 0;
+  char *result =3D _strerror_r (NULL, errnum, 0, &error);
+  if (error)
+    set_errno (error);
+  return result;
+}
+
 /* Newlib's <string.h> provides declarations for two strerror_r
    variants, according to preprocessor feature macros.  However, it
    returns "" instead of "Unknown error ...", so we override both
@@ -396,10 +410,13 @@ strerror (int errnum)
 extern "C" char *
 strerror_r (int errnum, char *buf, size_t n)
 {
-  char *error =3D strerror (errnum);
-  if (strlen (error) >=3D n)
-    return error;
-  return strcpy (buf, error);
+  int error =3D 0;
+  char *errstr =3D _strerror_r (NULL, errnum, 1, &error);
+  if (error)
+    set_errno (error);
+  if (strlen (errstr) >=3D n)
+    return errstr;
+  return strcpy (buf, errstr);
 }

 extern "C" int
diff --git a/winsup/cygwin/tlsoffsets.h b/winsup/cygwin/tlsoffsets.h
index 4e459df..3ef7963 100644
--- a/winsup/cygwin/tlsoffsets.h
+++ b/winsup/cygwin/tlsoffsets.h
@@ -1,6 +1,6 @@
 //;# autogenerated:  Do not edit.

-//; $tls::sizeof__cygtls =3D 3984;
+//; $tls::sizeof__cygtls =3D 4012;
... // rest of generated file patch elided

--=20
Eric Blake   eblake@redhat.com    +1-801-349-2682
Libvirt virtualization library http://libvirt.org


--------------enigB5DE198DB7ED5ADA35D26E8F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-length: 619

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iQEcBAEBCAAGBQJN2u2kAAoJEKeha0olJ0Nq61YH/i5bd9z1tXCuFLGGv6072Ws4
N1FPB3GOWhqQNAFXl1R4KpCpV7VdAMIUj0pYOmvPoryCUSR3KVHB76DLetLA6Xb7
OC9UookgKBZ64tIGUtKJHT6m/idxc98Zj7x5mAnO409iiy4oB0mU5Xqp6baME/cA
IEFCQw5EMoOIHxlQ74KDn3hPacgyPbqX6ZmJzSSxtYh8ktInlD+pl88JrBuUKG3Z
Dkch0vICk2+HZ1vIsECcT+04YGQoqytPUYorM9KwGTCTpGPPiHWWrw4SsHTriIz4
6WFR1V/fnnH8axOJATxbhXoNmAc0wYG6Df0t1PiQzlypUiBxi7dNOwhDWb8gX7M=
=Vjhf
-----END PGP SIGNATURE-----

--------------enigB5DE198DB7ED5ADA35D26E8F--
