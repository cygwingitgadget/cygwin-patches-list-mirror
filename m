From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: rename() doesn't set the errno properly.
Date: Sat, 10 Mar 2001 12:25:00 -0000
Message-id: <20010310152516.A1578@redhat.com>
References: <s1s3dclqux8.fsf@jaist.ac.jp>
X-SW-Source: 2001-q1/msg00165.html

Thanks for finding this.  I checked in a variation of this patch
along with an additional errno setting for when the directory was
not writable.

cgf

On Sun, Mar 11, 2001 at 04:35:15AM +0900, Kazuhiro Fujieda wrote:
>rename() doesn't set the errno when an old path doesn't exist.
>The following patch can solve this problem.
>

>2001-03-11  Kazuhiro Fujieda  <fujieda@jaist.ac.jp>
>
>	* syscalls.cc (_rename): Set errno to ENOENT when an old path
>	doesn't exist.

>Index: syscalls.cc
>===================================================================
>RCS file: /cvs/src/src/winsup/cygwin/syscalls.cc,v
>retrieving revision 1.88
>diff -u -p -r1.88 syscalls.cc
>--- syscalls.cc	2001/03/07 20:52:33	1.88
>+++ syscalls.cc	2001/03/10 19:30:12
>@@ -1307,8 +1307,9 @@ _rename (const char *oldpath, const char
> 
>   if (real_old.file_attributes () == (DWORD) -1) /* file to move doesn't exist */
>     {
>-       syscall_printf ("file to move doesn't exist");
>-       return (-1);
>+      set_errno (ENOENT);
>+      syscall_printf ("file to move doesn't exist");
>+      return (-1);
>     }
> 
>   if (real_new.file_attributes () != (DWORD) -1 &&

>____
>  | AIST      Kazuhiro Fujieda <fujieda@jaist.ac.jp>
>  | HOKURIKU  School of Information Science
>o_/ 1990      Japan Advanced Institute of Science and Technology


-- 
cgf@cygnus.com                        Red Hat, Inc.
http://sources.redhat.com/            http://www.redhat.com/
