From: Corinna Vinschen <corinna@vinschen.de>
To: cygpatch <cygwin-patches@sourceware.cygnus.com>
Subject: symlink changes
Date: Fri, 31 Mar 2000 10:49:00 -0000
Message-id: <38E4F407.3AB20C82@vinschen.de>
X-SW-Source: 2000-q1/msg00028.html

Hi Chris,
Hi all,

I have a patch here that solves two different problems with symlinks:

- Since the latest big ntsec patch (early this year) the owner/group
  information wasn't set to the correct values that are given by the
  settings in /etc/passwd and /etc/group. I have patched this.

- The other problem was that in chown the path was evaluated with
  SYMLINK_FOLLOW. This isn't the same behaviour as under linux.
  I have patched it, so that now a chown on a symlink changes
  user/group of the symlink instead of the linked file, equal to
  linux. This is done by using SYMLINK_IGNORE as parameter to
  path_conv.

Do you agree?

Corinna
Index: ChangeLog
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/ChangeLog,v
retrieving revision 1.42
diff -u -p -r1.42 ChangeLog
--- ChangeLog	2000/03/30 03:51:30	1.42
+++ ChangeLog	2000/03/31 18:37:54
@@ -1,3 +1,12 @@
+Fry Mar 31 11:18:00 2000  Corinna Vinschen <corinna@vinschen.de>
+
+        * path.cc (symlink): Call `set_file_attribute()' and
+        `SetFileAttributeA()' instead of `chmod()' to set
+        uid/gid correct.
+        * syscall.cc (chown): Get path with SYMLINK_IGNORE to
+        set owner/group of link instead of link target.
+        Eliminate local variable `has_acls'.
+
 Wed Mar 29 22:49:56 2000  Christopher Faylor <cgf@cygnus.com>
 
 	* fhandler.h (select_record): Explicitly zero elements of this class.
Index: path.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/path.cc,v
retrieving revision 1.5
diff -u -p -r1.5 path.cc
--- path.cc	2000/03/28 21:49:16	1.5
+++ path.cc	2000/03/31 18:38:01
@@ -2048,7 +2048,10 @@ symlink (const char *topath, const char 
       else
 	{
 	  CloseHandle (h);
-	  chmod (frompath, S_IFLNK | S_IRWXU | S_IRWXG | S_IRWXO);
+	  set_file_attribute (win32_path.has_acls (),
+	                      win32_path.get_win32 (),
+                              S_IFLNK | S_IRWXU | S_IRWXG | S_IRWXO);
+          SetFileAttributesA (win32_path.get_win32 (), FILE_ATTRIBUTE_SYSTEM);
 	  res = 0;
 	}
     }
Index: syscalls.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/syscalls.cc,v
retrieving revision 1.11
diff -u -p -r1.11 syscalls.cc
--- syscalls.cc	2000/03/28 21:49:16	1.11
+++ syscalls.cc	2000/03/31 18:38:06
@@ -656,7 +656,7 @@ chown (const char * name, uid_t uid, gid
   else
     {
       /* we need Win32 path names because of usage of Win32 API functions */
-      path_conv win32_path (name);
+      path_conv win32_path (name, SYMLINK_IGNORE);
 
       if (win32_path.error)
 	{
@@ -676,9 +676,7 @@ chown (const char * name, uid_t uid, gid
       DWORD attrib = 0;
       if (win32_path.file_attributes () & FILE_ATTRIBUTE_DIRECTORY)
         attrib |= S_IFDIR;
-      int has_acls;
-      has_acls = allow_ntsec && win32_path.has_acls ();
-      res = get_file_attribute (has_acls,
+      res = get_file_attribute (win32_path.has_acls (),
                                 win32_path.get_win32 (),
                                 (int *) &attrib);
       if (!res)
