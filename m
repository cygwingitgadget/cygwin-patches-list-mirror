From: Chris Faylor <cgf@cygnus.com>
To: cygpatch <cygwin-patches@sourceware.cygnus.com>
Subject: Re: [RFA]: patch to rmdir
Date: Sun, 21 May 2000 15:41:00 -0000
Message-id: <20000521184132.E1386@cygnus.com>
References: <3927E038.FF38FB02@vinschen.de>
X-SW-Source: 2000-q2/msg00068.html

Does this fix the erroneous error when you do a:

rmdir somefilethatisnotadirectory

too?

cgf

On Sun, May 21, 2000 at 03:10:16PM +0200, Corinna Vinschen wrote:
>Hi all,
>
>the following patch solves a problem with samba drives.
>If you try to rmdir a non empty directory on a samba
>drive, the windows function RemoveDirectory() returns
>NO_ERROR. The directory isn't removed, of course. The
>problem is solved by calling 'GetFileAttributes' after
>RemoveDirectory() returns NO_ERROR. If the function
>returns -1, the directory is been removed. Otherwise
>a set_errno(ENOEMPTY) is raised.
>
>Additionally I removed a superfluous `else if (error == ...)'
>because that case is already handled by __seterrno().
>
>Have a nice Sunday,
>Corinna
>
>ChangeLog:
>
>	* dir.cc (rmdir): Check existance of directory
>	after successfully called RemoveDirectoryA() to
>	deal correclty with samba drives.
>	Remove superfluous else branch.
>
>Index: dir.cc
>===================================================================
>RCS file: /cvs/src/src/winsup/cygwin/dir.cc,v
>retrieving revision 1.1.1.1
>diff -u -p -r1.1.1.1 dir.cc
>--- dir.cc      2000/02/17 19:38:31     1.1.1.1
>+++ dir.cc      2000/05/21 12:58:21
>@@ -319,7 +319,15 @@ rmdir (const char *dir)
>     }
> 
>   if (RemoveDirectoryA (real_dir.get_win32 ()))
>-    res = 0;
>+    {
>+      /* RemoveDirectory on a samba drive doesn't return an error if
>the
>+         directory can't be removed because it's not empty. Checking
>for
>+         existence afterwards keeps us informed about success. */
>+      if (GetFileAttributesA (real_dir.get_win32 ()) != -1)
>+        set_errno (ENOTEMPTY);
>+      else
>+        res = 0;
>+    }
>   else if (os_being_run != winNT && GetLastError() ==
>ERROR_ACCESS_DENIED)
>     {
>       /* Under Windows 95 & 98, ERROR_ACCESS_DENIED is returned
>@@ -329,8 +337,6 @@ rmdir (const char *dir)
>      else
>        set_errno (ENOTEMPTY);
>     }
>-  else if (GetLastError () == ERROR_DIRECTORY)
>-    set_errno (ENOTDIR);
>   else
>     __seterrno ();

-- 
cgf@cygnus.com                        Cygnus Solutions, a Red Hat company
http://sourceware.cygnus.com/         http://www.redhat.com/
