Return-Path: <cygwin-patches-return-4666-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23036 invoked by alias); 11 Apr 2004 03:40:07 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 22928 invoked from network); 11 Apr 2004 03:39:54 -0000
Message-Id: <3.0.5.32.20040410233707.00846910@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Sun, 11 Apr 2004 03:40:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: [Patch]: Last path.cc
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1081669027==_"
X-SW-Source: 2004-q2/txt/msg00018.txt.bz2

--=====================_1081669027==_
Content-Type: text/plain; charset="us-ascii"
Content-length: 1004

This should take care of the issues I listed yesterday evening.

I simply don't understand the logic in normalize_win32_path
well enough to touch it intelligently. 
So I removed the final . in the dumbest way possible

For example on line 946
  else if (strchr (src, ':') == NULL && *src != '/')
(why only '/' and not '\\')?
There is a "dst_start" and a "dst_root_start" that appear
to be the same. Perhaps one of them should prevent .. from 
going back to the drive or the unc prefix.

The code in normalize_posix_path looks much cleaner. It could 
perhaps be used here as well (reiterating a FIXME to that effect).

The other changes are minor.

Pierre

2004-04-11  Pierre Humblet <pierre.humblet@ieee.org>

	* path.cc (normalize_win32_path): Detect components with only dots.
	Remove a final . if it follows '\\'.
	(slash_unc_prefix_p): Remove redundant tests.
	(mount_info::conv_to_win32_path): Only backslashify the path
	when no mount is found.
	(chdir): Do not look for components with only dots.

--=====================_1081669027==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="path.cc.diff"
Content-length: 3819

Index: path.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/path.cc,v
retrieving revision 1.297
diff -u -p -r1.297 path.cc
--- path.cc	10 Apr 2004 19:24:55 -0000	1.297
+++ path.cc	10 Apr 2004 23:06:02 -0000
@@ -776,7 +776,7 @@ path_conv::check (const char *src, unsig
 	}

      /* Copy the symlink contents to the end of tmp_buf.
-	Convert slashes.  FIXME? I think it's fine / Pierre */
+	Convert slashes. */
       for (char *p =3D sym.contents; *p; p++)
 	*headptr++ =3D *p =3D=3D '\\' ? '/' : *p;
       *headptr =3D '\0';
@@ -981,18 +981,26 @@ normalize_win32_path (const char *src, c
       /* Backup if "..".  */
       else if (src[0] =3D=3D '.' && src[1] =3D=3D '.'
 	       /* dst must be greater than dst_start */
-	       && dst[-1] =3D=3D '\\'
-	       && (isdirsep (src[2]) || src[2] =3D=3D 0))
-	{
-	  /* Back up over /, but not if it's the first one.  */
-	  if (dst > dst_root_start + 1)
-	    dst--;
-	  /* Now back up to the next /.  */
-	  while (dst > dst_root_start + 1 && dst[-1] !=3D '\\' && dst[-2] !=3D ':=
')
-	    dst--;
-	  src +=3D 2;
-	  if (isdirsep (*src))
-	    src++;
+	       && dst[-1] =3D=3D '\\')
+        {
+	  if (isdirsep (src[2]) || src[2] =3D=3D 0)
+	    {
+	      /* Back up over /, but not if it's the first one.  */
+	      if (dst > dst_root_start + 1)
+		dst--;
+	      /* Now back up to the next /.  */
+	      while (dst > dst_root_start + 1 && dst[-1] !=3D '\\' && dst[-2] !=
=3D ':')
+		dst--;
+	      src +=3D 2;
+	      if (isdirsep (*src))
+		src++;
+	    }
+	  else
+	    {
+	      int n =3D strspn (src, ".");
+	      if (!src[n] || isdirsep (src[n])) /* just dots... */
+		return ENOENT;
+	    }
 	}
       /* Otherwise, add char to result.  */
       else
@@ -1006,6 +1014,8 @@ normalize_win32_path (const char *src, c
       if ((dst - dst_start) >=3D CYG_MAX_PATH)
 	return ENAMETOOLONG;
     }
+  if (dst > dst_start + 1 && dst[-1] =3D=3D '.' && dst[-2] =3D=3D '\\')
+    dst--;
   *dst =3D 0;
   if (tail)
     *tail =3D dst;
@@ -1082,13 +1092,11 @@ int __stdcall
 slash_unc_prefix_p (const char *path)
 {
   char *p =3D NULL;
-  int ret =3D (isdirsep (path[0])
-	     && isdirsep (path[1])
-	     && (isalnum (path[2]) || path[2] =3D=3D '.')
-	     && ((p =3D strpbrk (path + 3, "\\/")) !=3D NULL));
-  if (!ret || p =3D=3D NULL)
-    return ret;
-  return ret && isalnum (p[1]);
+  return (isdirsep (path[0])
+	  && isdirsep (path[1])
+	  && (isalnum (path[2]) || path[2] =3D=3D '.')
+	  && ((p =3D strpbrk (path + 3, "\\/")) !=3D NULL)
+	  && isalnum (p[1]));
 }

 /* conv_path_list: Convert a list of path names to/from Win32/POSIX. */
@@ -1492,11 +1500,7 @@ mount_info::conv_to_win32_path (const ch
       chroot_ok =3D true;
     }
   else
-    {
-      if (strchr (src_path, ':') =3D=3D NULL && !slash_unc_prefix_p (src_p=
ath))
-	set_flags (flags, PATH_BINARY);
-      backslashify (src_path, dst, 0);
-    }
+    backslashify (src_path, dst, 0);

  out:
   MALLOC_CHECK;
@@ -3292,24 +3296,6 @@ chdir (const char *in_dir)
     {
       set_errno (path.error);
       syscall_printf ("-1 =3D chdir (%s)", dir);
-      return -1;
-    }
-
-
-  /* Look for trailing path component consisting entirely of dots.  This
-     is needed only in case of chdir since Windows simply ignores count
-     of dots > 2 here instead of returning an error code.  Counts of dots
-     <=3D 2 are already eliminated by normalize_posix_path. */
-  const char *p =3D strrchr (dir, '/');
-  if (!p)
-    p =3D dir;
-  else
-    p++;
-
-  size_t len =3D strlen (p);
-  if (len > 2 && strspn (p, ".") =3D=3D len)
-    {
-      set_errno (ENOENT);
       return -1;
     }


--=====================_1081669027==_--
