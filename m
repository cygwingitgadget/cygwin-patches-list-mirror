Return-Path: <cygwin-patches-return-4702-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27897 invoked by alias); 5 May 2004 00:07:04 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 27871 invoked from network); 5 May 2004 00:07:03 -0000
Message-Id: <3.0.5.32.20040504200359.007fcec0@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Wed, 05 May 2004 00:07:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: [Patch]: chdir
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1083729839==_"
X-SW-Source: 2004-q2/txt/msg00054.txt.bz2

--=====================_1083729839==_
Content-Type: text/plain; charset="us-ascii"
Content-length: 1013

Here is a simple patch that simplifies chdir processing
and avoids calling normalized_posix_path multiple times.

If it doesn't break anything it will simplify removing
trailing dots and spaces, as discussed earlier today.

I have kept the test "pcheck_case == PCHECK_RELAXED",
although I don't see why it helps. Also I have not edited
the long comment on line 3329. I don't understand all the
points it is trying to make. I think the patch does what
the FIXME talks about, except that it's actually cheap.

During tests I have seen that 'touch "    "' touches the
current directory. It's probably a good idea to disallow
names consisting entirely of spaces, as we already disallow
names consisting entirely of dots. 

Pierre

2004-05-05  Pierre Humblet <pierre.humblet@ieee.org>

	* path.cc (chdir): Do not check for trailing spaces.
	Specify PC_POSIX in constructing "path". Pass normalized_path to 
	cygheap->cwd.set except when it starts with a drive.
	(cwdstuff::set): Assume posix_cwd is already normalized.
--=====================_1083729839==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="path.diff"
Content-length: 2614

Index: path.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/path.cc,v
retrieving revision 1.308
diff -u -p -r1.308 path.cc
--- path.cc	4 May 2004 15:14:48 -0000	1.308
+++ path.cc	4 May 2004 23:45:54 -0000
@@ -3285,29 +3285,13 @@ chdir (const char *in_dir)

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
+  path_conv path (PC_NONULLEMPTY, in_dir, PC_FULL | PC_SYM_FOLLOW | PC_POS=
IX);
   if (path.error)
     {
       set_errno (path.error);
-      syscall_printf ("-1 =3D chdir (%s)", dir);
+      syscall_printf ("-1 =3D chdir (%s)", in_dir);
       return -1;
     }

@@ -3354,9 +3338,9 @@ chdir (const char *in_dir)
      we'll see if Cygwin mailing list users whine about the current behavi=
or. */
   if (res)
     __seterrno ();
-  else if ((!path.has_symlinks () && strpbrk (dir, ":\\") =3D=3D NULL
-	    && pcheck_case =3D=3D PCHECK_RELAXED) || isvirtual_dev (devn))
-    cygheap->cwd.set (native_dir, dir);
+  else if (!isdrive (path.normalized_path)
+           && pcheck_case =3D=3D PCHECK_RELAXED)
+    cygheap->cwd.set (native_dir, path.normalized_path);
   else
     cygheap->cwd.set (native_dir, NULL);

@@ -3711,16 +3695,12 @@ cwdstuff::set (const char *win32_cwd, co
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


--=====================_1083729839==_--
