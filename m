Return-Path: <cygwin-patches-return-4788-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20216 invoked by alias); 30 May 2004 04:25:03 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 20207 invoked from network); 30 May 2004 04:25:02 -0000
Message-Id: <3.0.5.32.20040530002148.0081b840@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Sun, 30 May 2004 04:25:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: [Patch] Make add_item smarter
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1085905308==_"
X-SW-Source: 2004-q2/txt/msg00140.txt.bz2

--=====================_1085905308==_
Content-Type: text/plain; charset="us-ascii"
Content-length: 254

2004-05-30  Pierre Humblet <pierre.humblet@ieee.org>

	* path.cc (mount_info::add_item): Make sure native path has drive 
	or UNC form. Call normalize_xxx_path instead of [back]slashify.
	Remove test for double slashes. Reorganize to always debug_print. 
--=====================_1085905308==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="path.cc.diff"
Content-length: 2323

Index: path.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/path.cc,v
retrieving revision 1.313
diff -u -p -b -r1.313 path.cc
--- path.cc	28 May 2004 19:50:06 -0000	1.313
+++ path.cc	30 May 2004 04:06:43 -0000
@@ -2176,41 +2176,40 @@ mount_info::sort ()
 int
 mount_info::add_item (const char *native, const char *posix, unsigned moun=
tflags, int reg_p)
 {
+  char nativetmp[CYG_MAX_PATH];
+  char posixtmp[CYG_MAX_PATH];
+  char *tail;
+  int err[2];
+
   /* Something's wrong if either path is NULL or empty, or if it's
      not a UNC or absolute path. */

-  if ((native =3D=3D NULL) || (*native =3D=3D 0) ||
-      (posix =3D=3D NULL) || (*posix =3D=3D 0) ||
-      !isabspath (native) || !isabspath (posix) ||
+  if (native =3D=3D NULL || *native =3D=3D 0 || !isabspath (native) ||
+      !(is_unc_share (native) || isdrive (native)))
+    err[0] =3D EINVAL;
+  else
+    err[0] =3D normalize_win32_path (native, nativetmp, &tail);
+
+  if (posix =3D=3D NULL || *posix =3D=3D 0 || !isabspath (posix) ||
       is_unc_share (posix) || isdrive (posix))
+    err[1] =3D EINVAL;
+  else
+    err[1] =3D normalize_posix_path (posix, posixtmp, &tail);
+
+  debug_printf ("%s[%s], %s[%s], %p",
+                native, err[0]?"error":nativetmp, posix, err[1]?"error":po=
sixtmp,
+                mountflags);
+
+  if (err[0] || err[1])
     {
-      set_errno (EINVAL);
+      set_errno (err[0]?:err[1]);
       return -1;
     }

   /* Make sure both paths do not end in /. */
-  char nativetmp[CYG_MAX_PATH];
-  char posixtmp[CYG_MAX_PATH];
-
-  backslashify (native, nativetmp, 0);
   nofinalslash (nativetmp, nativetmp);
-
-  slashify (posix, posixtmp, 0);
   nofinalslash (posixtmp, posixtmp);

-  debug_printf ("%s[%s], %s[%s], %p",
-		native, nativetmp, posix, posixtmp, mountflags);
-
-  /* Duplicate /'s in path are an error. */
-  for (char *p =3D posixtmp + 1; *p; ++p)
-    {
-      if (p[-1] =3D=3D '/' && p[0] =3D=3D '/')
-	{
-	  set_errno (EINVAL);
-	  return -1;
-	}
-    }
-
   /* Write over an existing mount item with the same POSIX path if
      it exists and is from the same registry area. */
   int i;

--=====================_1085905308==_--
