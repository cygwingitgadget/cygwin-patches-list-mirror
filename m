Return-Path: <cygwin-patches-return-4796-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24942 invoked by alias); 30 May 2004 14:41:31 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 24927 invoked from network); 30 May 2004 14:41:29 -0000
Message-Id: <3.0.5.32.20040530103810.007d3910@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Sun, 30 May 2004 14:41:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: Re: [Patch] Make add_item smarter
In-Reply-To: <3.0.5.32.20040530094135.007cbc80@incoming.verizon.net>
References: <3.0.5.32.20040530010121.007cd970@incoming.verizon.net>
 <20040530043431.GA12896@coe.bosbc.com>
 <3.0.5.32.20040530002148.0081b840@incoming.verizon.net>
 <3.0.5.32.20040530002148.0081b840@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1085942290==_"
X-SW-Source: 2004-q2/txt/msg00148.txt.bz2

--=====================_1085942290==_
Content-Type: text/plain; charset="us-ascii"
Content-length: 414

At 09:41 AM 5/30/2004 -0400, Pierre A. Humblet wrote:
>Here it is again, after a cup of coffee and some extra cleanup.
>

Oops, use this one instead.

Pierre

2004-05-30  Pierre Humblet <pierre.humblet@ieee.org>

	* path.cc (mount_info::add_item): Make sure native path has drive 
	or UNC form. Call normalize_xxx_path instead of [back]slashify.
	Remove test for double slashes. Reorganize to always debug_print. 

--=====================_1085942290==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="path.cc.diff2"
Content-length: 2617

Index: path.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/path.cc,v
retrieving revision 1.313
diff -u -p -b -r1.313 path.cc
--- path.cc	28 May 2004 19:50:06 -0000	1.313
+++ path.cc	30 May 2004 14:30:10 -0000
@@ -2176,40 +2176,41 @@ mount_info::sort ()
 int
 mount_info::add_item (const char *native, const char *posix, unsigned moun=
tflags, int reg_p)
 {
-  /* Something's wrong if either path is NULL or empty, or if it's
-     not a UNC or absolute path. */
-
-  if ((native =3D=3D NULL) || (*native =3D=3D 0) ||
-      (posix =3D=3D NULL) || (*posix =3D=3D 0) ||
-      !isabspath (native) || !isabspath (posix) ||
-      is_unc_share (posix) || isdrive (posix))
-    {
-      set_errno (EINVAL);
-      return -1;
-    }
-
-  /* Make sure both paths do not end in /. */
   char nativetmp[CYG_MAX_PATH];
   char posixtmp[CYG_MAX_PATH];
+  char *nativetail, *posixtail, error[] =3D "error";
+  int nativeerr, posixerr;

-  backslashify (native, nativetmp, 0);
-  nofinalslash (nativetmp, nativetmp);
+  /* Something's wrong if either path is NULL or empty, or if it's
+     not a UNC or absolute path. */
+
+  if (native =3D=3D NULL || !isabspath (native) ||
+      !(is_unc_share (native) || isdrive (native)))
+    nativeerr =3D EINVAL;
+  else
+    nativeerr =3D normalize_win32_path (native, nativetmp, &nativetail);

-  slashify (posix, posixtmp, 0);
-  nofinalslash (posixtmp, posixtmp);
+  if (posix =3D=3D NULL || !isabspath (posix) ||
+      is_unc_share (posix) || isdrive (posix))
+    posixerr =3D EINVAL;
+  else
+    posixerr =3D normalize_posix_path (posix, posixtmp, &posixtail);

   debug_printf ("%s[%s], %s[%s], %p",
-		native, nativetmp, posix, posixtmp, mountflags);
+                native, nativeerr?error:nativetmp,
+		posix, posixerr?error:posixtmp, mountflags);

-  /* Duplicate /'s in path are an error. */
-  for (char *p =3D posixtmp + 1; *p; ++p)
+  if (nativeerr || posixerr)
     {
-      if (p[-1] =3D=3D '/' && p[0] =3D=3D '/')
-	{
-	  set_errno (EINVAL);
+      set_errno (nativeerr?:posixerr);
 	  return -1;
 	}
-    }
+
+  /* Make sure both paths do not end in /. */
+  if (nativetail > nativetmp + 1 && nativetail[-1] =3D=3D '\\')
+    nativetail[-1] =3D '\0';
+  if (posixtail > posixtmp + 1 && posixtail[-1] =3D=3D '/')
+    posixtail[-1] =3D '\0';

   /* Write over an existing mount item with the same POSIX path if
      it exists and is from the same registry area. */

--=====================_1085942290==_--
