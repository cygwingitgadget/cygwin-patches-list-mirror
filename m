Return-Path: <cygwin-patches-return-6284-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14772 invoked by alias); 11 Mar 2008 15:36:31 -0000
Received: (qmail 14762 invoked by uid 22791); 11 Mar 2008 15:36:29 -0000
X-Spam-Check-By: sourceware.org
Received: from dessent.net (HELO dessent.net) (69.60.119.225)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Tue, 11 Mar 2008 15:36:01 +0000
Received: from localhost ([127.0.0.1] helo=dessent.net) 	by dessent.net with esmtp (Exim 4.50) 	id 1JZ6WF-0004Zn-G8 	for cygwin-patches@cygwin.com; Tue, 11 Mar 2008 15:35:59 +0000
Message-ID: <47D6A6E1.F8C89DFF@dessent.net>
Date: Tue, 11 Mar 2008 15:36:00 -0000
From: Brian Dessent <brian@dessent.net>
Reply-To: cygwin-patches@cygwin.com
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [patch] cygcheck.cc update for cygpath()
References: <47D2E28C.3FC392D3@dessent.net> <20080308212718.GB5863@ednor.casa.cgf.cx> <47D3550B.76D34355@dessent.net> <20080309032437.GB6777@ednor.casa.cgf.cx> <47D36406.F7D7AB61@dessent.net> <20080309092806.GW18407@calimero.vinschen.de>
Content-Type: multipart/mixed;  boundary="------------60FDD61B4B3160DDDA23B27E"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q1/txt/msg00058.txt.bz2

This is a multi-part message in MIME format.
--------------60FDD61B4B3160DDDA23B27E
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-length: 1380

Corinna Vinschen wrote:

> Given that Cygwin changes to support long path names, I don't really
> like to see new code still using MAX_PATH and Win32 Ansi functions
> in the utils dir.  I know that the Win32 cwd is always restricted to
> 259 chars.  However, there *is* a way to recognize the current working
> directory of the parent Cygwin application.

Here's an updated version of the patch.  It addresses the problem of
resolving symlink targets relative to the dir of the link without a
gratuitous Get/SetCurrentDirectory sequence by introducing
cygpath_rel().  It does not yet address the issue of modernizing the
symlink reading code, that will follow.

This patch still has two cases of MAX_PATH usage: one in a buffer that
is used for GetCurrentDirectory(), so I don't see how making it larger
there helps.  The second is in a static buffer for the dirname()
helper.  I could simply make this one larger, however, the context where
this dirname() is used is a filename that's used with CreateFile() so
until that is plumbed to use WCHAR and \\?\ I don't really think it
makes sense to use more than MAX_PATH.  I could update that instance of
CreateFile, but the thing that provides the filename passed here is
itself driven by GetFileAttributes(), so it would need to be updated
too... and so on.  It looks like a lot of work to go completely
longfile-clean here.

Brian
--------------60FDD61B4B3160DDDA23B27E
Content-Type: text/plain; charset=us-ascii;
 name="cygcheck_cygpath_update_2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cygcheck_cygpath_update_2.patch"
Content-length: 8181

2008-03-11  Brian Dessent  <brian@dessent.net>

	* cygcheck.cc (dirname): New static function.
	(find_app_on_path): Use SYMLINK_MAX.  Resolve symlink relative
	to link's location.  Adjust to the fact that cygpath already
	normalizes its return value.
	* path.cc (rel_vconcat): Add cwd parameter, and use it instead
	of calling GetCurrentDirectory() if possible.  Rename throughout.
	(vcygpath): Rename from cygpath and accept cwd and va_list.  Pass
	cwd on to rel_vconcat().
	(cygpath_rel): New front end for vcygpath.
	(cygpath): Ditto.
	* path.h (cygpath_rel): Declare.
	(SYMLINK_MAX): Define to 4095.

 cygcheck.cc |   82 +++++++++++++++++++++++++++++++++++++++++++++++++++---------
 path.cc     |   73 ++++++++++++++++++++++++++++++++++++++---------------
 path.h      |    2 +
 3 files changed, 125 insertions(+), 32 deletions(-)

Index: cygcheck.cc
===================================================================
RCS file: /cvs/src/src/winsup/utils/cygcheck.cc,v
retrieving revision 1.97
diff -u -p -r1.97 cygcheck.cc
--- cygcheck.cc	13 Jan 2008 13:41:45 -0000	1.97
+++ cygcheck.cc	11 Mar 2008 15:03:37 -0000
@@ -807,6 +807,28 @@ ls (char *f)
     display_error ("ls: CloseHandle()");
 }
 
+/* Remove filename from 's' and return directory name without trailing
+   backslash, or NULL if 's' doesn't seem to have a dirname.  */
+static char *
+dirname (const char *s)
+{
+  static char buf[MAX_PATH + 1];
+
+  if (!s)
+    return NULL;
+
+  strncpy (buf, s, MAX_PATH);
+  buf[MAX_PATH] = '\0';   // in case strlen(s) > MAX_PATH
+  char *lastsep = strrchr (buf, '\\');
+  if (!lastsep)
+    return NULL;          // no backslash -> no dirname
+  else if (lastsep - buf <= 2 && buf[1] == ':')
+    lastsep[1] = '\0';    // can't remove backslash of "x:\"
+  else
+    *lastsep = '\0';
+  return buf;
+}
+
 // Find a real application on the path (possibly following symlinks)
 static const char *
 find_app_on_path (const char *app, bool showall = false)
@@ -821,26 +843,25 @@ find_app_on_path (const char *app, bool 
 
   if (is_symlink (fh))
     {
-      static char tmp[4000] = "";
-      char *ptr;
-      if (!readlink (fh, tmp, 3999))
+      static char tmp[SYMLINK_MAX + 1];
+      if (!readlink (fh, tmp, SYMLINK_MAX))
 	display_error("readlink failed");
-      ptr = cygpath (tmp, NULL);
-      for (char *p = ptr; (p = strchr (p, '/')); p++)
-	*p = '\\';
+      
+      /* Resolve the linkname relative to the directory of the link.  */
+      char *ptr = cygpath_rel (dirname (papp), tmp, NULL);
       printf (" -> %s\n", ptr);
       if (!strchr (ptr, '\\'))
 	{
 	  char *lastsep;
-	  strncpy (tmp, cygpath (papp, NULL), 3999);
-	  for (char *p = tmp; (p = strchr (p, '/')); p++)
-	    *p = '\\';
+	  strncpy (tmp, cygpath (papp, NULL), SYMLINK_MAX);
 	  lastsep = strrchr (tmp, '\\');
-	  strncpy (lastsep+1, ptr, 3999-(lastsep-tmp));
+	  strncpy (lastsep+1, ptr, SYMLINK_MAX - (lastsep-tmp));
 	  ptr = tmp;
 	}
       if (!CloseHandle (fh))
 	display_error ("find_app_on_path: CloseHandle()");
+      /* FIXME: We leak the ptr returned by cygpath() here which is a
+         malloc()d string.  */
       return find_app_on_path (ptr, showall);
     }
 
Index: path.cc
===================================================================
RCS file: /cvs/src/src/winsup/utils/path.cc,v
retrieving revision 1.13
diff -u -p -r1.13 path.cc
--- path.cc	9 Mar 2008 04:10:10 -0000	1.13
+++ path.cc	11 Mar 2008 15:03:37 -0000
@@ -486,26 +486,35 @@ unconvert_slashes (char* name)
     *name++ = '\\';
 }
 
+/* This is a helper function for when vcygpath is passed what appears
+   to be a relative POSIX path.  We take a Win32 CWD (either as specified
+   in 'cwd' or as retrieved with GetCurrentDirectory() if 'cwd' is NULL)
+   and find the mount table entry with the longest match.  We replace the
+   matching portion with the corresponding POSIX prefix, and to that append
+   's' and anything in 'v'.  The returned result is a mostly-POSIX
+   absolute path -- 'mostly' because the portions of CWD that didn't
+   match the mount prefix will still have '\\' separators.  */
 static char *
-rel_vconcat (const char *s, va_list v)
+rel_vconcat (const char *cwd, const char *s, va_list v)
 {
-  char path[MAX_PATH + 1];
-  if (!GetCurrentDirectory (MAX_PATH, path))
-    return NULL;
+  char pathbuf[MAX_PATH + 1];
+  if (!cwd || *cwd == '\0')
+    {
+      if (!GetCurrentDirectory (MAX_PATH, pathbuf))
+        return NULL;
+      cwd = pathbuf;
+    }
 
   int max_len = -1;
   struct mnt *m, *match = NULL;
 
-  if (s[0] == '.' && isslash (s[1]))
-    s += 2;
-
-  for (m = mount_table; m->posix ; m++)
+  for (m = mount_table; m->posix; m++)
     {
       if (m->flags & MOUNT_CYGDRIVE)
 	continue;
 
       int n = strlen (m->native);
-      if (n < max_len || !path_prefix_p (m->native, path, n))
+      if (n < max_len || !path_prefix_p (m->native, cwd, n))
 	continue;
       max_len = n;
       match = m;
@@ -514,34 +523,36 @@ rel_vconcat (const char *s, va_list v)
   char *temppath;
   if (!match)
     // No prefix matched - best effort to return meaningful value.
-    temppath = concat (path, "/", s, NULL);
+    temppath = concat (cwd, "/", s, NULL);
   else if (strcmp (match->posix, "/") != 0)
     // Matched on non-root.  Copy matching prefix + remaining 'path'.
-    temppath = concat (match->posix, path + max_len, "/", s, NULL);
-  else if (path[max_len] == '\0')
+    temppath = concat (match->posix, cwd + max_len, "/", s, NULL);
+  else if (cwd[max_len] == '\0')
     // Matched on root and there's no remaining 'path'.
     temppath = concat ("/", s, NULL);
-  else if (isslash (path[max_len]))
+  else if (isslash (cwd[max_len]))
     // Matched on root but remaining 'path' starts with a slash anyway.
-    temppath = concat (path + max_len, "/", s, NULL);
+    temppath = concat (cwd + max_len, "/", s, NULL);
   else
-    temppath = concat ("/", path + max_len, "/", s, NULL);
+    temppath = concat ("/", cwd + max_len, "/", s, NULL);
 
   char *res = vconcat (temppath, v);
   free (temppath);
   return res;
 }
 
-char *
-cygpath (const char *s, ...)
+/* Convert a POSIX path in 's' to an absolute Win32 path, and append
+   anything in 'v' to the end, returning the result.  If 's' is a
+   relative path then 'cwd' is used as the working directory to make
+   it absolute.  Pass NULL in 'cwd' to use GetCurrentDirectory.  */
+static char *
+vcygpath (const char *cwd, const char *s, va_list v)
 {
-  va_list v;
   int max_len = -1;
   struct mnt *m, *match = NULL;
 
   if (!mount_table[0].posix)
     read_mounts ();
-  va_start (v, s);
   char *path;
   if (s[0] == '.' && isslash (s[1]))
     s += 2;
@@ -549,7 +560,7 @@ cygpath (const char *s, ...)
   if (s[0] == '/' || s[1] == ':')	/* FIXME: too crude? */
     path = vconcat (s, v);
   else
-    path = rel_vconcat (s, v);
+    path = rel_vconcat (cwd, s, v);
 
   if (!path)
     return NULL;
@@ -557,7 +568,7 @@ cygpath (const char *s, ...)
   if (strncmp (path, "/./", 3) == 0)
     memmove (path + 1, path + 3, strlen (path + 3) + 1);
 
-  for (m = mount_table; m->posix ; m++)
+  for (m = mount_table; m->posix; m++)
     {
       if (m->flags & MOUNT_CYGDRIVE)
 	continue;
@@ -586,6 +597,26 @@ cygpath (const char *s, ...)
   return native;
 }
 
+char *
+cygpath_rel (const char *cwd, const char *s, ...)
+{
+  va_list v;
+
+  va_start (v, s);
+
+  return vcygpath (cwd, s, v);
+}
+
+char *
+cygpath (const char *s, ...)
+{
+  va_list v;
+  
+  va_start (v, s);
+  
+  return vcygpath (NULL, s, v);
+}
+
 static mnt *m = NULL;
 
 extern "C" FILE *
Index: path.h
===================================================================
RCS file: /cvs/src/src/winsup/utils/path.h,v
retrieving revision 1.3
diff -u -p -r1.3 path.h
--- path.h	5 Oct 2006 17:24:13 -0000	1.3
+++ path.h	11 Mar 2008 15:03:37 -0000
@@ -9,9 +9,11 @@ Cygwin license.  Please consult the file
 details. */
 
 char *cygpath (const char *s, ...);
+char *cygpath_rel (const char *cwd, const char *s, ...);
 bool is_exe (HANDLE);
 bool is_symlink (HANDLE);
 bool readlink (HANDLE, char *, int);
 int get_word (HANDLE, int);
 int get_dword (HANDLE, int);
 
+#define SYMLINK_MAX 4095  /* PATH_MAX - 1 */

--------------60FDD61B4B3160DDDA23B27E--
