From: Chris Faylor <cgf@cygnus.com>
To: cygpatch <cygwin-patches@sourceware.cygnus.com>
Subject: Re: Updated symlink patch [was Re: symlink changes]
Date: Sun, 02 Apr 2000 11:42:00 -0000
Message-id: <20000402144209.A23290@cygnus.com>
References: <38E4F407.3AB20C82@vinschen.de> <20000331150508.F1576@cygnus.com> <38E50B89.829ABC4B@vinschen.de> <38E5F4AA.C5C4A31B@vinschen.de> <38E76C9E.F76F92A9@vinschen.de>
X-SW-Source: 2000-q2/msg00004.html

This looks good.  Go ahead and check this in.

Btw, the convention is to just include the ChangeLog entry.  You don't include
a diff of the ChangeLog entry, just the ChanegLog entry itself.

cgf

On Sun, Apr 02, 2000 at 05:51:58PM +0200, Corinna Vinschen wrote:
>Corinna Vinschen wrote:
>> This is the patch that implements lchown and fchown. fchmod is already
>> existing but unistd.h didn't contain it's prototype, unfortunately.
>> Patch to newlib/libc/include/sys/unistd.h included.
>> [...]
>
>I have updated the patch. Now if the owner or group is specified as -1,
>then that ID is not changed.
>
>I have tried to compile fileutils-4.0 under cygwin and it seems to
>be no problem.
>
>Corinna
>Index: newlib/ChangeLog
>===================================================================
>RCS file: /cvs/src/src/newlib/ChangeLog,v
>retrieving revision 1.18
>diff -u -p -r1.18 ChangeLog
>--- ChangeLog	2000/03/24 20:42:10	1.18
>+++ ChangeLog	2000/04/02 14:47:08
>@@ -1,3 +1,8 @@
>+Fri Mar 31 20:39:00 2000  Corinna Vinschen <corinna@vinschen.de>
>+
>+        * libc/include/sys/unistd.h: Add prototypes for
>+        fchmod, fchown, lchown.
>+
> Fri Mar 24 15:34:00 2000  Jeff Johnston  <jjohnstn@cygnus.com>
> 
> 	* acinclude.m4: Changed release to 1.8.2.
