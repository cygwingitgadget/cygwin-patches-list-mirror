Return-Path: <cygwin-patches-return-3572-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18329 invoked by alias); 17 Feb 2003 17:36:42 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 18310 invoked from network); 17 Feb 2003 17:36:41 -0000
Date: Mon, 17 Feb 2003 17:36:00 -0000
From: Vaclav Haisman <V.Haisman@sh.cvut.cz>
To: cygwin-patches@cygwin.com
Subject: Re: Create new files as sparse on NT systems. (2nd try)
In-Reply-To: <20030217164528.GA5837@redhat.com>
Message-ID: <20030217183337.X95188-100000@logout.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: AMaViS at Silicon Hill
X-Spam-Status: No, hits=-0.5 required=5.0
	tests=CARRIAGE_RETURNS,IN_REP_TO,QUOTED_EMAIL_TEXT,
	      SPAM_PHRASE_00_01
	version=2.43
X-Spam-Level: 
X-SW-Source: 2003-q1/txt/msg00221.txt.bz2

> This looks pretty good but the cygwin convention is to use wincap
> settings for this kind of thing rather than using is_winnt.  So, please
> add a wincap capability to accomplish this.
>
> cgf

Modified as suggested.

Vaclav Haisman

2003-02-17  Vaclav Haisman  <V.Haisman@sh.cvut.cz>

	* wincap.h (wincaps::supports_sparse_files): New flag.
	(wincapc::supports_sparse_files): New method.
	* wincap.cc (wincap_unknown): Define value for the new flag.
	(wincap_95): Ditto.
	(wincap_95osr2): Ditto.
	(wincap_98): Ditto.
	(wincap_98se): Ditto.
	(wincap_me): Ditto.
	(wincap_nt3): Ditto.
	(wincap_nt4): Ditto.
	(wincap_nt4sp4): Ditto.
	(wincap_2000): Ditto.
	(wincap_xp): Ditto.
	* fhandler.cc: Include winioctl.h for DeviceIoControl.
	(fhandler::open): Try to set newly created and truncated files as
	sparse.

2003-02-17  Vaclav Haisman  <V.Haisman@sh.cvut.cz>

	* include/winioctl.h (FSCTL_SET_SPARSE): Define.

Index: cygwin/fhandler.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler.cc,v
retrieving revision 1.143
diff -u -p -r1.143 fhandler.cc
--- cygwin/fhandler.cc	20 Dec 2002 01:48:22 -0000	1.143
+++ cygwin/fhandler.cc	17 Feb 2003 17:23:43 -0000
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
+  if (wincap.supports_sparse_files () && get_device () == FH_DISK
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

Index: cygwin/wincap.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/wincap.cc,v
retrieving revision 1.18
diff -u -p -r1.18 wincap.cc
--- cygwin/wincap.cc	15 Oct 2002 17:04:20 -0000	1.18
+++ cygwin/wincap.cc	17 Feb 2003 17:23:44 -0000
@@ -47,7 +47,8 @@ static NO_COPY wincaps wincap_unknown =
   has_64bit_file_access:false,
   has_process_io_counters:false,
   supports_reading_modem_output_lines:false,
-  needs_memory_protection:false
+  needs_memory_protection:false,
+  supports_sparse_files:false
 };

 static NO_COPY wincaps wincap_95 = {
@@ -86,7 +87,8 @@ static NO_COPY wincaps wincap_95 = {
   has_64bit_file_access:false,
   has_process_io_counters:false,
   supports_reading_modem_output_lines:false,
-  needs_memory_protection:false
+  needs_memory_protection:false,
+  supports_sparse_files:false
 };

 static NO_COPY wincaps wincap_95osr2 = {
@@ -125,7 +127,8 @@ static NO_COPY wincaps wincap_95osr2 = {
   has_64bit_file_access:false,
   has_process_io_counters:false,
   supports_reading_modem_output_lines:false,
-  needs_memory_protection:false
+  needs_memory_protection:false,
+  supports_sparse_files:false
 };

 static NO_COPY wincaps wincap_98 = {
@@ -164,7 +167,8 @@ static NO_COPY wincaps wincap_98 = {
   has_64bit_file_access:false,
   has_process_io_counters:false,
   supports_reading_modem_output_lines:false,
-  needs_memory_protection:false
+  needs_memory_protection:false,
+  supports_sparse_files:false
 };

 static NO_COPY wincaps wincap_98se = {
@@ -203,7 +207,8 @@ static NO_COPY wincaps wincap_98se = {
   has_64bit_file_access:false,
   has_process_io_counters:false,
   supports_reading_modem_output_lines:false,
-  needs_memory_protection:false
+  needs_memory_protection:false,
+  supports_sparse_files:false
 };

 static NO_COPY wincaps wincap_me = {
@@ -242,7 +247,8 @@ static NO_COPY wincaps wincap_me = {
   has_64bit_file_access:false,
   has_process_io_counters:false,
   supports_reading_modem_output_lines:false,
-  needs_memory_protection:false
+  needs_memory_protection:false,
+  supports_sparse_files:false
 };

 static NO_COPY wincaps wincap_nt3 = {
@@ -281,7 +287,8 @@ static NO_COPY wincaps wincap_nt3 = {
   has_64bit_file_access:true,
   has_process_io_counters:false,
   supports_reading_modem_output_lines:true,
-  needs_memory_protection:true
+  needs_memory_protection:true,
+  supports_sparse_files:false
 };

 static NO_COPY wincaps wincap_nt4 = {
@@ -320,7 +327,8 @@ static NO_COPY wincaps wincap_nt4 = {
   has_64bit_file_access:true,
   has_process_io_counters:false,
   supports_reading_modem_output_lines:true,
-  needs_memory_protection:true
+  needs_memory_protection:true,
+  supports_sparse_files:false
 };

 static NO_COPY wincaps wincap_nt4sp4 = {
@@ -359,7 +367,8 @@ static NO_COPY wincaps wincap_nt4sp4 = {
   has_64bit_file_access:true,
   has_process_io_counters:false,
   supports_reading_modem_output_lines:true,
-  needs_memory_protection:true
+  needs_memory_protection:true,
+  supports_sparse_files:false
 };

 static NO_COPY wincaps wincap_2000 = {
@@ -398,7 +407,8 @@ static NO_COPY wincaps wincap_2000 = {
   has_64bit_file_access:true,
   has_process_io_counters:true,
   supports_reading_modem_output_lines:true,
-  needs_memory_protection:true
+  needs_memory_protection:true,
+  supports_sparse_files:true
 };

 static NO_COPY wincaps wincap_xp = {
@@ -437,7 +447,8 @@ static NO_COPY wincaps wincap_xp = {
   has_64bit_file_access:true,
   has_process_io_counters:true,
   supports_reading_modem_output_lines:true,
-  needs_memory_protection:true
+  needs_memory_protection:true,
+  supports_sparse_files:true
 };

 wincapc wincap;
Index: cygwin/wincap.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/wincap.h,v
retrieving revision 1.14
diff -u -p -r1.14 wincap.h
--- cygwin/wincap.h	15 Oct 2002 17:04:20 -0000	1.14
+++ cygwin/wincap.h	17 Feb 2003 17:23:44 -0000
@@ -49,6 +49,7 @@ struct wincaps
   unsigned has_process_io_counters                      : 1;
   unsigned supports_reading_modem_output_lines          : 1;
   unsigned needs_memory_protection			: 1;
+  unsigned supports_sparse_files                        : 1;
 };

 class wincapc
@@ -102,6 +103,7 @@ public:
   bool  IMPLEMENT (has_process_io_counters)
   bool  IMPLEMENT (supports_reading_modem_output_lines)
   bool  IMPLEMENT (needs_memory_protection)
+  bool  IMPLEMENT (supports_sparse_files)

 #undef IMPLEMENT
 };
Index: w32api/include/winioctl.h
===================================================================
RCS file: /cvs/src/src/winsup/w32api/include/winioctl.h,v
retrieving revision 1.8
diff -u -p -r1.8 winioctl.h
--- w32api/include/winioctl.h	7 Nov 2002 14:14:01 -0000	1.8
+++ w32api/include/winioctl.h	17 Feb 2003 17:23:59 -0000
@@ -69,6 +69,7 @@ extern "C" {
 #define FSCTL_GET_REPARSE_POINT CTL_CODE(FILE_DEVICE_FILE_SYSTEM, 42, METHOD_BUFFERED, FILE_ANY_ACCESS)
 #define FSCTL_SET_REPARSE_POINT CTL_CODE(FILE_DEVICE_FILE_SYSTEM, 41, METHOD_BUFFERED, FILE_WRITE_DATA)
 #define FSCTL_DELETE_REPARSE_POINT CTL_CODE(FILE_DEVICE_FILE_SYSTEM, 43, METHOD_BUFFERED, FILE_WRITE_DATA)
+#define FSCTL_SET_SPARSE        CTL_CODE(FILE_DEVICE_FILE_SYSTEM, 49, METHOD_BUFFERED, FILE_SPECIAL_ACCESS)
 #define DEVICE_TYPE DWORD
 #define FILE_DEVICE_BEEP	1
 #define FILE_DEVICE_CD_ROM	2
