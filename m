Return-Path: <cygwin-patches-return-4760-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11696 invoked by alias); 15 May 2004 02:41:44 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 11687 invoked from network); 15 May 2004 02:41:43 -0000
Message-Id: <3.0.5.32.20040514223818.007fdc80@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Sat, 15 May 2004 02:41:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: [Patch]: ./.. changed during execution of find
In-Reply-To: <40A4CB07.93BF544@ieee.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1084603098==_"
X-SW-Source: 2004-q2/txt/msg00112.txt.bz2

--=====================_1084603098==_
Content-Type: text/plain; charset="us-ascii"
Content-length: 1114

I have been rereading the chdir thread to see how things 
went wrong. The problem with find is due to the following change
<http://cygwin.com/ml/cygwin-patches/2004-q2/msg00063.html>

> That means that cwd.set always attempts to build the
> Posix wd through the mount table.
> Up to now that was only the case when a symlink was
> involved in the translation, or there was a ":" or a "\" 
> in the directory name, or check_case was not relaxed.

It follows that "find /" has always been broken when 
check_case != "relax". 

Please review carefully! In addition to fixing the find bug the
patch fixes the handling of paths such as c:xxx and it calls
SetCurrentDirectory inside the muto region.

Pierre

2004-05-15  Pierre Humblet <pierre.humblet@ieee.org>

	* cygheap.h (cwdstuff::set): Modify return value and arguments.
	* path.cc (chdir): Specify PC_POSIX. Do not call SetCurrentDirectory.
	Set posix_cwd in a way that does not break find.exe. Change call to cwd.set.
	(cwdstuff::get_initial): Do not call GetCurrentDirectory here.
	(cwdstuff::set): Call SetCurrentDirectory and GetCurrentDirectory
	as needed.

--=====================_1084603098==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="path.diff"
Content-length: 4439

Index: path.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/path.cc,v
retrieving revision 1.311
diff -u -p -r1.311 path.cc
--- path.cc	12 May 2004 14:04:23 -0000	1.311
+++ path.cc	15 May 2004 02:22:54 -0000
@@ -3297,7 +3297,7 @@ chdir (const char *in_dir)

   /* Convert path.  First argument ensures that we don't check for NULL/em=
pty/invalid
      again. */
-  path_conv path (PC_NONULLEMPTY, in_dir, PC_FULL | PC_SYM_FOLLOW);
+  path_conv path (PC_NONULLEMPTY, in_dir, PC_FULL | PC_SYM_FOLLOW | PC_POS=
IX);
   if (path.error)
     {
       set_errno (path.error);
@@ -3306,7 +3306,8 @@ chdir (const char *in_dir)
     }

   int res =3D -1;
-  const char *native_dir =3D path;
+  bool doit =3D false;
+  const char *native_dir =3D path, *posix_cwd =3D NULL;
   int devn =3D path.get_devn ();
   if (!isvirtual_dev (devn))
     {
@@ -3319,20 +3320,28 @@ chdir (const char *in_dir)
 	  path.get_win32 ()[2] =3D '\\';
 	  path.get_win32 ()[3] =3D '\0';
 	}
-      if (SetCurrentDirectory (native_dir))
-        res =3D 0;
-      else
-        __seterrno ();
+      /* The sequence chdir("xx"); chdir(".."); must be a noop if xx
+	 is not a symlink. This is exploited by find.exe.
+	 The posix_cwd is just path.normalized_path.
+	 In other cases we let cwd.set obtain the Posix path through
+	 the mount table. */
+      if (!path.has_symlinks () && !isabspath (in_dir))
+	posix_cwd =3D path.normalized_path;
+      res =3D 0;
+      doit =3D true;
     }
   else if (!path.exists ())
     set_errno (ENOENT);
   else if (!path.isdir ())
     set_errno (ENOTDIR);
   else
-    res =3D 0;
+   {
+     posix_cwd =3D path.normalized_path;
+     res =3D 0;
+   }

-  if (res =3D=3D 0)
-    cygheap->cwd.set (native_dir);
+  if (!res)
+    res =3D cygheap->cwd.set (native_dir, posix_cwd, doit);

   /* Note that we're accessing cwd.posix without a lock here.  I didn't th=
ink
      it was worth locking just for strace. */
@@ -3647,39 +3656,51 @@ cwdstuff::get_initial ()

   if (win32)
     return 1;
-
-  int i;
-  DWORD len, dlen;
-  for (i =3D 0, dlen =3D CYG_MAX_PATH, len =3D 0; i < 3; dlen *=3D 2, i++)
-    {
-      win32 =3D (char *) crealloc (win32, dlen + 2);
-      if ((len =3D GetCurrentDirectoryA (dlen, win32)) < dlen)
-	break;
-    }
-
-  if (len =3D=3D 0)
-    {
-      __seterrno ();
-      cwd_lock->release ();
-      debug_printf ("get_initial_cwd failed, %E");
-      cwd_lock->release ();
-      return 0;
-    }
-  set (NULL);
-  return 1;	/* Leaves cwd lock unreleased */
+
+  /* Leaves cwd lock unreleased, if success */
+  return !set (NULL, NULL, false);
 }

-/* Fill out the elements of a cwdstuff struct.
+/* Chdir and fill out the elements of a cwdstuff struct.
    It is assumed that the lock for the cwd is acquired if
    win32_cwd =3D=3D NULL. */
-void
-cwdstuff::set (const char *win32_cwd, const char *posix_cwd)
+int
+cwdstuff::set (const char *win32_cwd, const char *posix_cwd, bool doit)
 {
-  char pathbuf[CYG_MAX_PATH];
+  char pathbuf[2 * CYG_MAX_PATH];
+  int res =3D -1;

   if (win32_cwd)
     {
-      cwd_lock->acquire ();
+       cwd_lock->acquire ();
+       if (doit && !SetCurrentDirectory (win32_cwd))
+         {
+            __seterrno ();
+            goto out;
+         }
+    }
+  /* If there is no win32 path or it has the form c:xxx, get the value */
+  if (!win32_cwd || (isdrive (win32_cwd) && win32_cwd[2] !=3D '\\'))
+    {
+      int i;
+      DWORD len, dlen;
+      for (i =3D 0, dlen =3D CYG_MAX_PATH/3; i < 2; i++, dlen =3D len)
+        {
+	  win32 =3D (char *) crealloc (win32, dlen);
+	  if ((len =3D GetCurrentDirectoryA (dlen, win32)) < dlen)
+	    break;
+	}
+      if (len =3D=3D 0)
+        {
+	  __seterrno ();
+	  debug_printf ("GetCurrentDirectory, %E");
+	  win32_cwd =3D pathbuf; /* Force lock release */
+	  goto out;
+	}
+      posix_cwd =3D NULL;
+    }
+  else
+    {
       win32 =3D (char *) crealloc (win32, strlen (win32_cwd) + 1);
       strcpy (win32, win32_cwd);
     }
@@ -3694,10 +3715,11 @@ cwdstuff::set (const char *win32_cwd, co

   hash =3D hash_path_name (0, win32);

+  res =3D 0;
+out:
   if (win32_cwd)
     cwd_lock->release ();
-
-  return;
+  return res;
 }

 /* Copy the value for either the posix or the win32 cwd into a buffer. */

--=====================_1084603098==_--
