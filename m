From: Corinna Vinschen <corinna@vinschen.de>
To: cygpatch <cygwin-patches@sourceware.cygnus.com>
Subject: [RFA]: patch to 'rename', was Re: Wierd patch problem + simple fix
Date: Mon, 22 May 2000 02:50:00 -0000
Message-id: <3928FF7A.B4402B9C@vinschen.de>
References: <392633C8.4B20FBE5@ece.gatech.edu> <20000520215546.E2054@cygnus.com> <39277F56.43288E5E@ece.gatech.edu> <3927DD35.C31AC4AA@vinschen.de> <20000521183456.B1386@cygnus.com>
X-SW-Source: 2000-q2/msg00069.html

Chris Faylor wrote:
> 
> On Sun, May 21, 2000 at 02:57:25PM +0200, Corinna Vinschen wrote:
> >I'm completely unable to reproduce that problem...
> >
> >...as far as the $TMP directory is on the same drive
> >   as the patched file!
> >[...]
> But I really can't believe that this is a generic patch bug.
> /tmp is often located on a different partition than a 'src'
> directory and it is hard to believe that this could be broken
> in patch.
> 
> Is it possible that some stat (st_dev maybe?) field has changed
> recently?

I have investigated that phenomenon and I found that
`MoveFile' returns ERROR_FILE_EXISTS while our `rename'
code checks only for ERROR_ALREADY_EXISTS. Perhaps the return
code is OS dependent? I'm testing mainly on W2K.

I have attached a patch for _rename so that it checks for
both return codes. If there are no objections, I will
commit it today.

Corinna

ChangeLog:
==========

	* syscalls.cc (_rename): Additionally check for ERROR_FILE_EXISTS
	if MoveFile fails.
Index: syscalls.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/syscalls.cc,v
retrieving revision 1.25
diff -u -p -r1.25 syscalls.cc
--- syscalls.cc	2000/05/19 17:15:02	1.25
+++ syscalls.cc	2000/05/22 09:35:29
@@ -1231,7 +1231,8 @@ _rename (const char *oldpath, const char
   if (!MoveFile (real_old.get_win32 (), real_new.get_win32 ()))
     res = -1;
 
-  if (res == 0 || GetLastError () != ERROR_ALREADY_EXISTS)
+  if (res == 0 || (GetLastError () != ERROR_ALREADY_EXISTS
+                   && GetLastError () != ERROR_FILE_EXISTS))
     goto done;
 
   if (os_being_run == winNT)
