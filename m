Return-Path: <cygwin-patches-return-4930-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9644 invoked by alias); 5 Sep 2004 12:03:43 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 9628 invoked from network); 5 Sep 2004 12:03:40 -0000
Message-Id: <3.0.5.32.20040905075922.0081f420@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Sun, 05 Sep 2004 12:03:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: Re: [Patch] mapping root directory to SystemDrive /
  CurrentDrive
In-Reply-To: <20040804022029.GA13189@trixie.casa.cgf.cx>
References: <3.0.5.32.20040803202352.0080e320@incoming.verizon.net>
 <200408021452.34000.gernot.hillier@siemens.com>
 <3.0.5.32.20040803202352.0080e320@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1094399962==_"
X-SW-Source: 2004-q3/txt/msg00082.txt.bz2

--=====================_1094399962==_
Content-Type: text/plain; charset="us-ascii"
Content-length: 667

At 10:20 PM 8/3/2004 -0400, Christopher Faylor wrote:
>On Tue, Aug 03, 2004 at 08:23:52PM -0400, Pierre A. Humblet wrote:
>>Here is a patch.
>
>Thanks much but unless you are really really sure that this patch will
>introduce no regressions, I'd like to hold off applying this patch until
>after 1.5.11.

Now is the time.

Pierre

2004-09-05  Pierre Humblet <pierre.humblet@ieee.org>

	* cygheap.h (cwdstuff::drive_length): New member.
	(cwdstuff::get_drive): New method.
	* path.cc (normalize_win32_path): Simplify by using cwdstuff::get_drive.
	(mount_info::conv_to_win32_path): Use cwdstuff::get_drive as default for /.
	(cwdstuff::set): Initialize drive_length.


--=====================_1094399962==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="root2.diff"
Content-length: 3092

Index: cygheap.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/cygheap.h,v
retrieving revision 1.85
diff -u -p -r1.85 cygheap.h
--- cygheap.h	28 May 2004 19:50:05 -0000	1.85
+++ cygheap.h	5 Sep 2004 11:56:28 -0000
@@ -216,9 +216,16 @@ struct cwdstuff
   char *posix;
   char *win32;
   DWORD hash;
+  DWORD drive_length;
   muto *cwd_lock;
   char *get (char *, int =3D 1, int =3D 0, unsigned =3D CYG_MAX_PATH);
   DWORD get_hash ();
+  DWORD get_drive (char * dst)
+  {
+    get_initial ();
+    memcpy (dst, win32, drive_length);
+    return drive_length;
+  }
   void init ();
   void fixup_after_exec (char *, char *, DWORD);
   bool get_initial ();
Index: path.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/path.cc,v
retrieving revision 1.317
diff -u -p -r1.317 path.cc
--- path.cc	17 Jun 2004 13:34:24 -0000	1.317
+++ path.cc	5 Sep 2004 11:56:34 -0000
@@ -980,27 +980,15 @@ normalize_win32_path (const char *src, c
     }
   else if (strchr (src, ':') =3D=3D NULL && *src !=3D '/')
     {
-      if (!cygheap->cwd.get (dst, 0))
-	return get_errno ();
       if (beg_src_slash)
-	{
-	  if (dst[1] =3D=3D ':')
-	    dst[2] =3D '\0';
-	  else if (is_unc_share (dst))
-	    {
-	      char *p =3D strpbrk (dst + 2, "\\/");
-	      if (p && (p =3D strpbrk (p + 1, "\\/")))
-		  *p =3D '\0';
-	    }
-	}
-      if (strlen (dst) + 1 + strlen (src) >=3D CYG_MAX_PATH)
-	{
-	  debug_printf ("ENAMETOOLONG =3D normalize_win32_path (%s)", src);
-	  return ENAMETOOLONG;
-	}
-      dst +=3D strlen (dst);
-      if (!beg_src_slash)
-	*dst++ =3D '\\';
+        dst +=3D cygheap->cwd.get_drive (dst);
+      else if (!cygheap->cwd.get (dst, 0))
+	return get_errno ();
+      else
+        {
+          dst +=3D strlen (dst);
+          *dst++ =3D '\\';
+        }
     }

   while (*src)
@@ -1520,9 +1508,13 @@ mount_info::conv_to_win32_path (const ch
 	return err;
       chroot_ok =3D true;
     }
-  else
-    backslashify (src_path, dst, 0);
-
+  else
+    {
+      int offset =3D 0;
+      if (src_path[1] !=3D '/' && src_path[1] !=3D ':')
+        offset =3D cygheap->cwd.get_drive (dst);
+      backslashify (src_path, dst + offset, 0);
+    }
  out:
   MALLOC_CHECK;
   if (chroot_ok || cygheap->root.ischroot_native (dst))
@@ -3705,6 +3697,17 @@ cwdstuff::set (const char *win32_cwd, co
       win32 =3D (char *) crealloc (win32, strlen (win32_cwd) + 1);
       strcpy (win32, win32_cwd);
     }
+  if (win32[1] =3D=3D ':')
+    drive_length =3D 2;
+  else if (win32[1] =3D=3D '\\')
+    {
+      char * ptr =3D strechr (win32 + 2, '\\');
+      if (*ptr)
+	ptr =3D strechr (ptr + 1, '\\');
+      drive_length =3D ptr - win32;
+    }
+  else
+    drive_length =3D 0;

   if (!posix_cwd)
     {

--=====================_1094399962==_--
