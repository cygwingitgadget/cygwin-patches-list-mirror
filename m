Return-Path: <cygwin-patches-return-3040-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 504 invoked by alias); 24 Sep 2002 13:17:19 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 488 invoked from network); 24 Sep 2002 13:17:18 -0000
X-WM-Posted-At: avacado.atomice.net; Tue, 24 Sep 02 14:17:15 +0100
From: "Chris January" <chris@atomice.net>
To: "Cygwin-Patches@Cygwin.Com" <cygwin-patches@cygwin.com>
Subject: changes to /proc ctty and uid/gid handling
Date: Tue, 24 Sep 2002 06:17:00 -0000
Message-ID: <LPEHIHGCJOAIPFLADJAHOEIFCNAA.chris@atomice.net>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_000B_01C263D5.15207DF0"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
X-SW-Source: 2002-q3/txt/msg00488.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_000B_01C263D5.15207DF0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-length: 2203

I hope this isn't too late for 1.3.13.

This fixes the bug where processes showed up as the wrong user in procps.
Also, procps should now report the correct tty a proces is running on.

Chris

---

2002-09-24  Christopher January <chris@atomice.net>

	* fhandler_proc.cc (format_process_stat): make ctty a real device number.
	(format_process_status): use effective uid/gid as real and saved uid/gid.

---

Index: fhandler_process.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_process.cc,v
retrieving revision 1.19
diff -u -3 -p -u -p -r1.19 fhandler_process.cc
--- fhandler_process.cc	31 Aug 2002 16:37:51 -0000	1.19
+++ fhandler_process.cc	24 Sep 2002 13:13:30 -0000
@@ -25,6 +25,7 @@ details. */
 #include "ntdll.h"
 #include <sys/param.h>
 #include <assert.h>
+#include <sys/sysmacros.h>

 #define _COMPILING_NEWLIB
 #include <dirent.h>
@@ -486,7 +487,7 @@ format_process_stat (_pinfo *p, char *de
 				   "%lu",
 			  p->pid, cmd,
 			  state,
-			  p->ppid, p->pgid, p->sid, p->ctty, -1,
+              p->ppid, p->pgid, p->sid, makedev (FH_TTYS, p->ctty), -1,
 			  0, fault_count, fault_count, 0, 0, utime, stime,
 			  utime, stime, priority, 0, 0, 0,
 			  start_time, vmsize,
@@ -556,6 +557,9 @@ format_process_status (_pinfo *p, char *
       vmsize *= page_size; vmrss *= page_size; vmdata *= page_size;
       vmtext *= page_size; vmlib *= page_size;
     }
+  // The real uid value for *this* process is stored at
cygheap->user.real_uid
+  // but we can't get at the real uid value for any other process, so
+  // just fake it as p->uid. Similar for p->gid.
   return __small_sprintf (destbuf, "Name:   %s\n"
 				   "State:  %c (%s)\n"
 				   "Tgid:   %d\n"
@@ -578,8 +582,8 @@ format_process_status (_pinfo *p, char *
 			  p->pgid,
 			  p->pid,
 			  p->ppid,
-			  p->uid, cygheap->user.real_uid, cygheap->user.real_uid, p->uid,
-			  p->gid, cygheap->user.real_gid, cygheap->user.real_gid, p->gid,
+              p->uid, p->uid, p->uid, p->uid,
+              p->gid, p->gid, p->gid, p->gid,
 			  vmsize >> 10, 0, vmrss >> 10, vmdata >> 10, 0, vmtext >> 10, vmlib >>
10,
 			  0, 0, p->getsigmask ()
 			  );

------=_NextPart_000_000B_01C263D5.15207DF0
Content-Type: application/octet-stream;
	name="ChangeLog"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ChangeLog"
Content-length: 203

2002-09-24  Christopher January <chris@atomice.net>

	* fhandler_proc.cc (format_process_stat): make ctty a real device number.
	(format_process_status): use effective uid/gid as real and saved uid/gid.

------=_NextPart_000_000B_01C263D5.15207DF0
Content-Type: application/octet-stream;
	name="proc.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="proc.patch"
Content-length: 2133

Index: fhandler_process.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/fhandler_process.cc,v=0A=
retrieving revision 1.19=0A=
diff -u -3 -p -u -p -r1.19 fhandler_process.cc=0A=
--- fhandler_process.cc	31 Aug 2002 16:37:51 -0000	1.19=0A=
+++ fhandler_process.cc	24 Sep 2002 13:13:30 -0000=0A=
@@ -25,6 +25,7 @@ details. */=0A=
 #include "ntdll.h"=0A=
 #include <sys/param.h>=0A=
 #include <assert.h>=0A=
+#include <sys/sysmacros.h>=0A=
=20=0A=
 #define _COMPILING_NEWLIB=0A=
 #include <dirent.h>=0A=
@@ -486,7 +487,7 @@ format_process_stat (_pinfo *p, char *de=0A=
 				   "%lu",=0A=
 			  p->pid, cmd,=0A=
 			  state,=0A=
-			  p->ppid, p->pgid, p->sid, p->ctty, -1,=0A=
+              p->ppid, p->pgid, p->sid, makedev (FH_TTYS, p->ctty), -1,=0A=
 			  0, fault_count, fault_count, 0, 0, utime, stime,=0A=
 			  utime, stime, priority, 0, 0, 0,=0A=
 			  start_time, vmsize,=0A=
@@ -556,6 +557,9 @@ format_process_status (_pinfo *p, char *=0A=
       vmsize *=3D page_size; vmrss *=3D page_size; vmdata *=3D page_size;=
=0A=
       vmtext *=3D page_size; vmlib *=3D page_size;=0A=
     }=0A=
+  // The real uid value for *this* process is stored at cygheap->user.real=
_uid=0A=
+  // but we can't get at the real uid value for any other process, so=0A=
+  // just fake it as p->uid. Similar for p->gid.=0A=
   return __small_sprintf (destbuf, "Name:   %s\n"=0A=
 				   "State:  %c (%s)\n"=0A=
 				   "Tgid:   %d\n"=0A=
@@ -578,8 +582,8 @@ format_process_status (_pinfo *p, char *=0A=
 			  p->pgid,=0A=
 			  p->pid,=0A=
 			  p->ppid,=0A=
-			  p->uid, cygheap->user.real_uid, cygheap->user.real_uid, p->uid,=0A=
-			  p->gid, cygheap->user.real_gid, cygheap->user.real_gid, p->gid,=0A=
+              p->uid, p->uid, p->uid, p->uid,=0A=
+              p->gid, p->gid, p->gid, p->gid,=0A=
 			  vmsize >> 10, 0, vmrss >> 10, vmdata >> 10, 0, vmtext >> 10, vmlib >>=
 10,=0A=
 			  0, 0, p->getsigmask ()=0A=
 			  );=0A=

------=_NextPart_000_000B_01C263D5.15207DF0--
