Return-Path: <cygwin-patches-return-4574-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8264 invoked by alias); 13 Feb 2004 02:40:27 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8046 invoked from network); 13 Feb 2004 02:40:26 -0000
Message-Id: <3.0.5.32.20040212213922.007f0ac0@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Fri, 13 Feb 2004 02:40:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: [Patch] rename
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2004-q1/txt/msg00064.txt.bz2

MoveFile on XP Home Edition returns error ERROR_ACCESS_DENIED when
the destination file already exists on a remote disk located
on a Win98 machine.

This leads to the same problem with rename() as that reported in
http://www.cygwin.com/ml/cygwin-patches/2000-q2/msg00069.html

The patch simply removes the test on the error when
MoveFileEx is available. I have read the long history of rename()
and the only reported trouble with MoveFileEx is the deletion
of the file when source name == destination name, except for case.
So removing the test should be OK.
 
I have kept the test on 9X to avoid spurious DeleteFile calls
on the destination.

Pierre

2004-02-12  Pierre Humblet <pierre.humblet@ieee.org>

	* syscalls.cc (rename): Do not test the MoveFile error code
	where MoveFileEx exists.

 

Index: syscalls.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/syscalls.cc,v
retrieving revision 1.319
diff -u -p -r1.319 syscalls.cc
--- syscalls.cc 9 Feb 2004 04:04:24 -0000       1.319
+++ syscalls.cc 12 Feb 2004 03:28:41 -0000
@@ -1314,20 +1314,18 @@ rename (const char *oldpath, const char 
       && (lnk_suffix = strrchr (real_new.get_win32 (), '.')))
      *lnk_suffix = '\0';
 
-  if (!MoveFile (real_old, real_new))
-    res = -1;
-
-  if (res == 0 || (GetLastError () != ERROR_ALREADY_EXISTS
-                  && GetLastError () != ERROR_FILE_EXISTS))
+  if (MoveFile (real_old, real_new))
     goto done;
 
+  res = -1;
   if (wincap.has_move_file_ex ())
     {
       if (MoveFileEx (real_old.get_win32 (), real_new.get_win32 (),
                      MOVEFILE_REPLACE_EXISTING))
        res = 0;
     }
-  else
+  else if (GetLastError () == ERROR_ALREADY_EXISTS
+          || GetLastError () == ERROR_FILE_EXISTS)
     {
       syscall_printf ("try win95 hack");
       for (int i = 0; i < 2; i++)
