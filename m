Return-Path: <cygwin-patches-return-4651-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21414 invoked by alias); 4 Apr 2004 04:29:14 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 21392 invoked from network); 4 Apr 2004 04:29:10 -0000
Date: Sun, 04 Apr 2004 04:29:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: path.cc
Message-ID: <20040404040127.GB19875@coc.bosbc.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20040403214940.007f2650@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20040403214940.007f2650@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
Resent-From: Christopher Faylor <cgf@alum.bu.edu>
Resent-Date: Sat, 3 Apr 2004 23:29:10 -0500
Resent-To: cygwin-patches@cygwin.com
Resent-Message-Id: <20040404042910.9E0DA40021E@timesys.com>
X-SW-Source: 2004-q2/txt/msg00003.txt.bz2

On Sat, Apr 03, 2004 at 09:49:40PM -0500, Pierre A. Humblet wrote:
>This patch removes old cruft from and streamlines the mainline of 
>path_conv::check (avoiding a bunch of strlen, strcpy and the like).
>It also removes trailing / in win32 paths.

Pierre, this patch didn't compile.  I had to declare normalize_win32_path
to match your usage.

Also, there is a problem in execution:

  bash$ cd /
  bash$ mkdir bob
  bash$ touch bob/carol
  bash$ mkdir ted
  bash$ ln -s bob alice
  bash$ cd ted
  bash$ ls -l ../alice/.
  lrwxrwxrwx    1 cgf      None           86 Apr  3 22:52 ../alice/. -> bob

rather than:
  bash$ ls -l ../alice/.
  total 0
  -rw-rw-rw-    1 cgf      None            0 Apr  3 22:52 carol

I believe that this is due to your removal of the normalize stuff from
mount_info::conv_to_win32_path.  I have tried to do what you did on
many occasions.  I hated putting the normalize_posix_path in the
outer loop when there was already a normalize in the inner loop but
I think both are required -- just to work around the problem of
Windows allowing the "file/." usage.  Where "file" is a... file
rather than a directory.

Also, maybe I'm missing something, but it seems like your change to
pathnmatch is not necessarily an optimization.  It depends on the path.
If one is often comparing paths that differ in the last len1-n
characters then doing the isdirsep, etc.  checks makes sense.  It only
seems like it would be an operation if you were routinely compared paths
like "c:\cygwin" and "c:\cygwinfoo" which is rarely the case, IMO.

>I noticed that fs.update is called in the inner loop of ::check.
>The only reason is to check if extended attributes are supported.
>That's necessary with the old style of symlinks where the link
>is written both to the file and to the EA (for speed when reading). 
>However today only setup uses the old style, and it doesn't use EA.
>Thus overall I think that trying to read the EA (and failing) is 
>counterproductive and fs.update() should be removed from the inner loop
>(I have verified that nothing bad happens even with old symlinks).

Except that old symlinks that use EA would be slightly slower, right?

I agree that it is not worth keeping this in the inner loop.  I have
always wanted to cache this data, too, rather than continually looking
it up.

So, sorry, this patch isn't yet ready for prime time.

Can you break it down into smaller pieces, maybe?

cgf

>Pierre
>
>2004-04-04  Pierre Humblet <pierre.humblet@ieee.org>
>
>	* path.cc (path_prefix_p): Optimize test order.
>	(normalize_posix_path): Add "tail" argument and set it.
>	Do not remove final slash. Pass 3rd argument to normalize_win32_path.
>	(path_conv::check): Pass tail to normalize_posix_path. Set need_directory
>	and remove final slash after that call. Remove last argument to
>	mount_table->conv_to_win32_path(). Remove noop dostail check. Improve
>	tail finding search.
>	(normalize_win32_path): Add and set tail argument.
>	(mount_item::build_win32): Avoid calling strcpy.
>	(mount_info::conv_to_win32_path): Remove third argument and simplify
>	because the source is normalized. Keep /proc path in Posix form.
>	Call win32_device_name() only once.
>	(mount_info::conv_to_posix_path): Add and use 3rd argument to 
>	normalize_win32_path to avoid calling strlen. 
>	(cwdstuff::set): Add 3rd argument to normalize_posix_path and remove final
>	slash if any. 
>	* shared_info.h (mount_info::conv_to_win32_path): Remove last argument
>	in declaration.

>Index: path.cc
>===================================================================
>RCS file: /cvs/src/src/winsup/cygwin/path.cc,v
>retrieving revision 1.291
>diff -u -p -r1.291 path.cc
>--- path.cc	26 Mar 2004 20:02:01 -0000	1.291
>+++ path.cc	4 Apr 2004 01:35:49 -0000
>@@ -161,10 +161,10 @@ path_prefix_p (const char *path1, const
>   if (len1 == 0)
>     return isdirsep (path2[0]) && !isdirsep (path2[1]);
>
>-  if (!pathnmatch (path1, path2, len1))
>-    return 0;
>-
>-  return isdirsep (path2[len1]) || path2[len1] == 0 || path1[len1 - 1] == ':';
>+  if (isdirsep (path2[len1]) || path2[len1] == 0 || path1[len1 - 1] == ':')
>+    return pathnmatch (path1, path2, len1);
>+
>+  return 0;
> }

> /* Return non-zero if paths match in first len chars.
>@@ -192,7 +192,7 @@ pathmatch (const char *path1, const char
>    The result is 0 for success, or an errno error value.  */
>
> static int
>-normalize_posix_path (const char *src, char *dst)
>+normalize_posix_path (const char *src, char *dst, char **tail)
> {
>   const char *src_start = src;
>   char *dst_start = dst;
>@@ -302,14 +302,13 @@ normalize_posix_path (const char *src, c
>
> done:
>   *dst = '\0';
>-  if (--dst > dst_start && isslash (*dst))
>-    *dst = '\0';
>+  *tail = dst;
>
>   debug_printf ("%s = normalize_posix_path (%s)", dst_start, src_start);
>   return 0;
>
> win32_path:
>-  int err = normalize_win32_path (in_src, in_dst);
>+  int err = normalize_win32_path (in_src, in_dst, tail);
>   if (!err)
>     for (char *p = in_dst; (p = strchr (p, '\\')); p++)
>       *p = '/';
>@@ -495,24 +494,19 @@ path_conv::check (const char *src, unsig
>       MALLOC_CHECK;
>       assert (src);
>
>-      char *p = strchr (src, '\0');
>-      /* Detect if the user was looking for a directory.  We have to strip the
>-	 trailing slash initially and add it back on at the end due to Windows
>-	 brain damage. */
>-      if (--p > src)
>-	{
>-	  if (isdirsep (*p))
>-	    need_directory = 1;
>-	  else if (--p  > src && p[1] == '.' && isdirsep (*p))
>-	    need_directory = 1;
>-	}
>-
>       is_relpath = !isabspath (src);
>-      error = normalize_posix_path (src, path_copy);
>+      error = normalize_posix_path (src, path_copy, &tail);
>       if (error)
> 	return;
>
>-      tail = strchr (path_copy, '\0');   // Point to end of copy
>+      /* Detect if the user was looking for a directory.  We have to strip the
>+	 trailing slash initially and add it back on at the end due to Windows
>+	 brain damage. */
>+      if (tail > path_copy + 1 && isslash (*(tail - 1)))
>+        {
>+	  need_directory = 1;
>+	  *--tail = '\0';
>+	}
>       char *path_end = tail;
>       tail[1] = '\0';
>
>@@ -548,7 +542,7 @@ path_conv::check (const char *src, unsig
>
> 	  /* Convert to native path spec sans symbolic link info. */
> 	  error = mount_table->conv_to_win32_path (path_copy, full_path, dev,
>-						   &sym.pflags, 1);
>+						   &sym.pflags);
>
> 	  if (error)
> 	    return;
>@@ -601,16 +595,10 @@ path_conv::check (const char *src, unsig
> 	  if (!fs.update (full_path))
> 	    fs.root_dir ()[0] = '\0';
>
>-	  /* Eat trailing slashes */
>-	  char *dostail = strchr (full_path, '\0');
>-
> 	  /* If path is only a drivename, Windows interprets it as the
> 	     current working directory on this drive instead of the root
> 	     dir which is what we want. So we need the trailing backslash
> 	     in this case. */
>-	  while (dostail > full_path + 3 && (*--dostail == '\\'))
>-	    *tail = '\0';
>-
> 	  if (full_path[0] && full_path[1] == ':' && full_path[2] == '\0')
> 	    {
> 	      full_path[2] = '\\';
>@@ -703,19 +691,16 @@ path_conv::check (const char *src, unsig
> 	      /* No existing file found. */
> 	    }
>
>-	  /* Find the "tail" of the path, e.g. in '/for/bar/baz',
>+	  /* Find the new "tail" of the path, e.g. in '/for/bar/baz',
> 	     /baz is the tail. */
>-	  char *newtail = strrchr (path_copy, '/');
> 	  if (tail != path_end)
> 	    *tail = '/';
>-
>+	  while (--tail > path_copy + 1 && *tail != '/') {}
> 	  /* Exit loop if there is no tail or we are at the
> 	     beginning of a UNC path */
>-	  if (!newtail || newtail == path_copy || (newtail == path_copy + 1 && newtail[-1] == '/'))
>+          if (tail <= path_copy + 1)
> 	    goto out;	// all done
>
>-	  tail = newtail;
>-
> 	  /* Haven't found an existing pathname component yet.
> 	     Pinch off the tail and try again. */
> 	  *tail = '\0';
>@@ -745,6 +730,7 @@ path_conv::check (const char *src, unsig
>
>       /* Strip off current directory component since this is the part that refers
> 	 to the symbolic link. */
>+      char * p;
>       if ((p = strrchr (path_copy, '/')) == NULL)
> 	p = path_copy;
>       else if (p == path_copy)
>@@ -787,8 +773,7 @@ path_conv::check (const char *src, unsig
>     add_ext_from_sym (sym);
>
> out:
>-  /* Deal with Windows stupidity which considers filename\. to be valid
>-     even when "filename" is not a directory. */
>+  /* If the user wants a directory, do not return a symlink */
>   if (!need_directory || error)
>     /* nothing to do */;
>   else if (fileattr & FILE_ATTRIBUTE_DIRECTORY)
>@@ -928,7 +913,7 @@ win32_device_name (const char *src_path,
>    The result is 0 for success, or an errno error value.
>    FIXME: A lot of this should be mergeable with the POSIX critter.  */
> static int
>-normalize_win32_path (const char *src, char *dst)
>+normalize_win32_path (const char *src, char *dst, char **tail)
> {
>   const char *src_start = src;
>   char *dst_start = dst;
>@@ -1010,6 +995,8 @@ normalize_win32_path (const char *src, c
> 	return ENAMETOOLONG;
>     }
>   *dst = 0;
>+  if (tail)
>+    *tail = dst;
>   debug_printf ("%s = normalize_win32_path (%s)", dst_start, src_start);
>   return 0;
> }
>@@ -1339,10 +1326,7 @@ mount_item::build_win32 (char *dst, cons
>       if ((n + strlen (p)) > CYG_MAX_PATH)
> 	err = ENAMETOOLONG;
>       else
>-	{
>-	  strcpy (dst + n, p);
>-	  backslashify (dst, dst, 0);
>-	}
>+        backslashify (p, dst + n, 0);
>     }
>   else
>     {
>@@ -1382,7 +1366,7 @@ mount_item::build_win32 (char *dst, cons
>
> int
> mount_info::conv_to_win32_path (const char *src_path, char *dst, device& dev,
>-				unsigned *flags, bool no_normalize)
>+				unsigned *flags)
> {
>   bool chroot_ok = !cygheap->root.exists ();
>   while (sys_mount_table_counter < cygwin_shared->sys_mount_table_counter)
>@@ -1390,32 +1374,17 @@ mount_info::conv_to_win32_path (const ch
>       init ();
>       sys_mount_table_counter++;
>     }
>-  int src_path_len = strlen (src_path);
>   MALLOC_CHECK;
>-  unsigned dummy_flags;
>
>   dev.devn = FH_FS;
>
>-  if (!flags)
>-    flags = &dummy_flags;
>-
>   *flags = 0;
>   debug_printf ("conv_to_win32_path (%s)", src_path);
>
>-  if (src_path_len >= CYG_MAX_PATH)
>-    {
>-      debug_printf ("ENAMETOOLONG = conv_to_win32_path (%s)", src_path);
>-      return ENAMETOOLONG;
>-    }
>-
>   int i, rc;
>   mount_item *mi = NULL;	/* initialized to avoid compiler warning */
>-  char pathbuf[CYG_MAX_PATH];
>-
>-  if (dst == NULL)
>-    goto out;		/* Sanity check. */
>
>-  /* Normalize the path, taking out ../../ stuff, we need to do this
>+  /* The path is already normalized, without ../../ stuff, we need to have this
>      so that we can move from one mounted directory to another with relative
>      stuff.
>
>@@ -1427,25 +1396,11 @@ mount_info::conv_to_win32_path (const ch
>
>      should look in c:/foo, not d:/foo.
>
>-     We do this by first getting an absolute UNIX-style path and then
>-     converting it to a DOS-style path, looking up the appropriate drive
>-     in the mount table.  */
>-
>-  if (no_normalize)
>-    strcpy (pathbuf, src_path);
>-  else
>-    {
>-      rc = normalize_posix_path (src_path, pathbuf);
>-
>-      if (rc)
>-	{
>-	  debug_printf ("%d = conv_to_win32_path (%s)", rc, src_path);
>-	  return rc;
>-	}
>-    }
>+     converting normalizex UNIX path to a DOS-style path, looking up the
>+     appropriate drive in the mount table.  */
>
>   /* See if this is a cygwin "device" */
>-  if (win32_device_name (pathbuf, dst, dev))
>+  if (win32_device_name (src_path, dst, dev))
>     {
>       *flags = MOUNT_BINARY;	/* FIXME: Is this a sensible default for devices? */
>       rc = 0;
>@@ -1455,27 +1410,30 @@ mount_info::conv_to_win32_path (const ch
>   /* Check if the cygdrive prefix was specified.  If so, just strip
>      off the prefix and transform it into an MS-DOS path. */
>   MALLOC_CHECK;
>-  if (isproc (pathbuf))
>+  if (isproc (src_path))
>     {
>       dev = *proc_dev;
>-      dev.devn = fhandler_proc::get_proc_fhandler (pathbuf);
>+      dev.devn = fhandler_proc::get_proc_fhandler (src_path);
>       if (dev.devn == FH_BAD)
> 	return ENOENT;
>+      set_flags (flags, PATH_BINARY);
>+      strcpy (dst, src_path);
>+      goto out;
>     }
>-  else if (iscygdrive (pathbuf))
>+  else if (iscygdrive (src_path))
>     {
>       int n = mount_table->cygdrive_len - 1;
>       int unit;
>
>-      if (!pathbuf[n] ||
>-	  (pathbuf[n] == '/' && pathbuf[n + 1] == '.' && !pathbuf[n + 2]))
>+      if (!src_path[n] ||
>+	  (src_path[n] == '/' && src_path[n + 1] == '.' && !src_path[n + 2]))
> 	{
> 	  unit = 0;
> 	  dst[0] = '\0';
> 	  if (mount_table->cygdrive_len > 1)
> 	    dev = *cygdrive_dev;
> 	}
>-      else if (cygdrive_win32_path (pathbuf, dst, unit))
>+      else if (cygdrive_win32_path (src_path, dst, unit))
> 	{
> 	  set_flags (flags, (unsigned) cygdrive_flags);
> 	  goto out;
>@@ -1510,32 +1468,25 @@ mount_info::conv_to_win32_path (const ch
> 	  continue;
> 	}
>
>-      if (path_prefix_p (path, pathbuf, len))
>+      if (path_prefix_p (path, src_path, len))
> 	break;
>     }
>
>   if (i < nmounts)
>     {
>-      int err = mi->build_win32 (dst, pathbuf, flags, chroot_pathlen);
>+      int err = mi->build_win32 (dst, src_path, flags, chroot_pathlen);
>       if (err)
> 	return err;
>       chroot_ok = true;
>+      goto out;
>     }
>   else
>     {
>-      if (strpbrk (src_path, ":\\") != NULL || slash_unc_prefix_p (src_path))
>-	rc = normalize_win32_path (src_path, dst);
>-      else
>-	{
>-	  backslashify (pathbuf, dst, 0);	/* just convert */
>-	  set_flags (flags, PATH_BINARY);
>-	}
>-      chroot_ok = !cygheap->root.exists ();
>+      if (strchr (src_path, ':') == NULL && !slash_unc_prefix_p (src_path))
>+	set_flags (flags, PATH_BINARY);
>+      backslashify (src_path, dst, 0);
>     }
>
>-  if (!isvirtual_dev (dev.devn))
>-    win32_device_name (src_path, dst, dev);
>-
>  out:
>   MALLOC_CHECK;
>   if (chroot_ok || cygheap->root.ischroot_native (dst))
>@@ -1650,14 +1601,15 @@ mount_info::conv_to_posix_path (const ch
>     }
>
>   char pathbuf[CYG_MAX_PATH];
>-  int rc = normalize_win32_path (src_path, pathbuf);
>+  char * tail;
>+  int rc = normalize_win32_path (src_path, pathbuf, &tail);
>   if (rc != 0)
>     {
>       debug_printf ("%d = conv_to_posix_path (%s)", rc, src_path);
>       return rc;
>     }
>
>-  int pathbuflen = strlen (pathbuf);
>+  int pathbuflen = tail - pathbuf;
>   for (int i = 0; i < nmounts; ++i)
>     {
>       mount_item &mi = mount[native_sorted[i]];
>@@ -3752,8 +3704,12 @@ cwdstuff::set (const char *win32_cwd, co
>   if (!posix_cwd)
>     mount_table->conv_to_posix_path (win32, pathbuf, 0);
>   else
>-    (void) normalize_posix_path (posix_cwd, pathbuf);
>-
>+    {
>+      char * tail;
>+      (void) normalize_posix_path (posix_cwd, pathbuf, &tail);
>+      if (tail > pathbuf + 1 && *(--tail) == '/')
>+	*tail = 0;
>+    }
>   posix = (char *) crealloc (posix, strlen (pathbuf) + 1);
>   strcpy (posix, pathbuf);
>
>Index: shared_info.h
>===================================================================
>RCS file: /cvs/src/src/winsup/cygwin/shared_info.h,v
>retrieving revision 1.40
>diff -u -p -r1.40 shared_info.h
>--- shared_info.h	26 Mar 2004 21:43:48 -0000	1.40
>+++ shared_info.h	4 Apr 2004 01:35:49 -0000
>@@ -85,7 +85,7 @@ class mount_info
>
>   unsigned set_flags_from_win32_path (const char *path);
>   int conv_to_win32_path (const char *src_path, char *dst, device&,
>-			  unsigned *flags = NULL, bool no_normalize = 0);
>+			  unsigned *flags = NULL);
>   int conv_to_posix_path (const char *src_path, char *posix_path,
> 			  int keep_rel_p);
>   struct mntent *getmntent (int x);

