From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygpatch <cygwin-patches@cygwin.com>
Subject: [RFD, PATCH]: Set "hidden" attribute when creating files/dirs/symlinks with trailing dot
Date: Sun, 11 Nov 2001 16:53:00 -0000
Message-ID: <20011112014116.B2618@cygbert.vinschen.de>
X-SW-Source: 2001-q4/msg00199.html
Message-ID: <20011111165300.KjL0QdoRlIx_fvXkMvk9xl_XoaGlYpiZilLrIb6__lg@z>

Hi,

I thought it would be a good idea to ask for your opinion on that
patch first.

As you all know, files with a trailing dot are hidden in the output
of e.g. `ls' unless you give explicitely the -a option.  That's a
good thing IMO (even if some people alias `ls' to `ls -a') since
it doesn't show the whole lot of option files when listing the
home dir.

The Windows explorer since 98/W2K has a global setting called
"[Do not] show hidden files and folders" which hides files with
FILE_ATTRIBUTE_HIDDEN attribute set, if set.  It's set to
"Do not ..." by default as it's for the `ls' command with dot files.

My idea was, why don't we just set the "hidden" attribute when we
create a file/directory/symlink beginning with a dot?
Now Explorer doesn't show these files and behaves so by default
like `ls'.

The below patch adds the appropriate setting of FILE_ATTRIBUTE_HIDDEN.

What's your opinion on such a change?

Corinna


2001-11-12  Corinna Vinschen <corinna@vinschen.de>

	* dir.cc (mkdir): Set FILE_ATTRIBUTE_HIDDEN if directory name
	has a trailing dot.
	* fhandler.cc (fhandler_base::open): Set FILE_ATTRIBUTE_HIDDEN
	if file is a disk file and its name has a trailing dot.
	* path.cc (symlink): Set FILE_ATTRIBUTE_HIDDEN if symlink name
	has a trailing dot.
	* syscalls.cc (_rename): Set or reset FILE_ATTRIBUTE_HIDDEN
	according to file name has or has not a trailing dot.

Index: dir.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/dir.cc,v
retrieving revision 1.50
diff -u -p -r1.50 dir.cc
--- dir.cc	2001/11/05 06:09:06	1.50
+++ dir.cc	2001/11/12 00:33:02
@@ -340,6 +340,9 @@ mkdir (const char *dir, mode_t mode)
       if (!allow_ntsec && allow_ntea)
 	set_file_attribute (real_dir.has_acls (), real_dir.get_win32 (),
 			    S_IFDIR | ((mode & 07777) & ~cygheap->umask));
+      char *c = strrchr (real_dir.get_win32 (), '\\');
+      if ((c && c[1] == '.') || *real_dir.get_win32 () == '.')
+        SetFileAttributes (real_dir.get_win32 (), FILE_ATTRIBUTE_HIDDEN);
       res = 0;
     }
   else
Index: fhandler.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler.cc,v
retrieving revision 1.104
diff -u -p -r1.104 fhandler.cc
--- fhandler.cc	2001/11/05 06:09:07	1.104
+++ fhandler.cc	2001/11/12 00:33:03
@@ -371,6 +371,13 @@ fhandler_base::open (path_conv *, int fl
   if (get_device () == FH_SERIAL)
     file_attributes |= FILE_FLAG_OVERLAPPED;
 
+  if (flags & O_CREAT && get_device () == FH_DISK)
+    {
+      char *c = strrchr (get_win32_name (), '\\');
+      if ((c && c[1] == '.') || *get_win32_name () == '.')
+        file_attributes |= FILE_ATTRIBUTE_HIDDEN;
+    }
+
   /* CreateFile() with dwDesiredAccess == 0 when called on remote
      share returns some handle, even if file doesn't exist. This code
      works around this bug. */
Index: path.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/path.cc,v
retrieving revision 1.180
diff -u -p -r1.180 path.cc
--- path.cc	2001/11/05 06:09:07	1.180
+++ path.cc	2001/11/12 00:33:05
@@ -2605,9 +2605,9 @@ symlink (const char *topath, const char 
 			    &sa, alloca (4096), 4096);
 
   h = CreateFileA(win32_path, GENERIC_WRITE, 0, &sa,
-		  CREATE_NEW, FILE_ATTRIBUTE_NORMAL, 0);
+  		  CREATE_NEW, FILE_ATTRIBUTE_NORMAL, 0);
   if (h == INVALID_HANDLE_VALUE)
-      __seterrno ();
+    __seterrno ();
   else
     {
       BOOL success;
@@ -2651,9 +2651,14 @@ symlink (const char *topath, const char 
 	    set_file_attribute (win32_path.has_acls (),
 				win32_path.get_win32 (),
 				S_IFLNK | S_IRWXU | S_IRWXG | S_IRWXO);
-	  SetFileAttributesA (win32_path.get_win32 (),
-			      allow_winsymlinks ? FILE_ATTRIBUTE_READONLY
-						: FILE_ATTRIBUTE_SYSTEM);
+
+	  DWORD attr = allow_winsymlinks ? FILE_ATTRIBUTE_READONLY
+	  				 : FILE_ATTRIBUTE_SYSTEM;
+	  cp = strrchr (win32_path, '\\');
+	  if ((cp && cp[1] == '.') || *win32_path == '.')
+	    attr |= FILE_ATTRIBUTE_HIDDEN;
+	  SetFileAttributesA (win32_path.get_win32 (), attr);
+
 	  if (win32_path.fs_fast_ea ())
 	    set_symlink_ea (win32_path, topath);
 	  res = 0;
Index: syscalls.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/syscalls.cc,v
retrieving revision 1.172
diff -u -p -r1.172 syscalls.cc
--- syscalls.cc	2001/11/08 17:49:52	1.172
+++ syscalls.cc	2001/11/12 00:33:06
@@ -1240,7 +1240,14 @@ done:
   else
     {
       /* make the new file have the permissions of the old one */
-      SetFileAttributes (real_new, real_old);
+      DWORD attr = real_old;
+      char *c = strrchr (real_old.get_win32 (), '\\');
+      if ((c && c[1] == '.') || *real_old.get_win32 () == '.')
+        attr &= ~FILE_ATTRIBUTE_HIDDEN;
+      c = strrchr (real_new.get_win32 (), '\\');
+      if ((c && c[1] == '.') || *real_new.get_win32 () == '.')
+        attr |= FILE_ATTRIBUTE_HIDDEN;
+      SetFileAttributes (real_new, attr);
 
       /* Shortcut hack, No. 2, part 2 */
       /* if the new filename was an existing shortcut, remove it now if the

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
