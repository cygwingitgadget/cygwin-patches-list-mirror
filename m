From: Corinna Vinschen <corinna@vinschen.de>
To: cygpatch <cygwin-patches@sourceware.cygnus.com>
Subject: Files with system bit set.
Date: Mon, 08 May 2000 14:00:00 -0000
Message-id: <3917298E.821F9CE5@vinschen.de>
X-SW-Source: 2000-q2/msg00042.html

Hi,

I want to suggest the following patch.

Problem:
Files with system attribute set are opened to see if they
are symlinks. If the file can't be opened by the caller,
an error is returned to the application:

	$ cmd /c attrib foo
	A S foo
	$ ls -l foo
	--wx------ 1 corinna users [...] foo
	$ chmod 666 foo
	chmod: foo: Bad file number.

Reason:
When CreateFileA in symlink::info() fails, errno is set
and the function is left.

This seems to be not correct because symlinks are readable
for everyone in UX like systems as in cygwin:

	-rwxrwxrwx 1 corinna users [...] sl_foo -> foo

Solution:
Treat the file as a non symlink file.

Corinna


ChangeLog:
==========

	* path.cc (symlink::info): Treat non readable files
	as normal non symlink files.
Index: path.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/path.cc,v
retrieving revision 1.20
diff -u -p -r1.20 path.cc
--- path.cc	2000/05/04 19:46:32	1.20
+++ path.cc	2000/05/08 20:38:29
@@ -2177,7 +2177,7 @@ symlink_info::check (const char *in_path
 		       FILE_ATTRIBUTE_NORMAL, 0);
       res = -1;
       if (h == INVALID_HANDLE_VALUE)
-	__seterrno ();
+	goto file_not_symlink;
       else
 	{
 	  char cookie_buf[sizeof (SYMLINK_COOKIE) - 1];
