Return-Path: <cygwin-patches-return-4653-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1886 invoked by alias); 4 Apr 2004 14:00:47 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 1845 invoked from network); 4 Apr 2004 14:00:44 -0000
Message-Id: <3.0.5.32.20040404095756.00804cc0@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Sun, 04 Apr 2004 14:00:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: Re: [Patch]: path.cc
In-Reply-To: <20040404040127.GB19875@coc.bosbc.com>
References: <3.0.5.32.20040403214940.007f2650@incoming.verizon.net>
 <3.0.5.32.20040403214940.007f2650@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1081101476==_"
X-SW-Source: 2004-q2/txt/msg00005.txt.bz2

--=====================_1081101476==_
Content-Type: text/plain; charset="us-ascii"
Content-length: 3331

At 11:01 PM 4/3/2004 -0500, Christopher Faylor wrote:
>On Sat, Apr 03, 2004 at 09:49:40PM -0500, Pierre A. Humblet wrote:

>Also, there is a problem in execution:
<snip>

>I believe that this is due to your removal of the normalize stuff from
>mount_info::conv_to_win32_path.  

It turns out that the normalized stuff was never called in 
mount_info::conv_to_win32_path and so that's really old cruft.
It was always called with no_normalize.
The problem was that need_directory is now checked after calling
normalize_posix_path, which was keeping /alice/ intact but changing
/alice/. into /alice  , so that need_directory wasn't set.
That's fixed by removing a line. Now /alice/. becomes /alice/
then need_directory is set and finally /alice/ becomes /alice  

Hmm, that's embarrassing considering I started this after the
"final dot discussion"  in 
http://cygwin.com/ml/cygwin/2004-03/msg01386.html

>Also, maybe I'm missing something, but it seems like your change to
>pathnmatch is not necessarily an optimization.  It depends on the path.

Right.

>If one is often comparing paths that differ in the last len1-n
>characters then doing the isdirsep, etc.  checks makes sense.  It only
>seems like it would be an operation if you were routinely compared paths
>like "c:\cygwin" and "c:\cygwinfoo" which is rarely the case, IMO.

Absolutely right. It's an optimization if the probability that
"isdirsep() detects a mismatch" is greater than 
"cost of executing isdirsep() " / "cost of executing the pathnmatch".
The latter involves two function calls while isdirsep() is a simple macro,
so my gut feeling is that the change is good.
 
>Except that old symlinks that use EA would be slightly slower, right?
>
>I agree that it is not worth keeping this in the inner loop.  I have
>always wanted to cache this data, too, rather than continually looking
>it up.

Done.

>So, sorry, this patch isn't yet ready for prime time.

Here we go again, from a clean sandbox.

>Can you break it down into smaller pieces, maybe?

It's like pulling a thread... At this point I would need to undo some
changes and retest. The next one will be shorter.
Perhaps I should not have added the removal of fs.update(), but given
that we have discussed it...

Pierre

2004-04-04  Pierre Humblet <pierre.humblet@ieee.org>

	* path.cc (path_prefix_p): Optimize test order.
	(normalize_posix_path): Add "tail" argument and set it. Always have a
	final slash for directories. Pass 3rd argument to normalize_win32_path.
	(path_conv::check): Pass tail to normalize_posix_path. Set need_directory
	and remove final slash after that call. Remove last argument to
	mount_table->conv_to_win32_path(). Remove noop dostail check. Remove
	fs.update() from inner loop. Improve tail finding search.
	(normalize_win32_path): Add and set tail argument.
	(mount_item::build_win32): Avoid calling strcpy.
	(mount_info::conv_to_win32_path): Remove third argument and simplify
	because the source is normalized. Keep /proc path in Posix form.
	Call win32_device_name() only once.
	(mount_info::conv_to_posix_path): Add and use 3rd argument to 
	normalize_win32_path to avoid calling strlen. 
	(cwdstuff::set): Add 3rd argument to normalize_posix_path and remove final
	slash if any. 
	* shared_info.h (mount_info::conv_to_win32_path): Remove last argument
	in declaration.
 

--=====================_1081101476==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="path.cc.diff"
Content-length: 13087

Index: path.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/path.cc,v
retrieving revision 1.291
diff -u -p -r1.291 path.cc
--- path.cc	26 Mar 2004 20:02:01 -0000	1.291
+++ path.cc	4 Apr 2004 13:46:18 -0000
@@ -75,7 +75,7 @@ details. */
 #include "cygtls.h"
 #include <assert.h>

-static int normalize_win32_path (const char *src, char *dst);
+static int normalize_win32_path (const char *src, char *dst, char ** tail =
=3D 0);
 static void slashify (const char *src, char *dst, int trailing_slash_p);
 static void backslashify (const char *src, char *dst, int trailing_slash_p=
);

@@ -161,10 +161,10 @@ path_prefix_p (const char *path1, const
   if (len1 =3D=3D 0)
     return isdirsep (path2[0]) && !isdirsep (path2[1]);

-  if (!pathnmatch (path1, path2, len1))
-    return 0;
-
-  return isdirsep (path2[len1]) || path2[len1] =3D=3D 0 || path1[len1 - 1]=
 =3D=3D ':';
+  if (isdirsep (path2[len1]) || path2[len1] =3D=3D 0 || path1[len1 - 1] =
=3D=3D ':')
+    return pathnmatch (path1, path2, len1);
+
+  return 0;
 }

 /* Return non-zero if paths match in first len chars.
@@ -192,7 +192,7 @@ pathmatch (const char *path1, const char
    The result is 0 for success, or an errno error value.  */

 static int
-normalize_posix_path (const char *src, char *dst)
+normalize_posix_path (const char *src, char *dst, char **tail)
 {
   const char *src_start =3D src;
   char *dst_start =3D dst;
@@ -263,8 +263,7 @@ normalize_posix_path (const char *src, c
 		{
 		  if (!src[1])
 		    {
-		      if (dst =3D=3D dst_start)
-			*dst++ =3D '/';
+		      *dst++ =3D '/';
 		      goto done;
 		    }
 		  if (!isslash (src[1]))
@@ -302,14 +301,13 @@ normalize_posix_path (const char *src, c

 done:
   *dst =3D '\0';
-  if (--dst > dst_start && isslash (*dst))
-    *dst =3D '\0';
+  *tail =3D dst;

   debug_printf ("%s =3D normalize_posix_path (%s)", dst_start, src_start);
   return 0;

 win32_path:
-  int err =3D normalize_win32_path (in_src, in_dst);
+  int err =3D normalize_win32_path (in_src, in_dst, tail);
   if (!err)
     for (char *p =3D in_dst; (p =3D strchr (p, '\\')); p++)
       *p =3D '/';
@@ -495,24 +493,19 @@ path_conv::check (const char *src, unsig
       MALLOC_CHECK;
       assert (src);

-      char *p =3D strchr (src, '\0');
-      /* Detect if the user was looking for a directory.  We have to strip=
 the
-	 trailing slash initially and add it back on at the end due to Windows
-	 brain damage. */
-      if (--p > src)
-	{
-	  if (isdirsep (*p))
-	    need_directory =3D 1;
-	  else if (--p  > src && p[1] =3D=3D '.' && isdirsep (*p))
-	    need_directory =3D 1;
-	}
-
       is_relpath =3D !isabspath (src);
-      error =3D normalize_posix_path (src, path_copy);
+      error =3D normalize_posix_path (src, path_copy, &tail);
       if (error)
 	return;

-      tail =3D strchr (path_copy, '\0');   // Point to end of copy
+      /* Detect if the user was looking for a directory.  We have to strip=
 the
+	 trailing slash initially while trying to add extensions but take it
+	 into account during processing */
+      if (tail > path_copy + 1 && isslash (*(tail - 1)))
+        {
+	  need_directory =3D 1;
+	  *--tail =3D '\0';
+	}
       char *path_end =3D tail;
       tail[1] =3D '\0';

@@ -548,7 +541,7 @@ path_conv::check (const char *src, unsig

 	  /* Convert to native path spec sans symbolic link info. */
 	  error =3D mount_table->conv_to_win32_path (path_copy, full_path, dev,
-						   &sym.pflags, 1);
+						   &sym.pflags);

 	  if (error)
 	    return;
@@ -598,19 +591,10 @@ path_conv::check (const char *src, unsig
 	      goto out;		/* Found a device.  Stop parsing. */
 	    }

-	  if (!fs.update (full_path))
-	    fs.root_dir ()[0] =3D '\0';
-
-	  /* Eat trailing slashes */
-	  char *dostail =3D strchr (full_path, '\0');
-
 	  /* If path is only a drivename, Windows interprets it as the
 	     current working directory on this drive instead of the root
 	     dir which is what we want. So we need the trailing backslash
 	     in this case. */
-	  while (dostail > full_path + 3 && (*--dostail =3D=3D '\\'))
-	    *tail =3D '\0';
-
 	  if (full_path[0] && full_path[1] =3D=3D ':' && full_path[2] =3D=3D '\0')
 	    {
 	      full_path[2] =3D '\\';
@@ -703,19 +687,16 @@ path_conv::check (const char *src, unsig
 	      /* No existing file found. */
 	    }

-	  /* Find the "tail" of the path, e.g. in '/for/bar/baz',
+	  /* Find the new "tail" of the path, e.g. in '/for/bar/baz',
 	     /baz is the tail. */
-	  char *newtail =3D strrchr (path_copy, '/');
 	  if (tail !=3D path_end)
 	    *tail =3D '/';
-
+	  while (--tail > path_copy + 1 && *tail !=3D '/') {}
 	  /* Exit loop if there is no tail or we are at the
 	     beginning of a UNC path */
-	  if (!newtail || newtail =3D=3D path_copy || (newtail =3D=3D path_copy +=
 1 && newtail[-1] =3D=3D '/'))
+          if (tail <=3D path_copy + 1)
 	    goto out;	// all done

-	  tail =3D newtail;
-
 	  /* Haven't found an existing pathname component yet.
 	     Pinch off the tail and try again. */
 	  *tail =3D '\0';
@@ -745,6 +726,7 @@ path_conv::check (const char *src, unsig

       /* Strip off current directory component since this is the part that=
 refers
 	 to the symbolic link. */
+      char * p;
       if ((p =3D strrchr (path_copy, '/')) =3D=3D NULL)
 	p =3D path_copy;
       else if (p =3D=3D path_copy)
@@ -787,8 +769,7 @@ path_conv::check (const char *src, unsig
     add_ext_from_sym (sym);

 out:
-  /* Deal with Windows stupidity which considers filename\. to be valid
-     even when "filename" is not a directory. */
+  /* If the user wants a directory, do not return a symlink */
   if (!need_directory || error)
     /* nothing to do */;
   else if (fileattr & FILE_ATTRIBUTE_DIRECTORY)
@@ -928,7 +909,7 @@ win32_device_name (const char *src_path,
    The result is 0 for success, or an errno error value.
    FIXME: A lot of this should be mergeable with the POSIX critter.  */
 static int
-normalize_win32_path (const char *src, char *dst)
+normalize_win32_path (const char *src, char *dst, char **tail)
 {
   const char *src_start =3D src;
   char *dst_start =3D dst;
@@ -1010,6 +991,8 @@ normalize_win32_path (const char *src, c
 	return ENAMETOOLONG;
     }
   *dst =3D 0;
+  if (tail)
+    *tail =3D dst;
   debug_printf ("%s =3D normalize_win32_path (%s)", dst_start, src_start);
   return 0;
 }
@@ -1339,10 +1322,7 @@ mount_item::build_win32 (char *dst, cons
       if ((n + strlen (p)) > CYG_MAX_PATH)
 	err =3D ENAMETOOLONG;
       else
-	{
-	  strcpy (dst + n, p);
-	  backslashify (dst, dst, 0);
-	}
+        backslashify (p, dst + n, 0);
     }
   else
     {
@@ -1382,7 +1362,7 @@ mount_item::build_win32 (char *dst, cons

 int
 mount_info::conv_to_win32_path (const char *src_path, char *dst, device& d=
ev,
-				unsigned *flags, bool no_normalize)
+				unsigned *flags)
 {
   bool chroot_ok =3D !cygheap->root.exists ();
   while (sys_mount_table_counter < cygwin_shared->sys_mount_table_counter)
@@ -1390,32 +1370,17 @@ mount_info::conv_to_win32_path (const ch
       init ();
       sys_mount_table_counter++;
     }
-  int src_path_len =3D strlen (src_path);
   MALLOC_CHECK;
-  unsigned dummy_flags;

   dev.devn =3D FH_FS;

-  if (!flags)
-    flags =3D &dummy_flags;
-
   *flags =3D 0;
   debug_printf ("conv_to_win32_path (%s)", src_path);

-  if (src_path_len >=3D CYG_MAX_PATH)
-    {
-      debug_printf ("ENAMETOOLONG =3D conv_to_win32_path (%s)", src_path);
-      return ENAMETOOLONG;
-    }
-
   int i, rc;
   mount_item *mi =3D NULL;	/* initialized to avoid compiler warning */
-  char pathbuf[CYG_MAX_PATH];
-
-  if (dst =3D=3D NULL)
-    goto out;		/* Sanity check. */

-  /* Normalize the path, taking out ../../ stuff, we need to do this
+  /* The path is already normalized, without ../../ stuff, we need to have=
 this
      so that we can move from one mounted directory to another with relati=
ve
      stuff.

@@ -1427,25 +1392,11 @@ mount_info::conv_to_win32_path (const ch

      should look in c:/foo, not d:/foo.

-     We do this by first getting an absolute UNIX-style path and then
-     converting it to a DOS-style path, looking up the appropriate drive
-     in the mount table.  */
-
-  if (no_normalize)
-    strcpy (pathbuf, src_path);
-  else
-    {
-      rc =3D normalize_posix_path (src_path, pathbuf);
-
-      if (rc)
-	{
-	  debug_printf ("%d =3D conv_to_win32_path (%s)", rc, src_path);
-	  return rc;
-	}
-    }
+     converting normalizex UNIX path to a DOS-style path, looking up the
+     appropriate drive in the mount table.  */

   /* See if this is a cygwin "device" */
-  if (win32_device_name (pathbuf, dst, dev))
+  if (win32_device_name (src_path, dst, dev))
     {
       *flags =3D MOUNT_BINARY;	/* FIXME: Is this a sensible default for de=
vices? */
       rc =3D 0;
@@ -1455,27 +1406,30 @@ mount_info::conv_to_win32_path (const ch
   /* Check if the cygdrive prefix was specified.  If so, just strip
      off the prefix and transform it into an MS-DOS path. */
   MALLOC_CHECK;
-  if (isproc (pathbuf))
+  if (isproc (src_path))
     {
       dev =3D *proc_dev;
-      dev.devn =3D fhandler_proc::get_proc_fhandler (pathbuf);
+      dev.devn =3D fhandler_proc::get_proc_fhandler (src_path);
       if (dev.devn =3D=3D FH_BAD)
 	return ENOENT;
+      set_flags (flags, PATH_BINARY);
+      strcpy (dst, src_path);
+      goto out;
     }
-  else if (iscygdrive (pathbuf))
+  else if (iscygdrive (src_path))
     {
       int n =3D mount_table->cygdrive_len - 1;
       int unit;

-      if (!pathbuf[n] ||
-	  (pathbuf[n] =3D=3D '/' && pathbuf[n + 1] =3D=3D '.' && !pathbuf[n + 2]))
+      if (!src_path[n] ||
+	  (src_path[n] =3D=3D '/' && src_path[n + 1] =3D=3D '.' && !src_path[n + =
2]))
 	{
 	  unit =3D 0;
 	  dst[0] =3D '\0';
 	  if (mount_table->cygdrive_len > 1)
 	    dev =3D *cygdrive_dev;
 	}
-      else if (cygdrive_win32_path (pathbuf, dst, unit))
+      else if (cygdrive_win32_path (src_path, dst, unit))
 	{
 	  set_flags (flags, (unsigned) cygdrive_flags);
 	  goto out;
@@ -1510,32 +1464,24 @@ mount_info::conv_to_win32_path (const ch
 	  continue;
 	}

-      if (path_prefix_p (path, pathbuf, len))
+      if (path_prefix_p (path, src_path, len))
 	break;
     }

   if (i < nmounts)
     {
-      int err =3D mi->build_win32 (dst, pathbuf, flags, chroot_pathlen);
+      int err =3D mi->build_win32 (dst, src_path, flags, chroot_pathlen);
       if (err)
 	return err;
       chroot_ok =3D true;
     }
   else
     {
-      if (strpbrk (src_path, ":\\") !=3D NULL || slash_unc_prefix_p (src_p=
ath))
-	rc =3D normalize_win32_path (src_path, dst);
-      else
-	{
-	  backslashify (pathbuf, dst, 0);	/* just convert */
-	  set_flags (flags, PATH_BINARY);
-	}
-      chroot_ok =3D !cygheap->root.exists ();
+      if (strchr (src_path, ':') =3D=3D NULL && !slash_unc_prefix_p (src_p=
ath))
+	set_flags (flags, PATH_BINARY);
+      backslashify (src_path, dst, 0);
     }

-  if (!isvirtual_dev (dev.devn))
-    win32_device_name (src_path, dst, dev);
-
  out:
   MALLOC_CHECK;
   if (chroot_ok || cygheap->root.ischroot_native (dst))
@@ -1650,14 +1596,15 @@ mount_info::conv_to_posix_path (const ch
     }

   char pathbuf[CYG_MAX_PATH];
-  int rc =3D normalize_win32_path (src_path, pathbuf);
+  char * tail;
+  int rc =3D normalize_win32_path (src_path, pathbuf, &tail);
   if (rc !=3D 0)
     {
       debug_printf ("%d =3D conv_to_posix_path (%s)", rc, src_path);
       return rc;
     }

-  int pathbuflen =3D strlen (pathbuf);
+  int pathbuflen =3D tail - pathbuf;
   for (int i =3D 0; i < nmounts; ++i)
     {
       mount_item &mi =3D mount[native_sorted[i]];
@@ -3752,8 +3699,12 @@ cwdstuff::set (const char *win32_cwd, co
   if (!posix_cwd)
     mount_table->conv_to_posix_path (win32, pathbuf, 0);
   else
-    (void) normalize_posix_path (posix_cwd, pathbuf);
-
+    {
+      char * tail;
+      (void) normalize_posix_path (posix_cwd, pathbuf, &tail);
+      if (tail > pathbuf + 1 && *(--tail) =3D=3D '/')
+	*tail =3D 0;
+    }
   posix =3D (char *) crealloc (posix, strlen (pathbuf) + 1);
   strcpy (posix, pathbuf);

Index: shared_info.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/shared_info.h,v
retrieving revision 1.40
diff -u -p -r1.40 shared_info.h
--- shared_info.h	26 Mar 2004 21:43:48 -0000	1.40
+++ shared_info.h	4 Apr 2004 13:46:18 -0000
@@ -85,7 +85,7 @@ class mount_info

   unsigned set_flags_from_win32_path (const char *path);
   int conv_to_win32_path (const char *src_path, char *dst, device&,
-			  unsigned *flags =3D NULL, bool no_normalize =3D 0);
+			  unsigned *flags =3D NULL);
   int conv_to_posix_path (const char *src_path, char *posix_path,
 			  int keep_rel_p);
   struct mntent *getmntent (int x);

--=====================_1081101476==_--
