Return-Path: <cygwin-patches-return-7162-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2638 invoked by alias); 5 Feb 2011 20:04:53 -0000
Received: (qmail 2628 invoked by uid 22791); 5 Feb 2011 20:04:52 -0000
X-SWARE-Spam-Status: No, hits=-1.3 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,SPF_FAIL,TW_CP
X-Spam-Check-By: sourceware.org
Received: from qmta10.emeryville.ca.mail.comcast.net (HELO qmta10.emeryville.ca.mail.comcast.net) (76.96.30.17)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sat, 05 Feb 2011 20:04:47 +0000
Received: from omta16.emeryville.ca.mail.comcast.net ([76.96.30.72])	by qmta10.emeryville.ca.mail.comcast.net with comcast	id 4KXj1g0011ZMdJ4AAL4lAK; Sat, 05 Feb 2011 20:04:46 +0000
Received: from [192.168.0.5] ([24.10.251.25])	by omta16.emeryville.ca.mail.comcast.net with comcast	id 4L4k1g0080ZdyUg8cL4lZs; Sat, 05 Feb 2011 20:04:45 +0000
Message-ID: <4D4DAD40.3060904@redhat.com>
Date: Sat, 05 Feb 2011 20:04:00 -0000
From: Eric Blake <eblake@redhat.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: provide __xpg_strerror_r
Content-Type: multipart/signed; micalg=pgp-sha256; protocol="application/pgp-signature"; boundary="------------enigEDEBC3B3A7F158434D3908D0"
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
X-SW-Source: 2011-q1/txt/msg00017.txt.bz2

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigEDEBC3B3A7F158434D3908D0
Content-Type: multipart/mixed;
 boundary="------------040001060602070003060905"

This is a multi-part message in MIME format.
--------------040001060602070003060905
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-length: 1148

Our strerror_r is lousy (it doesn't even match glibc's behavior); see my
request to the newlib list.  But even if newlib swaps over to a
POSIX-compliant strerror_r, I argue that for Linux compatibility (not to
mention backwards compatibility with existing programs), we need to
continue to provide strerror_r with the glibc signature (and I will make
sure of that when writing the newlib patch to whatever the consensus is
there).

Meanwhile, gnulib really wants to use the POSIX interface; on glibc
systems, it uses the __xpg_strerror_r interface (undeclared, but that's
what you get with a leading double-underscore interface), when
_POSIX_C_VERSION is high enough and _GNU_SOURCE is not in effect.

Since __xpg_strerror_r is undeclared, we don't have to care about tweaking
newlib's string.h for this patch (gnulib does a link-test probe for its
existence).

2011-02-05  Eric Blake  <eblake@redhat.com>

	* errno.cc (__xpg_strerror_r): New function.
	* cygwin.din: Export it.
	* include/cygwin/version.h (CYGWIN_VERSION_API_MINOR): Bump.

--=20
Eric Blake   eblake@redhat.com    +1-801-349-2682
Libvirt virtualization library http://libvirt.org

--------------040001060602070003060905
Content-Type: text/plain;
 name="cygwin.patch39"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="cygwin.patch39"
Content-length: 2156

diff --git a/winsup/cygwin/cygwin.din b/winsup/cygwin/cygwin.din
index 2e7e647..780179a 100644
--- a/winsup/cygwin/cygwin.din
+++ b/winsup/cygwin/cygwin.din
@@ -1933,6 +1933,7 @@ xdrrec_skiprecord SIGFE
 __xdrrec_getrec SIGFE
 __xdrrec_setnonblock SIGFE
 xdrstdio_create SIGFE
+__xpg_strerror_r SIGFE
 y0 NOSIGFE
 y0f NOSIGFE
 y1 NOSIGFE
diff --git a/winsup/cygwin/errno.cc b/winsup/cygwin/errno.cc
index a9860f4..91c381f 100644
--- a/winsup/cygwin/errno.cc
+++ b/winsup/cygwin/errno.cc
@@ -368,16 +368,23 @@ strerror (int errnum)
   return errstr;
 }

-#if 0
+/* Newlib provides the glibc strerror_r interface, but like Linux, we
+   also provide the POSIX interface.  POSIX leaves a lot of leeway,
+   but recommends that buf always be populated, and that both EINVAL
+   and ERANGE be returned when appropriate.  */
 extern "C" int
-strerror_r (int errnum, char *buf, size_t n)
+__xpg_strerror_r (int errnum, char *buf, size_t n)
 {
   char *errstr =3D strerror_worker (errnum);
+  int result =3D 0;
   if (!errstr)
-    return EINVAL;
+    {
+      __small_sprintf (errstr =3D _my_tls.locals.strerror_buf,
+		       "Unknown error %u", (unsigned) errnum);
+      result =3D EINVAL;
+    }
+  strncpy (buf, errstr, n);
   if (strlen (errstr) >=3D n)
-    return ERANGE;
-  strcpy (buf, errstr);
-  return 0;
+    result =3D ERANGE;
+  return result;
 }
-#endif
diff --git a/winsup/cygwin/include/cygwin/version.h b/winsup/cygwin/include=
/cygwin/version.h
index c757827..7246e8e 100644
--- a/winsup/cygwin/include/cygwin/version.h
+++ b/winsup/cygwin/include/cygwin/version.h
@@ -399,12 +399,13 @@ details. */
       233: Add TIOCGPGRP, TIOCSPGRP.  Export llround, llroundf.
       234: Export program_invocation_name, program_invocation_short_name.
       235: Export madvise.
+      236: Export __xpg_strerror_r.
      */

      /* Note that we forgot to bump the api for ualarm, strtoll, strtoull =
*/

 #define CYGWIN_VERSION_API_MAJOR 0
-#define CYGWIN_VERSION_API_MINOR 235
+#define CYGWIN_VERSION_API_MINOR 236

      /* There is also a compatibity version number associated with the
 	shared memory regions.  It is incremented when incompatible

--------------040001060602070003060905--

--------------enigEDEBC3B3A7F158434D3908D0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-length: 616

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (Cygwin)
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQEcBAEBCAAGBQJNTa1IAAoJEKeha0olJ0NqOy0H/jHfBN0ZTyJIuBPiMHOSu26N
RLWgfNOyYH6xoczhs0Si0yERA8rNbcRx9MUH3aTnHR/kcMPgEs6v9PvZYS3isKEW
//8W+Bhsju5XwkbNYOwK5rhqBEBJi6wizfjBLTjIoSTPk5j2dOcLr3QLAq/p2JGM
osYJiSZ/MYZ+6Hhh3qPosCKEPnfFmyLhbnTWa5ebQiXC0T8Eq7OC8LAa8UCqKY9Y
nW0oNP8AcLA4UiaEwq0Kaj5yHaAVNyxB71ZMnqpNzgpFbx7IvLNHL4+MGQVHAyB/
o7Ub20P1GaSfwvW8FZbIsXV+REv26oBBiL8G4djOc1mo+hz/f0yILekkRxEVou0=
=mxw2
-----END PGP SIGNATURE-----

--------------enigEDEBC3B3A7F158434D3908D0--
