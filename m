Return-Path: <cygwin-patches-return-3570-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12988 invoked by alias); 17 Feb 2003 16:37:17 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 12977 invoked from network); 17 Feb 2003 16:37:16 -0000
Date: Mon, 17 Feb 2003 16:37:00 -0000
From: Vaclav Haisman <V.Haisman@sh.cvut.cz>
To: cygwin-patches@cygwin.com
Subject: Re: Create new files as sparse on NT systems. (2nd try)
In-Reply-To: <20030213203642.GG32279@redhat.com>
Message-ID: <20030217171533.N92334-100000@logout.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: AMaViS at Silicon Hill
X-Spam-Status: No, hits=-0.5 required=5.0
	tests=CARRIAGE_RETURNS,IN_REP_TO,QUOTED_EMAIL_TEXT,
	      SPAM_PHRASE_00_01
	version=2.43
X-Spam-Level: 
X-SW-Source: 2003-q1/txt/msg00219.txt.bz2

> UNIX has a method for producing sparse files.  If this is desired functionality,
> Cygwin should mimic that not invent a new way of doing things.
>
> cgf

Hi,
I have prepared another patch that implements parse files for Cygwin. It is
smaller and, I think, even better than the previous. No new CYGWIN options.

I have also been searching internet for some informations abut sparse files in
Unix systems. It seems that if OS and file system supports it then it supports
it without any extra system call. Some systems (SunOS) have fcntl() command
F_FREESP that is supposed to free allocated disk space. But all unices I have
had look at only support such combination of parameters that the deallocated
block of space is at the end of file. In this case it works as ftruncate(). If
I should implement this fcntl() command such that it would be able to
deallocate disk space in a middle of a file then I would be inventing
something new.

Vaclav Haisman

2003-02-17  Vaclav Haisman  <V.Haisman@sh.cvut.cz>

	* include/winioctl.h (FSCTL_SET_SPARSE): Define.

2003-02-17  Vaclav Haisman  <V.Haisman@sh.cvut.cz>

	* fhandler.h: Include winioctl.h for DeviceIoControl.
	(fhandler::open): Try to set newly created and truncated files as
	sparse on NT systems.

Index: cygwin/fhandler.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler.cc,v
retrieving revision 1.143
diff -u -p -r1.143 fhandler.cc
--- cygwin/fhandler.cc	20 Dec 2002 01:48:22 -0000	1.143
+++ cygwin/fhandler.cc	17 Feb 2003 16:08:30 -0000
@@ -27,6 +27,7 @@ details. */
 #include "pinfo.h"
 #include <assert.h>
 #include <limits.h>
+#include <winioctl.h>

 static NO_COPY const int CHUNK_SIZE = 1024; /* Used for crlf conversions */

@@ -486,6 +487,18 @@ fhandler_base::open (path_conv *pc, int
       && !allow_ntsec && allow_ntea)
     set_file_attribute (has_acls (), get_win32_name (), mode);

+  /* Try to set newly created files as sparse files on NT system. */
+  if (wincap.is_winnt () && get_device () == FH_DISK
+      && (access & GENERIC_WRITE) == GENERIC_WRITE
+      && (flags & (O_CREAT | O_TRUNC)))
+    {
+      DWORD dw;
+      BOOL r = DeviceIoControl (x, FSCTL_SET_SPARSE, NULL, 0, NULL, 0, &dw,
+				NULL);
+      syscall_printf ("%d = DeviceIoControl(0x%x, FSCTL_SET_SPARSE, NULL, 0, "
+		      "NULL, 0, &dw, NULL)", r, x);
+    }
+
   set_io_handle (x);
   set_flags (flags, pc ? pc->binmode () : 0);

Index: w32api/include/winioctl.h
===================================================================
RCS file: /cvs/src/src/winsup/w32api/include/winioctl.h,v
retrieving revision 1.8
diff -u -p -r1.8 winioctl.h
--- w32api/include/winioctl.h	7 Nov 2002 14:14:01 -0000	1.8
+++ w32api/include/winioctl.h	17 Feb 2003 16:08:34 -0000
@@ -69,6 +69,7 @@ extern "C" {
 #define FSCTL_GET_REPARSE_POINT CTL_CODE(FILE_DEVICE_FILE_SYSTEM, 42, METHOD_BUFFERED, FILE_ANY_ACCESS)
 #define FSCTL_SET_REPARSE_POINT CTL_CODE(FILE_DEVICE_FILE_SYSTEM, 41, METHOD_BUFFERED, FILE_WRITE_DATA)
 #define FSCTL_DELETE_REPARSE_POINT CTL_CODE(FILE_DEVICE_FILE_SYSTEM, 43, METHOD_BUFFERED, FILE_WRITE_DATA)
+#define FSCTL_SET_SPARSE        CTL_CODE(FILE_DEVICE_FILE_SYSTEM, 49, METHOD_BUFFERED, FILE_SPECIAL_ACCESS)
 #define DEVICE_TYPE DWORD
 #define FILE_DEVICE_BEEP	1
 #define FILE_DEVICE_CD_ROM	2
