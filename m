Return-Path: <cygwin-patches-return-4711-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15351 invoked by alias); 6 May 2004 04:01:56 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 15342 invoked from network); 6 May 2004 04:01:55 -0000
Message-Id: <3.0.5.32.20040505235853.00806100@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Thu, 06 May 2004 04:01:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: Re: [Patch]: chdir
In-Reply-To: <4098F250.29E4291@phumblet.no-ip.org>
References: <20040505002003.GA8846@coe.bosbc.com>
 <3.0.5.32.20040504200359.007fcec0@incoming.verizon.net>
 <20040505002003.GA8846@coe.bosbc.com>
 <3.0.5.32.20040505004236.007ff280@incoming.verizon.net>
 <20040505095134.GA6206@cygbert.vinschen.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1083830333==_"
X-SW-Source: 2004-q2/txt/msg00063.txt.bz2

--=====================_1083830333==_
Content-Type: text/plain; charset="us-ascii"
Content-length: 678

After mulling over it, I simplified chdir even more
in the interest of uniformity (it matters for unc paths).
Now cwd.set is always called with only the native_dir.

That means that cwd.set always attempts to build the
Posix wd through the mount table.
Up to now that was only the case when a symlink was
involved in the translation, or there was a ":" or a "\" 
in the directory name, or check_case was not relaxed.

Pierre

2004-05-06  Pierre Humblet <pierre.humblet@ieee.org>

	* path.cc (chdir): Do not check for trailing spaces.
	Do not set native_dir to c:\ for virtual devices.
	Pass only native_dir to cwd.set.
	(cwdstuff::set): Assume posix_cwd is already normalized.


--=====================_1083830333==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="path.diff"
Content-length: 5653

Index: path.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/path.cc,v
retrieving revision 1.308
diff -u -p -r1.308 path.cc
--- path.cc	4 May 2004 15:14:48 -0000	1.308
+++ path.cc	5 May 2004 23:36:33 -0000
@@ -286,10 +286,6 @@ normalize_posix_path (const char *src, c
     }

 done:
-  /* Remove trailing dots and spaces which are ignored by Win32 functions =
but
-     not by native NT functions. */
-  while (dst[-1] =3D=3D '.' || dst[-1] =3D=3D ' ')
-    --dst;
   *dst =3D '\0';
   *tail =3D dst;

@@ -555,9 +551,19 @@ path_conv::check (const char *src, unsig
       if (tail > path_copy + 1 && isslash (*(tail - 1)))
 	{
 	  need_directory =3D 1;
-	  *--tail =3D '\0';
+	  tail--;
+	}
+      /* Remove trailing dots and spaces which are ignored by Win32 functi=
ons but
+	 not by native NT functions. */
+      while (tail[-1] =3D=3D '.' || tail[-1] =3D=3D ' ')
+	tail--;
+      if (tail[-1] =3D=3D '/')
+        {
+	  error =3D ENOENT;
+          return;
 	}
       path_end =3D tail;
+      *tail =3D '\0';

       /* Scan path_copy from right to left looking either for a symlink
 	 or an actual existing file.  If an existing file is found, just
@@ -3285,80 +3291,44 @@ chdir (const char *in_dir)

   syscall_printf ("dir '%s'", in_dir);

-  char *s;
-  char dir[strlen (in_dir) + 1];
-  strcpy (dir, in_dir);
-  /* Incredibly. Windows allows you to specify a path with trailing
-     whitespace to SetCurrentDirectory.  This doesn't work too well
-     with other parts of the API, though, apparently.  So nuke trailing
-     white space. */
-  for (s =3D strchr (dir, '\0'); --s >=3D dir && isspace ((unsigned int) (=
*s & 0xff)); )
-    *s =3D '\0';
-
-  if (!*s)
-    {
-      set_errno (ENOENT);
-      return -1;
-    }
-
   /* Convert path.  First argument ensures that we don't check for NULL/em=
pty/invalid
      again. */
-  path_conv path (PC_NONULLEMPTY, dir, PC_FULL | PC_SYM_FOLLOW);
+  path_conv path (PC_NONULLEMPTY, in_dir, PC_FULL | PC_SYM_FOLLOW);
   if (path.error)
     {
       set_errno (path.error);
-      syscall_printf ("-1 =3D chdir (%s)", dir);
+      syscall_printf ("-1 =3D chdir (%s)", in_dir);
       return -1;
     }

+  int res =3D -1;
   const char *native_dir =3D path;
-
-  /* Check to see if path translates to something like C:.
-     If it does, append a \ to the native directory specification to
-     defeat the Windows 95 (i.e. MS-DOS) tendency of returning to
-     the last directory visited on the given drive. */
-  if (isdrive (native_dir) && !native_dir[2])
-    {
-      path.get_win32 ()[2] =3D '\\';
-      path.get_win32 ()[3] =3D '\0';
-    }
-  int res;
   int devn =3D path.get_devn ();
   if (!isvirtual_dev (devn))
-    res =3D SetCurrentDirectory (native_dir) ? 0 : -1;
-  else if (!path.exists ())
     {
-      set_errno (ENOENT);
-      return -1;
+      /* Check to see if path translates to something like C:.
+	 If it does, append a \ to the native directory specification to
+	 defeat the Windows 95 (i.e. MS-DOS) tendency of returning to
+	 the last directory visited on the given drive. */
+      if (isdrive (native_dir) && !native_dir[2])
+        {
+	  path.get_win32 ()[2] =3D '\\';
+	  path.get_win32 ()[3] =3D '\0';
+	}
+      if (SetCurrentDirectory (native_dir))
+        res =3D 0;
+      else
+        __seterrno ();
     }
+  else if (!path.exists ())
+    set_errno (ENOENT);
   else if (!path.isdir ())
-    {
-      set_errno (ENOTDIR);
-      return -1;
-    }
+    set_errno (ENOTDIR);
   else
-    {
-      native_dir =3D "c:\\";
-      res =3D 0;
-    }
+    res =3D 0;

-  /* If res !=3D 0, we didn't change to a new directory.
-     Otherwise, set the current windows and posix directory cache from inp=
ut.
-     If the specified directory is a MS-DOS style directory or if the dire=
ctory
-     was symlinked, convert the MS-DOS path back to posix style.  Otherwis=
e just
-     store the given directory.  This allows things like "find", which tra=
verse
-     directory trees, to work correctly with Cygwin mounted directories.
-     FIXME: Is just storing the posixized windows directory the correct th=
ing to
-     do when we detect a symlink?  Should we instead rebuild the posix pat=
h from
-     the input by traversing links?  This would be an expensive operation =
but
-     we'll see if Cygwin mailing list users whine about the current behavi=
or. */
-  if (res)
-    __seterrno ();
-  else if ((!path.has_symlinks () && strpbrk (dir, ":\\") =3D=3D NULL
-	    && pcheck_case =3D=3D PCHECK_RELAXED) || isvirtual_dev (devn))
-    cygheap->cwd.set (native_dir, dir);
-  else
-    cygheap->cwd.set (native_dir, NULL);
+  if (res =3D=3D 0)
+    cygheap->cwd.set (native_dir);

   /* Note that we're accessing cwd.posix without a lock here.  I didn't th=
ink
      it was worth locking just for strace. */
@@ -3711,16 +3681,12 @@ cwdstuff::set (const char *win32_cwd, co
     }

   if (!posix_cwd)
-    mount_table->conv_to_posix_path (win32, pathbuf, 0);
-  else
     {
-      char * tail;
-      (void) normalize_posix_path (posix_cwd, pathbuf, &tail);
-      if (tail > pathbuf + 1 && *(--tail) =3D=3D '/')
-	*tail =3D 0;
+      mount_table->conv_to_posix_path (win32, pathbuf, 0);
+      posix_cwd =3D pathbuf;
     }
-  posix =3D (char *) crealloc (posix, strlen (pathbuf) + 1);
-  strcpy (posix, pathbuf);
+  posix =3D (char *) crealloc (posix, strlen (posix_cwd) + 1);
+  strcpy (posix, posix_cwd);

   hash =3D hash_path_name (0, win32);


--=====================_1083830333==_--
