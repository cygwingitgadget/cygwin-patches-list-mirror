Return-Path: <cygwin-patches-return-5730-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29194 invoked by alias); 2 Feb 2006 12:26:20 -0000
Received: (qmail 29175 invoked by uid 22791); 2 Feb 2006 12:26:19 -0000
X-Spam-Check-By: sourceware.org
Received: from dessent.net (HELO dessent.net) (69.60.119.225)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Thu, 02 Feb 2006 12:26:17 +0000
Received: from localhost ([127.0.0.1] helo=dessent.net) 	by dessent.net with esmtp (Exim 4.60) 	(envelope-from <brian@dessent.net>) 	id 1F4dXS-0007XH-W3; Thu, 02 Feb 2006 12:26:15 +0000
Message-ID: <43E1FA66.216E236C@dessent.net>
Date: Thu, 02 Feb 2006 12:26:00 -0000
From: Brian Dessent <brian@dessent.net>
MIME-Version: 1.0
To: cygwin-patches@cygwin.com, gdb-patches@sourceware.org
Subject: [patch] fix spurious SIGSEGV faults under Cygwin
Content-Type: multipart/mixed;  boundary="------------830DBFDDBE959A9C0C175F1F"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q1/txt/msg00039.txt.bz2

This is a multi-part message in MIME format.
--------------830DBFDDBE959A9C0C175F1F
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-length: 2567


Recently Cygwin has changed the way that it internally checks arguments for bad
pointers.  Where before it used IsBad{Read,Write}Ptr() from the win32 API, now
it installs its own temporary SEH fault handler.  However, gdb is not aware of
this and so it leads to the program stopping on a SIGSEGV on perfectly
legitimate code -- when not run under the debugger, Cygwin's fault handler
catches the attempt and returns the appropriate error.  Here is a minimal
example:

$ cat ss.cc
#include <string>

int main()
{
  std::string foo;
  
  return 0;
}

$ g++ -g ss.cc -o ss

$ gdb --quiet ./ss
(gdb) r
Starting program: /tmp/false_sigsegv/ss.exe 

Program received signal SIGSEGV, Segmentation fault.
0x610af8b8 in pthread_key_create (key=0x482c08, destructor=0) at
/usr/src/sourceware/winsup/cygwin/thread.cc:129
129       if ((*object)->magic != magic)
(gdb) c
Continuing.

Program exited normally.
(gdb) 

Here pthread_key_create() was simply checking to see if 'key' happened to be a
previously-initiaized object, which in most cases is not true, and so the fault
is expected and handled.  However, it's very inconvenient and unintuitive that
gdb still stops the program, and it makes the user think there is something
wrong with his program and/or the Cygwin library.

The attached patch adds a very simple mechanism by which the Cygwin program
shall signal to gdb that it has temporarily installed its own fault handler for
EXCEPTION_ACCESS_VIOLATION, so that gdb can deal with this more gracefully by
ignoring these faults.  This uses the existing WriteDebugString() mechanism that
Cygwin already uses to communicate to the debugger, but just extends it by
defining two new "magic" string values.

I've split the patch into two parts since it requires changes to both cygwin and
gdb.

Brian

winsup/cygwin:
2006-02-02  Brian Dessent  <brian@dessent.net>

	* cygtls.h: Include sys/cygwin.h.
	(myfault::~myfault): If a debugger is present, inform it that our fault
	handler has been removed.
	(myfault::faulted): Likewise for when the fault handler is installed.
	* include/sys/cygwin.h (_CYGWIN_FAULT_IGNORE_STRING): Add define.
	(_CYGWIN_FAULT_NOIGNORE_STRING): Ditto.


gdb:
2006-02-02  Brian Dessent  <brian@dessent.net>

	* win32-nat.c (_CYGWIN_SIGNAL_STRING): Remove duplicated definition.
	(ignoring_faults): Define new static global.
	(handle_output_debug_string): Check for fault ignore/noignore signals
	from the inferior.
	(handle_exception): Do not process the fault if 'ignoring_faults' is
	set.
	(do_initial_win32_stuff): Initialize 'ignoring_faults'.
--------------830DBFDDBE959A9C0C175F1F
Content-Type: text/plain; charset=us-ascii;
 name="cygwin-gdb-ignorefaults.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cygwin-gdb-ignorefaults.patch"
Content-length: 2110

Index: cygtls.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/cygtls.h,v
retrieving revision 1.42
diff -u -p -r1.42 cygtls.h
--- cygtls.h	23 Dec 2005 22:50:20 -0000	1.42
+++ cygtls.h	2 Feb 2006 11:43:23 -0000
@@ -1,6 +1,6 @@
 /* cygtls.h
 
-   Copyright 2003, 2004, 2005 Red Hat, Inc.
+   Copyright 2003, 2004, 2005, 2006 Red Hat, Inc.
 
 This software is a copyrighted work licensed under the terms of the
 Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
@@ -22,6 +22,7 @@ details. */
 #include <netinet/in.h>
 typedef unsigned int SOCKET;
 #endif
+#include <sys/cygwin.h>
 
 #define CYGTLS_INITIALIZED 0x43227
 #define CYGTLSMAGIC "D0Ub313v31nm&G1c?";
@@ -242,9 +243,16 @@ class myfault
   jmp_buf buf;
   san sebastian;
 public:
-  ~myfault () __attribute__ ((always_inline)) { _my_tls.reset_fault (sebastian); }
+  ~myfault () __attribute__ ((always_inline))
+  {
+    _my_tls.reset_fault (sebastian);
+    if (being_debugged ())
+      OutputDebugString (_CYGWIN_FAULT_NOIGNORE_STRING);
+  }
   inline int faulted (int myerrno = 0) __attribute__ ((always_inline))
   {
+    if (being_debugged ())
+      OutputDebugString (_CYGWIN_FAULT_IGNORE_STRING);
     return _my_tls.setup_fault (buf, sebastian, myerrno);
   }
 };
Index: include/sys/cygwin.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/sys/cygwin.h,v
retrieving revision 1.61
diff -u -p -r1.61 cygwin.h
--- include/sys/cygwin.h	1 Nov 2005 05:55:30 -0000	1.61
+++ include/sys/cygwin.h	2 Feb 2006 11:43:23 -0000
@@ -1,6 +1,6 @@
 /* sys/cygwin.h
 
-   Copyright 1997, 1998, 2000, 2001, 2002 Red Hat, Inc.
+   Copyright 1997, 1998, 2000, 2001, 2002, 2006 Red Hat, Inc.
 
 This file is part of Cygwin.
 
@@ -18,6 +18,8 @@ extern "C" {
 #endif
 
 #define _CYGWIN_SIGNAL_STRING "cYgSiGw00f"
+#define _CYGWIN_FAULT_IGNORE_STRING "cYgfAuLtIg"
+#define _CYGWIN_FAULT_NOIGNORE_STRING "cYgNofAuLtIg"
 
 extern pid_t cygwin32_winpid_to_pid (int);
 extern void cygwin32_win32_to_posix_path_list (const char *, char *);


--------------830DBFDDBE959A9C0C175F1F
Content-Type: text/plain; charset=us-ascii;
 name="cygwin-gdb-ignorefaults2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cygwin-gdb-ignorefaults2.patch"
Content-length: 3461

Index: win32-nat.c
===================================================================
RCS file: /cvs/src/src/gdb/win32-nat.c,v
retrieving revision 1.119
diff -u -p -r1.119 win32-nat.c
--- win32-nat.c	24 Jan 2006 22:09:28 -0000	1.119
+++ win32-nat.c	2 Feb 2006 11:44:08 -0000
@@ -83,12 +83,6 @@ static unsigned dr[8];
 static int debug_registers_changed;
 static int debug_registers_used;
 
-/* The string sent by cygwin when it processes a signal.
-   FIXME: This should be in a cygwin include file. */
-#ifndef _CYGWIN_SIGNAL_STRING
-#define _CYGWIN_SIGNAL_STRING "cYgSiGw00f"
-#endif
-
 #define CHECK(x)	check (x, __FILE__,__LINE__)
 #define DEBUG_EXEC(x)	if (debug_exec)		printf_unfiltered x
 #define DEBUG_EVENTS(x)	if (debug_events)	printf_unfiltered x
@@ -126,6 +120,12 @@ static DEBUG_EVENT current_event;	/* The
 static HANDLE current_process_handle;	/* Currently executing process */
 static thread_info *current_thread;	/* Info on currently selected thread */
 static DWORD main_thread_id;		/* Thread ID of the main thread */
+static int ignoring_faults;             /* If true, the inferior has signaled
+                                           that it is doing parameter checking
+                                           and has supplied its own
+                                           EXCEPTION_ACCESS_VIOLATION handler,
+                                           and there is no need to act on
+                                           them here.  */
 
 /* Counts of things. */
 static int exception_count = 0;
@@ -905,12 +905,7 @@ handle_output_debug_string (struct targe
       || !s || !*s)
     return gotasig;
 
-  if (strncmp (s, _CYGWIN_SIGNAL_STRING, sizeof (_CYGWIN_SIGNAL_STRING) - 1) != 0)
-    {
-      if (strncmp (s, "cYg", 3) != 0)
-	warning (("%s"), s);
-    }
-  else
+  if (strncmp (s, _CYGWIN_SIGNAL_STRING, sizeof (_CYGWIN_SIGNAL_STRING) - 1) == 0)
     {
       char *p;
       int sig = strtol (s + sizeof (_CYGWIN_SIGNAL_STRING) - 1, &p, 0);
@@ -919,6 +914,21 @@ handle_output_debug_string (struct targe
       if (gotasig)
 	ourstatus->kind = TARGET_WAITKIND_STOPPED;
     }
+  else if (strncmp (s, _CYGWIN_FAULT_IGNORE_STRING, 
+		    sizeof (_CYGWIN_FAULT_IGNORE_STRING) - 1) == 0)
+    {
+      ignoring_faults = TRUE;
+    }
+  else if (strncmp (s, _CYGWIN_FAULT_NOIGNORE_STRING, 
+		    sizeof (_CYGWIN_FAULT_NOIGNORE_STRING) - 1) == 0)
+    {
+      ignoring_faults = FALSE;
+    }
+  else
+    {
+      if (strncmp (s, "cYg", 3) != 0)
+	warning (("%s"), s);
+    }
 
   xfree (s);
   return gotasig;
@@ -1066,10 +1076,11 @@ handle_exception (struct target_waitstat
       ourstatus->value.sig = TARGET_SIGNAL_SEGV;
       {
 	char *fn;
-	if (find_pc_partial_function ((CORE_ADDR) current_event.u.Exception
-				      .ExceptionRecord.ExceptionAddress,
-				      &fn, NULL, NULL)
-	    && strncmp (fn, "KERNEL32!IsBad", strlen ("KERNEL32!IsBad")) == 0)
+	if (ignoring_faults
+	    || (find_pc_partial_function ((CORE_ADDR) current_event.u.Exception
+					  .ExceptionRecord.ExceptionAddress,
+					  &fn, NULL, NULL)
+		&& strncmp (fn, "KERNEL32!IsBad", strlen ("KERNEL32!IsBad")) == 0))
 	  return 0;
       }
       break;
@@ -1434,6 +1445,7 @@ do_initial_win32_stuff (DWORD pid)
   exception_count = 0;
   debug_registers_changed = 0;
   debug_registers_used = 0;
+  ignoring_faults = FALSE;
   for (i = 0; i < sizeof (dr) / sizeof (dr[0]); i++)
     dr[i] = 0;
   current_event.dwProcessId = pid;


--------------830DBFDDBE959A9C0C175F1F--
