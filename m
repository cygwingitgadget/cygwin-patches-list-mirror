From: Corinna Vinschen <corinna@vinschen.de>
To: cygpatch <cygwin-patches@sourceware.cygnus.com>
Subject: Re: symlink changes
Date: Sat, 01 Apr 2000 05:05:00 -0000
Message-id: <38E5F4AA.C5C4A31B@vinschen.de>
References: <38E4F407.3AB20C82@vinschen.de> <20000331150508.F1576@cygnus.com> <38E50B89.829ABC4B@vinschen.de>
X-SW-Source: 2000-q2/msg00000.html

Corinna Vinschen wrote:
> Chris Faylor wrote:
> > I believe that linux has an "lchown" call as well as a "chown" call.
> > I'd prefer to implement lchown and leave chown alone.  It would also
> > be nice to implement fchown (and fchmod?) while we're at it.

This is the patch that implements lchown and fchown. fchmod is already
existing but unistd.h didn't contain it's prototype, unfortunately.
Patch to newlib/libc/include/sys/unistd.h included.

While testing it (this change implies reconfiguring and new compiling
of fileutils) I found a surprising error in chown.c and chgrp.c:

While differentiating between changing a link or the referenced file,
both tools call `lstat' for getting owner/group information. This
gives wrong results, because both tools check out if at least the
owner or the group changes. If you then try to change the owner of
the file to the same owner as of the link, lstat returns the owner
of the link so that it doesn't call chown(2). Nothing is changed
and chown/chgrp are sure to have done the right thing. Moreover
chgrp has no option `--dereference' while the global variable
`change_symlinks' is set to 1 by default!

You will find the error in linux, too, because it's really an
error in the GNU fileutils sources.

BTW: My linux system is using fileutils-4.0 whereas our net release
preview contains fileutils-3.16. Why?

Nevertheless, the above error is in both versions. The appropriate
patch relative to 4.0 is attached, too.

Corinna
Index: newlib/ChangeLog
===================================================================
RCS file: /cvs/src/src/newlib/ChangeLog,v
retrieving revision 1.18
diff -u -p -r1.18 ChangeLog
--- ChangeLog	2000/03/24 20:42:10	1.18
+++ ChangeLog	2000/04/01 12:27:17
@@ -1,3 +1,8 @@
+Fri Mar 31 20:39:00 2000  Corinna Vinschen <corinna@vinschen.de>
+
+        * libc/include/sys/unistd.h: Add prototypes for
+        fchmod, fchown, lchown.
+
 Fri Mar 24 15:34:00 2000  Jeff Johnston  <jjohnstn@cygnus.com>
 
 	* acinclude.m4: Changed release to 1.8.2.
Index: newlib/libc/include/sys/unistd.h
===================================================================
RCS file: /cvs/src/src/newlib/libc/include/sys/unistd.h,v
retrieving revision 1.1.1.1
diff -u -p -r1.1.1.1 unistd.h
--- unistd.h	2000/02/17 19:39:46	1.1.1.1
+++ unistd.h	2000/04/01 12:27:18
@@ -30,6 +30,8 @@ int     _EXFUN(execlp, (const char *__fi
 int     _EXFUN(execv, (const char *__path, char * const __argv[] ));
 int     _EXFUN(execve, (const char *__path, char * const __argv[], char * const __envp[] ));
 int     _EXFUN(execvp, (const char *__file, char * const __argv[] ));
+int     _EXFUN(fchmod, (int __fildes, mode_t __mode ));
+int     _EXFUN(fchown, (int __fildes, uid_t __owner, gid_t __group ));
 pid_t   _EXFUN(fork, (void ));
 long    _EXFUN(fpathconf, (int __fd, int __name ));
 int     _EXFUN(fsync, (int __fd));
@@ -46,6 +48,7 @@ pid_t   _EXFUN(getpid, (void ));
 pid_t   _EXFUN(getppid, (void ));
 uid_t   _EXFUN(getuid, (void ));
 int     _EXFUN(isatty, (int __fildes ));
+int     _EXFUN(lchown, (const char *__path, uid_t __owner, gid_t __group ));
 int     _EXFUN(link, (const char *__path1, const char *__path2 ));
 int	_EXFUN(nice, (int __nice_value ));
 off_t   _EXFUN(lseek, (int __fildes, off_t __offset, int __whence ));
Index: winsup/cygwin/ChangeLog
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/ChangeLog,v
retrieving revision 1.42
diff -u -p -r1.42 ChangeLog
--- ChangeLog	2000/03/30 03:51:30	1.42
+++ ChangeLog	2000/04/01 12:27:21
@@ -1,3 +1,18 @@
+Fry Mar 31 22:55:00 2000  Corinna Vinschen <corinna@vinschen.de>
+
+        * syscall.cc (chown_worker): New static function with
+        chown functionality.
+        (chown): Call chown_worker with SYMLINK_FOLLOW.
+        (fchown): New function. Call chown_worker with SYMLINK_FOLLOW.
+        (lchown): New function. Call chown_worker with SYMLINK_IGNORE.
+        * cygwin.din: Add symbols for fchown, lchown.
+
+Fry Mar 31 11:18:00 2000  Corinna Vinschen <corinna@vinschen.de>
+
+        * path.cc (symlink): Call `set_file_attribute()' and
+        `SetFileAttributeA()' instead of `chmod()' to set
+        uid/gid correct.
+
 Wed Mar 29 22:49:56 2000  Christopher Faylor <cgf@cygnus.com>
 
 	* fhandler.h (select_record): Explicitly zero elements of this class.
Index: winsup/cygwin/cygwin.din
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/cygwin.din,v
retrieving revision 1.3
diff -u -p -r1.3 cygwin.din
--- cygwin.din	2000/03/07 05:33:09	1.3
+++ cygwin.din	2000/04/01 12:27:24
@@ -186,6 +186,8 @@ _f_atan2f
 __f_atan2f = _f_atan2f
 fchmod
 _fchmod = fchmod
+fchown
+_fchown = fchown
 fclose
 _fclose = fclose
 fcntl
@@ -425,6 +427,8 @@ kill
 _kill = kill
 labs
 _labs = labs
+lchown
+_lchown = lchown
 ldexp
 _ldexp = ldexp
 ldexpf
Index: winsup/cygwin/path.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/path.cc,v
retrieving revision 1.5
diff -u -p -r1.5 path.cc
--- path.cc	2000/03/28 21:49:16	1.5
+++ path.cc	2000/04/01 12:27:31
@@ -2048,7 +2048,10 @@ symlink (const char *topath, const char 
       else
 	{
 	  CloseHandle (h);
-	  chmod (frompath, S_IFLNK | S_IRWXU | S_IRWXG | S_IRWXO);
+          set_file_attribute (win32_path.has_acls (),
+                              win32_path.get_win32 (),
+                              S_IFLNK | S_IRWXU | S_IRWXG | S_IRWXO);
+          SetFileAttributesA (win32_path.get_win32 (), FILE_ATTRIBUTE_SYSTEM);
 	  res = 0;
 	}
     }
Index: winsup/cygwin/syscalls.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/syscalls.cc,v
retrieving revision 1.11
diff -u -p -r1.11 syscalls.cc
--- syscalls.cc	2000/03/28 21:49:16	1.11
+++ syscalls.cc	2000/04/01 12:27:33
@@ -641,13 +641,9 @@ rel2abssd (PSECURITY_DESCRIPTOR psd_rel,
 /*
  * chown() is only implemented for Windows NT.  Under other operating
  * systems, it is only a stub that always returns zero.
- *
- * Note: the SetFileSecurity API in NT can only set the current
- * user as file owner so we have to use the Backup API instead.
  */
-extern "C"
-int
-chown (const char * name, uid_t uid, gid_t gid)
+static int
+chown_worker (const char *name, symlink_follow fmode, uid_t uid, gid_t gid)
 {
   int res;
 
@@ -656,7 +652,7 @@ chown (const char * name, uid_t uid, gid
   else
     {
       /* we need Win32 path names because of usage of Win32 API functions */
-      path_conv win32_path (name);
+      path_conv win32_path (name, fmode);
 
       if (win32_path.error)
 	{
@@ -676,9 +672,7 @@ chown (const char * name, uid_t uid, gid
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
@@ -696,8 +690,48 @@ chown (const char * name, uid_t uid, gid
     }
 
 done:
-  syscall_printf ("%d = chown (%s,...)", res, name);
+  syscall_printf ("%d = %schown (%s,...)",
+                  res, fmode == SYMLINK_IGNORE ? "l" : "", name);
   return res;
+}
+
+extern "C"
+int
+chown (const char * name, uid_t uid, gid_t gid)
+{
+  return chown_worker (name, SYMLINK_FOLLOW, uid, gid);
+}
+
+extern "C"
+int
+lchown (const char * name, uid_t uid, gid_t gid)
+{
+  return chown_worker (name, SYMLINK_IGNORE, uid, gid);
+}
+
+extern "C"
+int
+fchown (int fd, uid_t uid, gid_t gid)
+{
+  if (dtable.not_open (fd))
+    {
+      syscall_printf ("-1 = fchown (%d,...)", fd);
+      set_errno (EBADF);
+      return -1;
+    }
+
+  const char *path = dtable[fd]->get_name ();
+
+  if (path == NULL)
+    {
+      syscall_printf ("-1 = fchown (%d,...) (no name)", fd);
+      set_errno (ENOSYS);
+      return -1;
+    }
+
+  syscall_printf ("fchown (%d,...): calling chown_worker (%s,FOLLOW,...)",
+                  fd, path);
+  return chown_worker (path, SYMLINK_FOLLOW, uid, gid);
 }
 
 /* umask: POSIX 5.3.3.1 */
