From: Kazuhiro Fujieda <fujieda@jaist.ac.jp>
To: cygwin-patches@sourceware.cygnus.com
Subject: rmdir says it isn't a directory about a read only directory.
Date: Thu, 25 May 2000 00:06:00 -0000
Message-id: <s1sog5vw1l3.fsf@jaist.ac.jp>
X-SW-Source: 2000-q2/msg00083.html

rmdir() sets ENOTDIR to the errno about a read only directory
like the following.

$ mkdir aaa
$ chmod -w aaa
$ rmdir aaa
rmdir: aaa: Not a directory

The following patch can fix this problem.

2000-05-25  Kazuhiro Fujieda <fujieda@jaist.ac.jp>

	* dir.cc (rmdir): Correct the manner in checking the target directory.

Index: dir.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/dir.cc,v
retrieving revision 1.4
diff -u -p -r1.4 dir.cc
--- dir.cc	2000/05/24 20:09:43	1.4
+++ dir.cc	2000/05/25 06:36:50
@@ -341,12 +341,13 @@ rmdir (const char *dir)
       /* Under Windows 9X or on a samba share, ERROR_ACCESS_DENIED is
          returned if you try to remove a file. On 9X the same error is
          returned if you try to remove a non-empty directory. */
-     if (GetFileAttributes (real_dir.get_win32()) != FILE_ATTRIBUTE_DIRECTORY)
-       set_errno (ENOTDIR);
-     else if (os_being_run != winNT)
-       set_errno (ENOTEMPTY);
-     else
-       __seterrno ();
+      int attr = GetFileAttributes (real_dir.get_win32());
+      if (attr != -1 && !(attr & FILE_ATTRIBUTE_DIRECTORY))
+	set_errno (ENOTDIR);
+      else if (os_being_run != winNT)
+	set_errno (ENOTEMPTY);
+      else
+	__seterrno ();
     }
   else
     __seterrno ();

____
  | AIST      Kazuhiro Fujieda <fujieda@jaist.ac.jp>
  | HOKURIKU  School of Information Science
o_/ 1990      Japan Advanced Institute of Science and Technology
