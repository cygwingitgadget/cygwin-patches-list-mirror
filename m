From: Corinna Vinschen <corinna@vinschen.de>
To: cygpatch <cygwin-patches@sourceware.cygnus.com>
Subject: [RFA]: patch to rmdir 
Date: Sun, 21 May 2000 06:20:00 -0000
Message-id: <3927E038.FF38FB02@vinschen.de>
X-SW-Source: 2000-q2/msg00067.html

Hi all,

the following patch solves a problem with samba drives.
If you try to rmdir a non empty directory on a samba
drive, the windows function RemoveDirectory() returns
NO_ERROR. The directory isn't removed, of course. The
problem is solved by calling 'GetFileAttributes' after
RemoveDirectory() returns NO_ERROR. If the function
returns -1, the directory is been removed. Otherwise
a set_errno(ENOEMPTY) is raised.

Additionally I removed a superfluous `else if (error == ...)'
because that case is already handled by __seterrno().

Have a nice Sunday,
Corinna

ChangeLog:

	* dir.cc (rmdir): Check existance of directory
	after successfully called RemoveDirectoryA() to
	deal correclty with samba drives.
	Remove superfluous else branch.

Index: dir.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/dir.cc,v
retrieving revision 1.1.1.1
diff -u -p -r1.1.1.1 dir.cc
--- dir.cc      2000/02/17 19:38:31     1.1.1.1
+++ dir.cc      2000/05/21 12:58:21
@@ -319,7 +319,15 @@ rmdir (const char *dir)
     }
 
   if (RemoveDirectoryA (real_dir.get_win32 ()))
-    res = 0;
+    {
+      /* RemoveDirectory on a samba drive doesn't return an error if
the
+         directory can't be removed because it's not empty. Checking
for
+         existence afterwards keeps us informed about success. */
+      if (GetFileAttributesA (real_dir.get_win32 ()) != -1)
+        set_errno (ENOTEMPTY);
+      else
+        res = 0;
+    }
   else if (os_being_run != winNT && GetLastError() ==
ERROR_ACCESS_DENIED)
     {
       /* Under Windows 95 & 98, ERROR_ACCESS_DENIED is returned
@@ -329,8 +337,6 @@ rmdir (const char *dir)
      else
        set_errno (ENOTEMPTY);
     }
-  else if (GetLastError () == ERROR_DIRECTORY)
-    set_errno (ENOTDIR);
   else
     __seterrno ();
