From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygpatch <cygwin-patches@cygwin.com>, newlib@sources.redhat.com
Subject: [PATCH]: (f)pathconf/unistd.h, _PC_POSIX_PERMISSIONS and _PC_POSIX_SECURITY
Date: Sat, 17 Mar 2001 10:24:00 -0000
Message-id: <20010317192444.R20900@cygbert.vinschen.de>
X-SW-Source: 2001-q1/msg00198.html

Hi,

I have added two new values to the Cygwin pathconf and fpathconf system
calls.

	pathconf (filename, _PC_POSIX_PERMISSONS)
	fpathconf (fd, _PC_POSIX_PERMISSONS)

return 1 if the underlying file system supports POSIX permission bits.
That's true if the OS is NT/W2K and either CYGWIN=ntea is given or
CYGWIN=ntsec and GetVolumeInformation returns FS_PERSISTENT_ACLS in it's
flags.
Otherwise it returns 0.

        pathconf (filename, _PC_POSIX_SECURITY)
	fpathconf (fd, _PC_POSIX_SECURITY)

return 1 if the underlying file system supports POSIX permissions
and user and group ownership of files. That's true only if CYGWIN=ntsec
and GetVolumeInformation returns FS_PERSISTENT_ACLS.
Otherwise the call returns 0.

If nobody complains, I will check in that change on Monday.

Corinna

ChangeLog for newlib:
=====================

Sat Mar 17 18:30:00 2001  Corinna Vinschen <corinna@vinschen.de>

	* libc/include/sys/unistd.h: Add _PC_POSIX_PERMISSONS and
	_PC_POSIX_SECURITY constants for Cygwin.

ChangeLog for cygwin:
=====================

Sat Mar 17 18:30:00 2001  Corinna Vinschen <corinna@vinschen.de>

	* syscalls.cc (check_posix_perm): New static function.
	(fpathconf): Add _PC_POSIX_PERMISSIONS and _PC_POSIX_SECURITY
	support.
	(pathconf): Ditto.
	* include/cygwin/version.h: Bump API minor number to 37.

Index: newlib/libc/include/sys/unistd.h
===================================================================
RCS file: /cvs/src/src/newlib/libc/include/sys/unistd.h,v
retrieving revision 1.17
diff -u -p -r1.17 unistd.h
--- unistd.h	2001/03/06 01:04:42	1.17
+++ unistd.h	2001/03/17 18:17:34
@@ -228,6 +228,12 @@ extern const unsigned _cygwin_X_OK;
 # define	_PC_ASYNC_IO            9
 # define	_PC_PRIO_IO            10
 # define	_PC_SYNC_IO            11
+#ifdef __CYGWIN__
+/* Ask for POSIX permission bits support. */
+# define	_PC_POSIX_PERMISSIONS   90
+/* Ask for full POSIX permission support including uid/gid settings. */
+# define	_PC_POSIX_SECURITY     91
+#endif
 
 /* FIXME: This is temporary until winsup gets sorted out.  */
 #ifdef __CYGWIN__
Index: winsup/cygwin/syscalls.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/syscalls.cc,v
retrieving revision 1.93
diff -u -p -r1.93 syscalls.cc
--- syscalls.cc	2001/03/17 05:11:20	1.93
+++ syscalls.cc	2001/03/17 18:17:36
@@ -1428,6 +1428,40 @@ getpagesize ()
   return (int) system_info.dwPageSize;
 }
 
+static int
+check_posix_perm (const char *fname, int v)
+{
+  extern int allow_ntea, allow_ntsec, allow_smbntsec;
+
+  /* Windows 95/98/ME don't support file system security at all. */
+  if (os_being_run != winNT)
+    return 0;
+
+  /* ntea is ok for supporting permission bits but it doesn't support
+     full POSIX security settings. */
+  if (v == _PC_POSIX_PERMISSIONS && allow_ntea)
+    return 1;
+
+  if (!allow_ntsec)
+    return 0;
+
+  char *root = rootdir (strcpy ((char *)alloca (strlen (fname)), fname));
+
+  if (!allow_smbntsec
+      && ((root[0] == '\\' && root[1] == '\\')
+          || GetDriveType (root) == DRIVE_REMOTE))
+    return 0;
+
+  DWORD vsn, len, flags;
+  if (!GetVolumeInformation (root, NULL, 0, &vsn, &len, &flags, NULL, 16))
+    {
+      __seterrno ();
+      return 0;
+    }
+
+  return (flags & FS_PERSISTENT_ACLS) ? 1 : 0;
+}
+
 /* FIXME: not all values are correct... */
 extern "C" long int
 fpathconf (int fd, int v)
@@ -1461,6 +1495,18 @@ fpathconf (int fd, int v)
 	  set_errno (EBADF);
 	  return -1;
 	}
+    case _PC_POSIX_PERMISSIONS:
+    case _PC_POSIX_SECURITY:
+      if (fdtab.not_open (fd))
+	set_errno (EBADF);
+      else
+        {
+          fhandler_base *fh = fdtab[fd];
+	  if (fh->get_device () == FH_DISK)
+	    return check_posix_perm (fh->get_win32_name (), v);
+	  set_errno (EINVAL);
+        }
+      return -1;
     default:
       set_errno (EINVAL);
       return -1;
@@ -1480,14 +1526,30 @@ pathconf (const char *file, int v)
       return _POSIX_LINK_MAX;
     case _PC_MAX_CANON:
     case _PC_MAX_INPUT:
-	return _POSIX_MAX_CANON;
+      return _POSIX_MAX_CANON;
     case _PC_PIPE_BUF:
       return 4096;
     case _PC_CHOWN_RESTRICTED:
     case _PC_NO_TRUNC:
       return -1;
     case _PC_VDISABLE:
-	return -1;
+      return -1;
+    case _PC_POSIX_PERMISSIONS:
+    case _PC_POSIX_SECURITY:
+      {
+        path_conv full_path (file, PC_SYM_FOLLOW | PC_FULL);
+	if (full_path.error)
+	  {
+	    set_errno (full_path.error);
+	    return -1;
+	  }
+	if (full_path.is_device ())
+	  {
+	    set_errno (EINVAL);
+	    return -1;
+	  }
+        return check_posix_perm (full_path, v);
+      }
     default:
       set_errno (EINVAL);
       return -1;
Index: winsup/cygwin/include/cygwin/version.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/cygwin/version.h,v
retrieving revision 1.32
diff -u -p -r1.32 version.h
--- version.h	2001/03/05 06:28:24	1.32
+++ version.h	2001/03/17 18:17:36
@@ -130,10 +130,11 @@ details. */
        35: Export drand48, erand48, jrand48, lcong48, lrand48,
            mrand48, nrand48, seed48, and srand48.
        36: Added _cygwin_S_IEXEC, et al
+       37: [f]pathconv support _PC_POSIX_PERMISSIONS and _PC_POSIX_SECURITY
      */
 
 #define CYGWIN_VERSION_API_MAJOR 0
-#define CYGWIN_VERSION_API_MINOR 36
+#define CYGWIN_VERSION_API_MINOR 37
 
      /* There is also a compatibity version number associated with the
 	shared memory regions.  It is incremented when incompatible

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
