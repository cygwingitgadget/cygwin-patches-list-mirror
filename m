Return-Path: <cygwin-patches-return-3482-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6425 invoked by alias); 3 Feb 2003 13:18:01 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 6409 invoked from network); 3 Feb 2003 13:18:00 -0000
Date: Mon, 03 Feb 2003 13:18:00 -0000
From: Vaclav Haisman <V.Haisman@sh.cvut.cz>
To: cygwin-patches@cygwin.com
Subject: Create new files as sparse on NT systems. (2nd try)
Message-ID: <20030203141333.Y68413-100000@logout.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: AMaViS at Silicon Hill
X-Spam-Status: No, hits=1.1 required=5.0
	tests=CARRIAGE_RETURNS,SPAM_PHRASE_00_01
	version=2.43
X-Spam-Level: *
X-SW-Source: 2003-q1/txt/msg00131.txt.bz2


This is a little bit improved version of my previous post.
By default creation of sparse files is disabled. It can be enabled by CYGWIN
option sparse_files.

Vaclav Haisman


2003-02-03  Vaclav Haisman  <V.Haisman@sh.cvut.cz>
	* fhandler.h (allow_sparse): Declare new extern variable.
	* fhandler.cc (METHOD_BUFFERED): New macro.
	(FSCTL_SET_SPARSE): Ditto.
	(allow_sparse): Define the new variable.
	(fhandler_base::open): Try to set newly created or trucated files
	as sparse on NT systems.
	* environ.cc (parse_thing): Add new CYGWIN option.

Index: cygwin/environ.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/environ.cc,v
retrieving revision 1.90
diff -p -u -r1.90 environ.cc
--- cygwin/environ.cc	30 Sep 2002 03:05:13 -0000	1.90
+++ cygwin/environ.cc	3 Feb 2003 12:54:40 -0000
@@ -522,6 +522,7 @@ static struct parse_thing
   {"title", {&display_title}, justset, NULL, {{FALSE}, {TRUE}}},
   {"tty", {NULL}, set_process_state, NULL, {{0}, {PID_USETTY}}},
   {"winsymlinks", {&allow_winsymlinks}, justset, NULL, {{FALSE}, {TRUE}}},
+  {"sparse_files", {&allow_sparse}, justset, NULL, {{FALSE}, {TRUE}}},
   {NULL, {0}, justset, 0, {{0}, {0}}}
 };

Index: cygwin/fhandler.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler.cc,v
retrieving revision 1.143
diff -p -u -r1.143 fhandler.cc
--- cygwin/fhandler.cc	20 Dec 2002 01:48:22 -0000	1.143
+++ cygwin/fhandler.cc	3 Feb 2003 12:54:42 -0000
@@ -27,12 +27,18 @@ details. */
 #include "pinfo.h"
 #include <assert.h>
 #include <limits.h>
+#include <winioctl.h>
+
+#define METHOD_BUFFERED 0
+#define FSCTL_SET_SPARSE CTL_CODE(FILE_DEVICE_FILE_SYSTEM, 49, \
+  METHOD_BUFFERED, FILE_SPECIAL_ACCESS)

 static NO_COPY const int CHUNK_SIZE = 1024; /* Used for crlf conversions */

 struct __cygwin_perfile *perfile_table;

 DWORD binmode;
+BOOL allow_sparse;

 inline fhandler_base&
 fhandler_base::operator =(fhandler_base &x)
@@ -371,6 +377,8 @@ fhandler_base::open (path_conv *pc, int
   int shared;
   int creation_distribution;
   SECURITY_ATTRIBUTES sa = sec_none;
+  DWORD dw;
+  BOOL r;

   syscall_printf ("(%s, %p) query_open %d", get_win32_name (), flags, get_query_open ());

@@ -486,6 +494,16 @@ fhandler_base::open (path_conv *pc, int
       && !allow_ntsec && allow_ntea)
     set_file_attribute (has_acls (), get_win32_name (), mode);

+  /* Try to set newly created files as sparse files on NT system. */
+  if (allow_sparse && wincap.is_winnt () && get_device () == FH_DISK
+      && (access & GENERIC_WRITE) == GENERIC_WRITE
+      && (flags & (O_CREAT | O_TRUNC)))
+    {
+      r = DeviceIoControl(x, FSCTL_SET_SPARSE, NULL, 0, NULL, 0, &dw, NULL);
+      syscall_printf ("%d = DeviceIoControl(0x%x, FSCTL_SET_SPARSE, NULL, 0, "
+		      "NULL, 0, &dw, NULL)", r, x);
+    }
+
   set_io_handle (x);
   set_flags (flags, pc ? pc->binmode () : 0);

Index: cygwin/fhandler.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler.h,v
retrieving revision 1.154
diff -p -u -r1.154 fhandler.h
--- cygwin/fhandler.h	10 Jan 2003 12:32:46 -0000	1.154
+++ cygwin/fhandler.h	3 Feb 2003 12:54:47 -0000
@@ -110,6 +110,7 @@ extern struct __cygwin_perfile *perfile_
 #define __fmode (*(user_data->fmode_ptr))
 extern const char proc[];
 extern const int proc_len;
+extern BOOL allow_sparse;

 class select_record;
 class path_conv;
