From: Chris Faylor <cgf@cygnus.com>
To: Corinna Vinschen <corinna@vinschen.de>
Cc: cygpatch <cygwin-patches@sourceware.cygnus.com>
Subject: Re: fhandler.cc patch
Date: Sun, 20 Feb 2000 15:02:00 -0000
Message-id: <20000220180206.B8249@cygnus.com>
References: <38B071E7.4E71774C@vinschen.de>
X-SW-Source: 2000-q1/msg00001.html

Thanks for being the first tester of this new method.

Feel free to check this in.

-chris

On Sun, Feb 20, 2000 at 11:59:51PM +0100, Corinna Vinschen wrote:
>this is the small patch that solves a problem when get_file_attribute
>returns write permissions while FILE_ATTRIBUTE_READONLY is set.
>The patch removes the write bits from st_mode in this case.
>
>Corinna
>Index: fhandler.cc
>===================================================================
>RCS file: /cvs/src/src/winsup/cygwin/fhandler.cc,v
>retrieving revision 1.1.1.1
>diff -u -p -u -p -r1.1.1.1 fhandler.cc
>--- fhandler.cc	2000/02/17 19:38:31	1.1.1.1
>+++ fhandler.cc	2000/02/20 22:55:14
>@@ -950,6 +950,10 @@ fhandler_disk_file::fstat (struct stat *
>     buf->st_mode |= S_IFDIR;
>   if (! get_file_attribute (has_acls (), get_win32_name (), &buf->st_mode))
>     {
>+      /* If read-only attribute is set, modify ntsec return value */
>+      if (local.dwFileAttributes & FILE_ATTRIBUTE_READONLY)
>+	buf->st_mode &= ~(S_IWUSR | S_IWGRP | S_IWOTH);
>+
>       buf->st_mode &= ~S_IFMT;
>       if (get_symlink_p ())
> 	buf->st_mode |= S_IFLNK;
>Index: ChangeLog
>===================================================================
>RCS file: /cvs/src/src/winsup/cygwin/ChangeLog,v
>retrieving revision 1.1.1.1
>diff -u -p -u -p -r1.1.1.1 ChangeLog
>--- ChangeLog	2000/02/17 19:38:31	1.1.1.1
>+++ ChangeLog	2000/02/20 22:55:14
>@@ -1,3 +1,8 @@
>+Sun Feb 18 21:31:00 2000  Corinna Vinschen <corinna@vinschen.de>
>+
>+        * fhandler.cc (fhandler_disk_file::fstat): Modify get_file_attribute
>+        return value if FILE_ATTRIBUTE_READONLY is set.
>+
> Mon Feb  7 16:50:44 2000  Christopher Faylor <cgf@cygnus.com>
> 
> 	* Makefile.in: cygrun needs libshell32.a.
