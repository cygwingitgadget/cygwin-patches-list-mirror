Return-Path: <cygwin-patches-return-5103-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30989 invoked by alias); 31 Oct 2004 02:35:34 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 30979 invoked from network); 31 Oct 2004 02:35:32 -0000
Received: from unknown (HELO phumblet.no-ip.org) (68.163.203.248)
  by sourceware.org with SMTP; 31 Oct 2004 02:35:32 -0000
Received: from [192.168.1.156] (helo=hpn5170)
	by phumblet.no-ip.org with smtp (Exim 4.43)
	id I6FGNE-003O27-50
	for cygwin-patches@cygwin.com; Sat, 30 Oct 2004 22:38:02 -0400
Message-Id: <3.0.5.32.20041030223054.008277e0@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Sun, 31 Oct 2004 02:35:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: Re: [Patch] unlink
In-Reply-To: <20041030173942.GD1556@trixie.casa.cgf.cx>
References: <4182BDCF.3C04BAF8@phumblet.no-ip.org>
 <4182BDCF.3C04BAF8@phumblet.no-ip.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1099204254==_"
X-SW-Source: 2004-q4/txt/msg00104.txt.bz2

--=====================_1099204254==_
Content-Type: text/plain; charset="us-ascii"
Content-length: 1726

At 01:39 PM 10/30/2004 -0400, you wrote:
>On Fri, Oct 29, 2004 at 06:01:51PM -0400, Pierre A. Humblet wrote:
>>Here is a patch that should allow unlink() to handle
>>nul etc.. on local disks.
>>
>>It's a cut and paste of Corinna's open on NT and the
>>existing CreateFile.
>> 
>>It works on normal files. I haven't tested with the
>>special names because I forgot how to create them !
>>Feedback welcome.
>>
>>XXXXX This should NOT be applied in 1.5.12 XXXXXX
>>
>>Pierre
>>
>>2004-10-29  Pierre Humblet <pierre.humblet@ieee.org>
>>
>>	* syscalls.cc (nt_delete): New function.
>>	(unlink): Call nt_delete instead of CreateFile and remove
>>	unreachable code.
>
>Corinna suggested something similar to me a couple of months ago but I
>wanted to wait for things to settle down somewhat after the original
>use of NtCreateFile.
>
>On reflection, however, wouldn't it be a little easier just to prepend
>the path being deleted with a: \\.\ so that "rm nul" would eventually
>translate to DeleteFile("\\.\c:\foo\null") (I'm not using true C
>backslash quoting here)?  I don't know if that would work on Windows 9x,
>though.

That would work on NT, but then one would need to check if the input
path didn't already have the form //./xx, worry about exceeding max 
pathlength, etc... The patch cleanly handles all of that, is symmetrical
to file creation, and is very efficient. I cleaned it up a little and
tested readonly hard links and other weird cases.
It's good to go but I still wouldn't include it in 1.5.12 if it's
coming out this weekend.

Pierre

2004-10-31  Pierre Humblet <pierre.humblet@ieee.org>

	* syscalls.cc (nt_delete): New function.
	(unlink): Call nt_delete instead of CreateFile and remove
	unreachable code.


--=====================_1099204254==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="ntdelete2.diff"
Content-length: 2907

Index: syscalls.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/syscalls.cc,v
retrieving revision 1.349
diff -u -p -b -r1.349 syscalls.cc
--- syscalls.cc	28 Oct 2004 01:46:01 -0000	1.349
+++ syscalls.cc	31 Oct 2004 02:10:49 -0000
@@ -39,6 +39,8 @@ details. */
 #include <wininet.h>
 #include <lmcons.h> /* for UNLEN */
 #include <rpc.h>
+#include <ntdef.h>
+#include "ntdll.h"

 #undef fstat
 #undef lstat
@@ -127,6 +129,30 @@ dup2 (int oldfd, int newfd)
   return cygheap->fdtab.dup2 (oldfd, newfd);
 }

+static HANDLE
+nt_delete (path_conv & pc)
+{
+  WCHAR wpath[CYG_MAX_PATH + 10];
+  UNICODE_STRING upath =3D {0, sizeof (wpath), wpath};
+  pc.get_nt_native_path (upath);
+
+  HANDLE x;
+  OBJECT_ATTRIBUTES attr;
+  IO_STATUS_BLOCK io;
+  NTSTATUS status;
+
+  InitializeObjectAttributes (&attr, &upath, OBJ_CASE_INSENSITIVE, NULL, N=
ULL);
+  status =3D NtCreateFile (&x, DELETE, &attr, &io, NULL, FILE_ATTRIBUTE_NO=
RMAL,
+                         FILE_SHARE_READ, FILE_OPEN, FILE_DELETE_ON_CLOSE,=
 NULL, 0);
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
@@ -192,30 +218,17 @@ unlink (const char *ourname)
      Microsoft KB 837665 describes this problem as a bug in 2K3, but I have
      reproduced it on shares on Samba 2.2.8, Samba 3.0.2, NT4SP6, XP64SP1 =
and
      2K3 and in all cases, DeleteFile works, "delete on close" does not. */
-  if (!win32_name.isremote () && wincap.has_delete_on_close ())
+  if (!win32_name.isremote () && wincap.is_winnt ())
     {
-      HANDLE h;
-      h =3D CreateFile (win32_name, 0, FILE_SHARE_READ, &sec_none_nih,
-		      OPEN_EXISTING, FILE_FLAG_DELETE_ON_CLOSE, 0);
+      HANDLE h =3D nt_delete (win32_name);
       if (h !=3D INVALID_HANDLE_VALUE)
 	{
-	  if (wincap.has_hard_links () && setattrs)
+	  if (setattrs && wincap.has_hard_links ())
 	    (void) SetFileAttributes (win32_name, (DWORD) win32_name);
 	  BOOL res =3D CloseHandle (h);
-	  syscall_printf ("%d =3D CloseHandle (%p)", res, h);
-	  if (GetFileAttributes (win32_name) =3D=3D INVALID_FILE_ATTRIBUTES
-	      || !win32_name.isremote ())
-	    {
-	      syscall_printf ("CreateFile (FILE_FLAG_DELETE_ON_CLOSE) succeeded");
+	  syscall_printf ("%p =3D nt_delete (). %d =3D CloseHandle ()", h, res);
 	      goto ok;
 	    }
-	  else
-	    {
-	      syscall_printf ("CreateFile (FILE_FLAG_DELETE_ON_CLOSE) failed");
-	      if (setattrs)
-		SetFileAttributes (win32_name, (DWORD) win32_name & ~(FILE_ATTRIBUTE_REA=
DONLY | FILE_ATTRIBUTE_SYSTEM));
-	    }
-	}
     }

   /* Try a delete with attributes reset */

--=====================_1099204254==_--
