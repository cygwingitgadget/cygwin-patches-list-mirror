Return-Path: <cygwin-patches-return-7040-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7313 invoked by alias); 19 Jul 2010 16:27:30 -0000
Received: (qmail 7301 invoked by uid 22791); 19 Jul 2010 16:27:29 -0000
X-SWARE-Spam-Status: No, hits=-1.0 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,SPF_FAIL,TW_CP,TW_MK
X-Spam-Check-By: sourceware.org
Received: from qmta09.emeryville.ca.mail.comcast.net (HELO qmta09.emeryville.ca.mail.comcast.net) (76.96.30.96)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 19 Jul 2010 16:27:21 +0000
Received: from omta10.emeryville.ca.mail.comcast.net ([76.96.30.28])	by qmta09.emeryville.ca.mail.comcast.net with comcast	id jpXb1e0050cQ2SLA9sTKMn; Mon, 19 Jul 2010 16:27:19 +0000
Received: from [192.168.0.5] ([98.202.142.190])	by omta10.emeryville.ca.mail.comcast.net with comcast	id jsTH1e00646h3c28WsTJLb; Mon, 19 Jul 2010 16:27:19 +0000
Message-ID: <4C447CE5.4040808@redhat.com>
Date: Mon, 19 Jul 2010 16:27:00 -0000
From: Eric Blake <eblake@redhat.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: add mkostemp
Content-Type: multipart/signed; micalg=pgp-sha256; protocol="application/pgp-signature"; boundary="------------enigEBE798C8E14ADFE00F9C9DD2"
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
X-SW-Source: 2010-q3/txt/msg00000.txt.bz2

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigEBE798C8E14ADFE00F9C9DD2
Content-Type: multipart/mixed;
 boundary="------------010406090009000206080105"

This is a multi-part message in MIME format.
--------------010406090009000206080105
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-length: 1177

Sed wants to use the glibc invention of mkostemp as enhanced by gnulib, in
order to control the use of O_TEXT vs. O_BINARY vs. 0 (for native mount)
mode[1].  glibc added this interface for other reasons as well - it is
also useful to specify O_CLOEXEC, O_APPEND, and/or O_SYNC on some
temporary files.  In glibc, the flags argument explicitly excludes
O_ACCMODE bits, since temp files are already specified as O_RDWR, so I
copied that pattern.  (man-pages 3.23 documents mkostemp since glibc 2.7,
but fails to document mkostemps, even though it was added at the same time
as mkstemps in glibc 2.11).

[1] http://lists.gnu.org/archive/html/bug-coreutils/2010-07/msg00114.html

Okay to commit, along with a corresponding patch to doc/new-features.sgml
and a cygwin-specific patch to newlib's stdlib.h?

2010-07-19  Eric Blake  <eblake@redhat.com>

	* mktemp.cc (_gettemp): Add flags argument.  All callers updated.
	(mkostemp, mkostemps): New functions.
	* cygwin.din (mkostemp, mkostemps): Export.
	* posix.sgml: Document them.
	* include/cygwin/version.h: Bump version.

--=20
Eric Blake   eblake@redhat.com    +1-801-349-2682
Libvirt virtualization library http://libvirt.org

--------------010406090009000206080105
Content-Type: text/plain;
 name="cygwin.patch37"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="cygwin.patch37"
Content-length: 3893


 winsup/cygwin/ChangeLog                |    8 ++++++++
 winsup/cygwin/cygwin.din               |    2 ++
 winsup/cygwin/include/cygwin/version.h |    3 ++-
 winsup/cygwin/mktemp.cc                |   28 +++++++++++++++++++++-------
 winsup/cygwin/posix.sgml               |    2 ++
 5 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/winsup/cygwin/ChangeLog b/winsup/cygwin/ChangeLog
index f0ecd19..d9a67d7 100644
--- a/winsup/cygwin/ChangeLog
+++ b/winsup/cygwin/ChangeLog
diff --git a/winsup/cygwin/cygwin.din b/winsup/cygwin/cygwin.din
index fa5c77d..9253d2c 100644
--- a/winsup/cygwin/cygwin.din
+++ b/winsup/cygwin/cygwin.din
@@ -995,6 +995,8 @@ mknod SIGFE
 _mknod =3D mknod SIGFE
 _mknod32 =3D mknod32 SIGFE
 mknodat SIGFE
+mkostemp SIGFE
+mkostemps SIGFE
 mkstemp SIGFE
 _mkstemp =3D mkstemp SIGFE
 mkstemps SIGFE
diff --git a/winsup/cygwin/include/cygwin/version.h b/winsup/cygwin/include=
/cygwin/version.h
index 3a95e51..9924e42 100644
--- a/winsup/cygwin/include/cygwin/version.h
+++ b/winsup/cygwin/include/cygwin/version.h
@@ -388,12 +388,13 @@ details. */
       226: Export __locale_mb_cur_max.
       227: Add pseudo_reloc_start, pseudo_reloc_end, image_base to per_pro=
cess.
       228: CW_STRERROR added.
+      229: Add mkostemp, mkostemps.
      */

      /* Note that we forgot to bump the api for ualarm, strtoll, strtoull =
*/

 #define CYGWIN_VERSION_API_MAJOR 0
-#define CYGWIN_VERSION_API_MINOR 228
+#define CYGWIN_VERSION_API_MINOR 229

      /* There is also a compatibity version number associated with the
 	shared memory regions.  It is incremented when incompatible
diff --git a/winsup/cygwin/mktemp.cc b/winsup/cygwin/mktemp.cc
index b8a1381..7770c3b 100644
--- a/winsup/cygwin/mktemp.cc
+++ b/winsup/cygwin/mktemp.cc
@@ -10,7 +10,7 @@ See the copyright at the bottom of this file. */
 #include <sys/stat.h>
 #include <unistd.h>

-static int _gettemp(char *, int *, int, size_t);
+static int _gettemp(char *, int *, int, size_t, int);
 static uint32_t arc4random ();

 static const char padchar[] =3D
@@ -20,30 +20,44 @@ extern "C" int
 mkstemp(char *path)
 {
   int fd;
-  return _gettemp(path, &fd, 0, 0) ? fd : -1;
+  return _gettemp(path, &fd, 0, 0, O_BINARY) ? fd : -1;
 }

 extern "C" char *
 mkdtemp(char *path)
 {
-  return _gettemp(path, NULL, 1, 0) ? path : NULL;
+  return _gettemp(path, NULL, 1, 0, 0) ? path : NULL;
 }

 extern "C" int
 mkstemps(char *path, int len)
 {
   int fd;
-  return _gettemp(path, &fd, 0, len) ? fd : -1;
+  return _gettemp(path, &fd, 0, len, O_BINARY) ? fd : -1;
+}
+
+extern "C" int
+mkostemp(char *path, int flags)
+{
+  int fd;
+  return _gettemp(path, &fd, 0, 0, flags & ~O_ACCMODE) ? fd : -1;
+}
+
+extern "C" int
+mkostemps(char *path, int len, int flags)
+{
+  int fd;
+  return _gettemp(path, &fd, 0, len, flags & ~O_ACCMODE) ? fd : -1;
 }

 extern "C" char *
 mktemp(char *path)
 {
-  return _gettemp(path, NULL, 0, 0) ? path : (char *) NULL;
+  return _gettemp(path, NULL, 0, 0, 0) ? path : (char *) NULL;
 }

 static int
-_gettemp(char *path, int *doopen, int domkdir, size_t suffixlen)
+_gettemp(char *path, int *doopen, int domkdir, size_t suffixlen, int flags)
 {
   char *start, *trv, *suffp;
   char *pad;
@@ -105,7 +119,7 @@ _gettemp(char *path, int *doopen, int domkdir, size_t s=
uffixlen)
     {
       if (doopen)
 	{
-	  if ((*doopen =3D open (path, O_CREAT | O_EXCL | O_RDWR | O_BINARY,
+	  if ((*doopen =3D open (path, O_CREAT | O_EXCL | O_RDWR | flags,
 			       S_IRUSR | S_IWUSR)) >=3D 0)
 	    return 1;
 	  if (errno !=3D EEXIST)
diff --git a/winsup/cygwin/posix.sgml b/winsup/cygwin/posix.sgml
index 6a3bc22..fdd7589 100644
--- a/winsup/cygwin/posix.sgml
+++ b/winsup/cygwin/posix.sgml
@@ -1043,6 +1043,8 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008).</para>
     lsetxattr
     memmem
     mempcpy
+    mkostemp
+    mkostemps
     pipe2
     pow10
     pow10f
--=20
1.7.1


--------------010406090009000206080105--

--------------enigEBE798C8E14ADFE00F9C9DD2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-length: 616

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (Cygwin)
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQEcBAEBCAAGBQJMRHzrAAoJEKeha0olJ0NqhqYH/jyqXrhHhwzFTJUZQFok/ssy
LN+Uv4gF2w789lTbLu46w5CT1q5TaUMwcbZqfaPCr0/JNbrdSG1K502NGW6maUqT
f6Yxjpu1C70fy1MU14Km3ReI/9GzBQW0hXfdSDSJL9CHHPIkm4cFqBRf4ljvIKfJ
933SeFscvU78odVU5akcECRiMAzwfPUnLihs2l6qLBTLtp3nxC3gX2P+c3Pog/35
ckFyHhUc80KZCKw0+25TyDXyjf5TCUHDV8i5clqQzgF6q2DCxsGAiGlzeq0TeEx3
WY34+R6wFdQMYh66aeWdadrDKu70FPCu0SzHlNMVA5L5JBMKAc7vB1V3d1xfE4A=
=SV+8
-----END PGP SIGNATURE-----

--------------enigEBE798C8E14ADFE00F9C9DD2--
