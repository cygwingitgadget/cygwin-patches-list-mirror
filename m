Return-Path: <cygwin-patches-return-1562-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 28351 invoked by alias); 4 Dec 2001 08:04:09 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 27990 invoked from network); 4 Dec 2001 08:04:05 -0000
Date: Thu, 01 Nov 2001 18:33:00 -0000
From: egor duda <deo@logos-m.ru>
X-Mailer: The Bat! (v1.53 RC/4)
Reply-To: egor duda <cygwin-patches@cygwin.com>
Organization: deo
X-Priority: 3 (Normal)
Message-ID: <148311448228.20011204110345@logos-m.ru>
To: Christopher Faylor <cygwin-patches@cygwin.com>
Subject: Re: cygwin Changes to Rename (Novell and CVS)
In-Reply-To: <20011204043110.GA10165@redhat.com>
References: <CAEIIBEHOJELFDAHENHIOEHFCIAA.neil.erskine@jjmackay.ca>
 <20011002235602.B16572@redhat.com> <20011204043110.GA10165@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2001-q4/txt/msg00094.txt.bz2

Hi!

Tuesday, 04 December, 2001 Christopher Faylor cgf@redhat.com wrote:

CF> No feedback at all?

two small concerns and one big one:

the patch still relies on the old way to check for OS capabilities
instead of using wincap class.

setting to TRUE or FALSE values via (1 == 0) and (1 == 1) is a bit
confusing too.

and the main objection, i don't like the parts of code that first call
DeleteFile() and then try to move old file to the new location. it's
not atomic, and rename is frequently used in scripts as "atomic"
operation. and, more important, what if delete succeeds and latter
move fails? i'd be not good.

CF> On Tue, Oct 02, 2001 at 11:56:02PM -0400, Christopher Faylor wrote:
>>This patch is almost a month old.  Has anyone had a chance to review it?
>>
>>Obviously there have been some changes to cygwin since this code was
>>first introduced (I just made one recently, in fact) but I'd like to know
>>if everyone thinks this is an acceptable way to go.
>>
>>Any thoughts?
>>
>>cgf
>>
>>On Fri, Sep 07, 2001 at 12:17:31AM -0300, Neil Erskine wrote:
>>>The combination of Novell 5.1 with its current clients does not allow
>>>"rename" as included in the 1.3.2 cygwin distribution to work correctly.
>>>Unfortunately, different client/OS combinations seem to return different
>>>error codes, and invoke different paths through rename, so the work arounds
>>>for this are less than elegant.  None-the-less, the attached patch to rename
>>>is the best I have come up with.  It works on NT 4.0, Windows 2000, Windows
>>>95 and Windows 98.  I have not tried Windows Me.
>>>
>>>I came up with this while getting cvs to work with Novell.  The patch in
>>>this message is necessary but insufficient for cvs, which also requires
>>>changes to "unlink".  I will submit a separate patch for "unlink" once we
>>>get some closure on the rename issue. I can get CVS to work on NT 4.0,
>>>Windows 2000, Windows 95 and Windows 98, with and without Novell.  I have
>>>not tried Windows Me.  We have been using these changes here for over a
>>>month with no obvious side-effects, but then we don't make extensive use of
>>>Cygwin.
>>>
>>>Should anyone be trying to get CVS to work with Novell and be willing to
>>>patch their own code, I'll supply it upon request.
>>>
>>>I added quite a few syscall_printf lines to rename so that I could see what
>>>was happening.   I have no particular attraction to any of them, but I have
>>>not seen reason to remove them.
>>>
>>>===================================================================
>>>RCS file: syscalls.cc,v
>>>retrieving revision 1.1
>>>diff -u -r1.1 syscalls.cc
>>>--- syscalls.cc       2001/05/23 20:09:21     1.1
>>>+++ syscalls.cc       2001/07/20 18:53:31
>>>@@ -124,7 +124,7 @@
>>>      {
>>>        CloseHandle (h);
>>>        syscall_printf ("CreateFile/CloseHandle succeeded");
>>>-       if (os_being_run == winNT || GetFileAttributes (win32_name) ==
>>>(DWORD) -1)
>>>+       if (GetFileAttributes (win32_name) == (DWORD) -1)
>>>          {
>>>            res = 0;
>>>            break;
>>>@@ -1234,6 +1234,7 @@
>>>   sigframe thisframe (mainthread);
>>>   int res = 0;
>>>
>>>+  syscall_printf ("rename (%s, %s)", oldpath, newpath);
>>>   path_conv real_old (oldpath, PC_SYM_NOFOLLOW);
>>>
>>>   if (real_old.error)
>>>@@ -1289,43 +1290,112 @@
>>>       SetFileAttributesA (real_new.get_win32 (), real_new.file_attributes
>>>() & ~ FILE_ATTRIBUTE_READONLY);
>>>     }
>>>
>>>-  if (!MoveFile (real_old.get_win32 (), real_new.get_win32 ()))
>>>-    res = -1;
>>>-
>>>-  if (res == 0 || (GetLastError () != ERROR_ALREADY_EXISTS
>>>-                && GetLastError () != ERROR_FILE_EXISTS))
>>>-    goto done;
>>>-
>>>-  if (os_being_run == winNT)
>>>+  if (MoveFile (real_old.get_win32 (), real_new.get_win32 ()))
>>>     {
>>>-      if (MoveFileEx (real_old.get_win32 (), real_new.get_win32 (),
>>>-                   MOVEFILE_REPLACE_EXISTING))
>>>-     res = 0;
>>>+      syscall_printf ( "MoveFile worked" );
>>>     }
>>>   else
>>>     {
>>>-      syscall_printf ("try win95 hack");
>>>-      for (;;)
>>>+      int HackWorked = (1 == 0);
>>>+      DWORD LastError = GetLastError();
>>>+
>>>+      syscall_printf ( "MoveFile failed %x", LastError );
>>>+
>>>+      /* Normal approach didn't work. Try some hacks that might. */
>>>+      switch ( LastError )
>>>      {
>>>-       if (!DeleteFileA (real_new.get_win32 ()) &&
>>>-           GetLastError () != ERROR_FILE_NOT_FOUND)
>>>+     case ERROR_ALREADY_EXISTS:
>>>+     case ERROR_FILE_EXISTS:
>>>+       if (os_being_run == winNT)
>>>          {
>>>-           syscall_printf ("deleting %s to be paranoid",
>>>-                           real_new.get_win32 ());
>>>-           break;
>>>+           /* MoveFileEx sometimes works when MoveFile doesn't. Try
>>>+            * that for WinNT systems only, as the call doesn't exist on
>>>+            * non-WinNT systems. */
>>>+           if (MoveFileEx (real_old.get_win32 (), real_new.get_win32 (),
>>>+                           MOVEFILE_REPLACE_EXISTING))
>>>+             {
>>>+               syscall_printf ( "MoveFileEx worked" );
>>>+               HackWorked = (1 == 1);
>>>+             }
>>>+           else
>>>+             {
>>>+               syscall_printf ( "MoveFileEx failed %x", GetLastError() );
>>>+             }
>>>          }
>>>-       else
>>>+       if ( ! HackWorked )
>>>          {
>>>+           /* Try an approach that sometimes works for Win95/98
>>>+               * systems using Novell. This is very similar to the
>>>+               * "Win95 hack" below, without the loop, and
>>>+               * without the assumption that you can delete a
>>>+               * read-only file with DeleteFile. */
>>>+           chmod ( real_new.get_win32 (), 0777 );
>>>+           chmod ( real_old.get_win32 (), 0777 );
>>>            if (MoveFile (real_old.get_win32 (), real_new.get_win32 ()))
>>>+             {
>>>+               syscall_printf ( "Novell hack A worked" );
>>>+               HackWorked = (1 == 1);
>>>+             }
>>>+           else
>>>+             {
>>>+               syscall_printf ( "Novell hack A (%s,%s) didn't work",
>>>+                        real_old.get_win32 (),
>>>+                        real_new.get_win32 ()  );
>>>+             }
>>>+         }
>>>+       break;
>>>+
>>>+     case ERROR_ACCESS_DENIED:
>>>+       chmod ( real_old.get_win32 (), 0777 );
>>>+       if (MoveFile (real_old.get_win32 (), real_new.get_win32 ()))
>>>+         {
>>>+           syscall_printf ("Novell hack B succeeded");
>>>+           HackWorked = (1 == 1);
>>>+         }
>>>+       else
>>>+         {
>>>+           syscall_printf ("Novell hack B failed");
>>>+         }
>>>+       break;
>>>+
>>>+     default:
>>>+       syscall_printf ( "No specific solution for problem" );
>>>+       break;
>>>+     }
>>>+
>>>+      /* The following loop might help, but so far we have no
>>>+       * documentation on why.  It would be nice to know why it
>>>+       * doesn't loop forever in the Win95 case; it does loop forever
>>>+       * in the Win98/Novell case of a read-only file being
>>>+       * renamed. */
>>>+      if (os_being_run != winNT && ! HackWorked )
>>>+     {
>>>+       syscall_printf ("win95 hack");
>>>+       for (;;)
>>>+         {
>>>+           if (!DeleteFileA (real_new.get_win32 ()) &&
>>>+               GetLastError () != ERROR_FILE_NOT_FOUND)
>>>              {
>>>-               res = 0;
>>>+               syscall_printf ("deleting %s to be paranoid",
>>>+                               real_new.get_win32 ());
>>>                break;
>>>              }
>>>+           else
>>>+             {
>>>+               if (MoveFile (real_old.get_win32 (), real_new.get_win32 ()))
>>>+                 {
>>>+                   HackWorked = (1 == 1);
>>>+                   break;
>>>+                 }
>>>+             }
>>>          }
>>>      }
>>>+      if ( ! HackWorked )
>>>+     {
>>>+       res = -1;
>>>+     }
>>>     }
>>>-
>>>-done:
>>>+
>>>   if (res)
>>>     __seterrno ();
>>>
>>>@@ -1333,6 +1403,14 @@
>>>     {
>>>       /* make the new file have the permissions of the old one */
>>>       SetFileAttributesA (real_new.get_win32 (), real_old.file_attributes
>>>());
>>>+    }
>>>+  else
>>>+    {
>>>+      /* some of the rename algorithms tried above try to change
>>>+         permissions; reset those of the old and new files back to the
>>>+         way they were. */
>>>+      SetFileAttributesA (real_new.get_win32 (), real_new.file_attributes
>>>());
>>>+      SetFileAttributesA (real_old.get_win32 (), real_old.file_attributes
>>>());
>>>     }
>>>
>>>   syscall_printf ("%d = rename (%s, %s)", res, real_old.get_win32 (),
>>>
>>>Neil Erskine
>>>Manager, Research and Product Development
>>>JJ Mackay Canada Limited
>>>1046 Barrington Street, 1st floor
>>>Halifax, N.S. B3H 2R1
>>>
>>>voice 902 423 7727 ext. 230
>>>fax 902 422 8108
>>
>>-- 
>>cgf@cygnus.com                        Red Hat, Inc.
>>http://sources.redhat.com/            http://www.redhat.com/




Egor.            mailto:deo@logos-m.ru ICQ 5165414 FidoNet 2:5020/496.19
