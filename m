Return-Path: <cygwin-patches-return-5099-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10753 invoked by alias); 29 Oct 2004 22:02:02 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 10703 invoked from network); 29 Oct 2004 22:01:54 -0000
Received: from unknown (HELO apmail1.astralpoint.com) (65.114.186.130)
  by sourceware.org with SMTP; 29 Oct 2004 22:01:54 -0000
Received: from [127.0.0.1] (helo=phumblet.no-ip.org)
	by usched40576.usa1ma.alcatel.com with esmtp (Exim 4.43)
	id I6D974-0000I3-75
	for cygwin-patches@cygwin.com; Fri, 29 Oct 2004 18:01:52 -0400
Message-ID: <4182BDCF.3C04BAF8@phumblet.no-ip.org>
Date: Fri, 29 Oct 2004 22:02:00 -0000
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Reply-To: pierre.humblet@ieee.org
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [Patch] unlink
Content-Type: multipart/mixed;
 boundary="------------E11D18727C95EEB25BA318C8"
X-SW-Source: 2004-q4/txt/msg00100.txt.bz2

This is a multi-part message in MIME format.
--------------E11D18727C95EEB25BA318C8
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-length: 511

Here is a patch that should allow unlink() to handle
nul etc.. on local disks.

It's a cut and paste of Corinna's open on NT and the
existing CreateFile.
 
It works on normal files. I haven't tested with the
special names because I forgot how to create them !
Feedback welcome.

XXXXX This should NOT be applied in 1.5.12 XXXXXX

Pierre

2004-10-29  Pierre Humblet <pierre.humblet@ieee.org>

	* syscalls.cc (nt_delete): New function.
	(unlink): Call nt_delete instead of CreateFile and remove
	unreachable code.
--------------E11D18727C95EEB25BA318C8
Content-Type: text/plain; charset=us-ascii;
 name="ntdelete.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ntdelete.diff"
Content-length: 2666

Index: syscalls.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/syscalls.cc,v
retrieving revision 1.349
diff -u -p -r1.349 syscalls.cc
--- syscalls.cc	28 Oct 2004 01:46:01 -0000	1.349
+++ syscalls.cc	29 Oct 2004 21:27:04 -0000
@@ -39,6 +39,8 @@ details. */
 #include <wininet.h>
 #include <lmcons.h> /* for UNLEN */
 #include <rpc.h>
+#include <ntdef.h>
+#include "ntdll.h"
 
 #undef fstat
 #undef lstat
@@ -127,6 +129,32 @@ dup2 (int oldfd, int newfd)
   return cygheap->fdtab.dup2 (oldfd, newfd);
 }
 
+static HANDLE
+nt_delete (path_conv & pc)
+{
+  WCHAR wpath[CYG_MAX_PATH + 10];
+  UNICODE_STRING upath = {0, sizeof (wpath), wpath};
+  pc.get_nt_native_path (upath);
+
+  HANDLE x;
+  OBJECT_ATTRIBUTES attr;
+  IO_STATUS_BLOCK io;
+  NTSTATUS status;
+
+  InitializeObjectAttributes (&attr, &upath, OBJ_CASE_INSENSITIVE | OBJ_INHERIT,
+			      NULL, NULL);
+   
+  status = NtCreateFile (&x, DELETE, &attr, &io, NULL, FILE_ATTRIBUTE_NORMAL, 
+                         FILE_SHARE_READ, FILE_OPEN, FILE_DELETE_ON_CLOSE, NULL, 0);
+  if (!NT_SUCCESS (status))
+    {
+      __seterrno_from_win_error (RtlNtStatusToDosError (status));
+      return INVALID_HANDLE_VALUE;
+    }
+  else
+    return x;
+}
+
 extern "C" int
 unlink (const char *ourname)
 {
@@ -192,29 +220,17 @@ unlink (const char *ourname)
      Microsoft KB 837665 describes this problem as a bug in 2K3, but I have
      reproduced it on shares on Samba 2.2.8, Samba 3.0.2, NT4SP6, XP64SP1 and
      2K3 and in all cases, DeleteFile works, "delete on close" does not. */
-  if (!win32_name.isremote () && wincap.has_delete_on_close ())
+  if (!win32_name.isremote () && wincap.is_winnt ())
     {
-      HANDLE h;
-      h = CreateFile (win32_name, 0, FILE_SHARE_READ, &sec_none_nih,
-		      OPEN_EXISTING, FILE_FLAG_DELETE_ON_CLOSE, 0);
+      HANDLE h = nt_delete (win32_name);
       if (h != INVALID_HANDLE_VALUE)
 	{
 	  if (wincap.has_hard_links () && setattrs)
 	    (void) SetFileAttributes (win32_name, (DWORD) win32_name);
 	  BOOL res = CloseHandle (h);
 	  syscall_printf ("%d = CloseHandle (%p)", res, h);
-	  if (GetFileAttributes (win32_name) == INVALID_FILE_ATTRIBUTES
-	      || !win32_name.isremote ())
-	    {
-	      syscall_printf ("CreateFile (FILE_FLAG_DELETE_ON_CLOSE) succeeded");
-	      goto ok;
-	    }
-	  else
-	    {
-	      syscall_printf ("CreateFile (FILE_FLAG_DELETE_ON_CLOSE) failed");
-	      if (setattrs)
-		SetFileAttributes (win32_name, (DWORD) win32_name & ~(FILE_ATTRIBUTE_READONLY | FILE_ATTRIBUTE_SYSTEM));
-	    }
+	  syscall_printf ("nt_delete () succeeded");
+	  goto ok;
 	}
     }
 

--------------E11D18727C95EEB25BA318C8--
