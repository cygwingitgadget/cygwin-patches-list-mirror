Return-Path: <cygwin-patches-return-1951-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 5906 invoked by alias); 7 Mar 2002 00:37:13 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 5863 invoked from network); 7 Mar 2002 00:37:12 -0000
Message-ID: <012301c1c570$8af537e0$0100a8c0@advent02>
From: "Chris January" <chris@atomice.net>
To: <cygwin-patches@cygwin.com>
Subject: Patch for cd .../. bug
Date: Wed, 06 Mar 2002 16:44:00 -0000
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0120_01C1C570.89CE4410"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q1/txt/msg00308.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_0120_01C1C570.89CE4410
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-length: 191

This patch fixes the bug that allows cd .../. to succeed.

2002-03-07  Christopher January <chris@atomice.net>

 * path.cc (chdir): Modify check for >2 dots to work on all path
 components.


------=_NextPart_000_0120_01C1C570.89CE4410
Content-Type: application/octet-stream;
	name="dots.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="dots.patch"
Content-length: 1645

Index: path.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/path.cc,v=0A=
retrieving revision 1.198=0A=
diff -u -3 -p -u -p -a -r1.198 path.cc=0A=
--- path.cc	2002/02/22 19:33:41	1.198=0A=
+++ path.cc	2002/03/07 00:35:35=0A=
@@ -3204,21 +3236,24 @@ chdir (const char *in_dir)=0A=
     }=0A=
=20=0A=
=20=0A=
-  /* Look for trailing path component consisting entirely of dots.  This=
=0A=
+  /* Look for path component consisting entirely of dots.  This=0A=
      is needed only in case of chdir since Windows simply ignores count=0A=
      of dots > 2 here instead of returning an error code.  Counts of dots=
=0A=
      <=3D 2 are already eliminated by normalize_posix_path. */=0A=
-  const char *p =3D strrchr (dir, '/');=0A=
-  if (!p)=0A=
-    p =3D dir;=0A=
-  else=0A=
-    p++;=0A=
-=0A=
-  size_t len =3D strlen (p);=0A=
-  if (len > 2 && strspn (p, ".") =3D=3D len)=0A=
+  const char *p, *last_slash =3D dir, *end =3D dir + strlen (dir);=0A=
+  while (last_slash < end)=0A=
     {=0A=
-      set_errno (ENOENT);=0A=
-      return -1;=0A=
+      p =3D strchr (last_slash, '/');=0A=
+      if (!p)=0A=
+        p =3D end;=0A=
+=0A=
+      size_t len =3D p - last_slash;=0A=
+      if (len > 2 && strspn (last_slash, ".") =3D=3D len)=0A=
+        {=0A=
+          set_errno (ENOENT);=0A=
+          return -1;=0A=
+        }=0A=
+      last_slash =3D p + 1;=0A=
     }=0A=
=20=0A=
   const char *native_dir =3D path.get_win32 ();=0A=

------=_NextPart_000_0120_01C1C570.89CE4410
Content-Type: application/octet-stream;
	name="ChangeLog"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ChangeLog"
Content-length: 131

2002-03-07  Christopher January <chris@atomice.net>

	* path.cc (chdir): Modify check for >2 dots to work on all path
	components.

------=_NextPart_000_0120_01C1C570.89CE4410--
