Return-Path: <cygwin-patches-return-3521-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3969 invoked by alias); 6 Feb 2003 12:16:15 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 3960 invoked from network); 6 Feb 2003 12:16:14 -0000
Date: Thu, 06 Feb 2003 12:16:00 -0000
From: Vaclav Haisman <V.Haisman@sh.cvut.cz>
To: cygwin-patches@cygwin.com
Subject: Re: Implementation of sched_rr_get_interval for NT systems.
In-Reply-To: <20030206022912.GC14293@redhat.com>
Message-ID: <20030206114758.I78867-100000@logout.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: AMaViS at Silicon Hill
X-Spam-Status: No, hits=0.0 required=5.0
	tests=CARRIAGE_RETURNS,IN_REP_TO,SPAM_PHRASE_01_02
	version=2.43
X-Spam-Level: 
X-SW-Source: 2003-q1/txt/msg00170.txt.bz2


Huh, I really don't know why I typed -c instead of -u. This is the same patch
with addition of error checking on registry access as suggested by Robert
Collins. Now with the right diff options. I am working on submitting the
assignment too.

Vaclav Haisman


> You're not wrong and it does matter.
>
> I will give this function more inspection later, but for the future please
> submit using the options that Igor specified.
>
> Robert is right that you do need an assignment, too.  This is adding new
> functionality.
>
> Thanks for the patch and sorry for the rules.  :-)
>
> cgf
>

2003-02-06  Vaclav Haisman  <V.Haisman@sh.cvut.cz>
        * Makefile.in: Add libusr32.a to DLL_IMPORTS.
        * wincap.h (wincaps::is_server): New flag.
        (wincapc::version): Change type to OSVERSIONINFOEX.
        (wincapc::is_server): New function.
        * wincap.cc (wincap_unknown::is_server): New initializer.
        (wincap_95): Ditto.
        (wincap_95osr2): Ditto.
        (wincap_98): Ditto.
        (wincap_me): Ditto.
        (wincap_nt3): Ditto.
        (wincap_nt4): Ditto.
        (wincap_nt4sp4): Ditto.
        (wincap_2000): Ditto.
        (wincap_xp): Ditto.
        (wincapc::init): Adapt to OSVERSIONINFOEX. Add detection of NT
        server systems.
        * sched.cc: Include windows.h and registry.h.
        (sched_rr_get_interval): Re-implement for NT systems.


Index: cygwin/Makefile.in
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/Makefile.in,v
retrieving revision 1.114
diff -u -p -r1.114 Makefile.in
--- cygwin/Makefile.in	24 Jan 2003 03:53:46 -0000	1.114
+++ cygwin/Makefile.in	6 Feb 2003 12:06:57 -0000
@@ -141,7 +141,7 @@ EXTRA_OFILES=$(bupdir1)/libiberty/random

 MALLOC_OFILES=@MALLOC_OFILES@

-DLL_IMPORTS:=$(w32api_lib)/libkernel32.a
+DLL_IMPORTS:=$(w32api_lib)/libkernel32.a $(w32api_lib)/libuser32.a

 # Please maintain this list in sorted order, with maximum files per 80 col line
 DLL_OFILES:=assert.o autoload.o cxx.o cygheap.o cygserver_client.o \
Index: cygwin/wincap.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/wincap.h,v
retrieving revision 1.14
diff -u -p -r1.14 wincap.h
--- cygwin/wincap.h	15 Oct 2002 17:04:20 -0000	1.14
+++ cygwin/wincap.h	6 Feb 2003 12:06:57 -0000
@@ -17,6 +17,7 @@ struct wincaps
   DWORD    chunksize;
   int      shared;
   unsigned is_winnt                                     : 1;
+  unsigned is_server                                    : 1;
   unsigned access_denied_on_delete                      : 1;
   unsigned has_delete_on_close                          : 1;
   unsigned has_page_guard                               : 1;
@@ -53,9 +54,9 @@ struct wincaps

 class wincapc
 {
-  OSVERSIONINFO version;
-  char          osnam[40];
-  void          *caps;
+  OSVERSIONINFOEX  version;
+  char             osnam[40];
+  void             *caps;

 public:
   void init ();
@@ -70,6 +71,7 @@ public:
   DWORD IMPLEMENT (chunksize)
   int   IMPLEMENT (shared)
   bool  IMPLEMENT (is_winnt)
+  bool  IMPLEMENT (is_server)
   bool  IMPLEMENT (access_denied_on_delete)
   bool  IMPLEMENT (has_delete_on_close)
   bool  IMPLEMENT (has_page_guard)
Index: cygwin/wincap.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/wincap.cc,v
retrieving revision 1.18
diff -u -p -r1.18 wincap.cc
--- cygwin/wincap.cc	15 Oct 2002 17:04:20 -0000	1.18
+++ cygwin/wincap.cc	6 Feb 2003 12:07:02 -0000
@@ -16,6 +16,7 @@ static NO_COPY wincaps wincap_unknown =
   chunksize:0x0,
   shared:FILE_SHARE_READ | FILE_SHARE_WRITE,
   is_winnt:false,
+  is_server:false,
   access_denied_on_delete:false,
   has_delete_on_close:false,
   has_page_guard:false,
@@ -55,6 +56,7 @@ static NO_COPY wincaps wincap_95 = {
   chunksize:32 * 1024 * 1024,
   shared:FILE_SHARE_READ | FILE_SHARE_WRITE,
   is_winnt:false,
+  is_server:false,
   access_denied_on_delete:true,
   has_delete_on_close:false,
   has_page_guard:false,
@@ -94,6 +96,7 @@ static NO_COPY wincaps wincap_95osr2 = {
   chunksize:32 * 1024 * 1024,
   shared:FILE_SHARE_READ | FILE_SHARE_WRITE,
   is_winnt:false,
+  is_server:false,
   access_denied_on_delete:true,
   has_delete_on_close:false,
   has_page_guard:false,
@@ -133,6 +136,7 @@ static NO_COPY wincaps wincap_98 = {
   chunksize:32 * 1024 * 1024,
   shared:FILE_SHARE_READ | FILE_SHARE_WRITE,
   is_winnt:false,
+  is_server:false,
   access_denied_on_delete:true,
   has_delete_on_close:false,
   has_page_guard:false,
@@ -172,6 +176,7 @@ static NO_COPY wincaps wincap_98se = {
   chunksize:32 * 1024 * 1024,
   shared:FILE_SHARE_READ | FILE_SHARE_WRITE,
   is_winnt:false,
+  is_server:false,
   access_denied_on_delete:true,
   has_delete_on_close:false,
   has_page_guard:false,
@@ -211,6 +216,7 @@ static NO_COPY wincaps wincap_me = {
   chunksize:32 * 1024 * 1024,
   shared:FILE_SHARE_READ | FILE_SHARE_WRITE,
   is_winnt:false,
+  is_server:false,
   access_denied_on_delete:true,
   has_delete_on_close:false,
   has_page_guard:false,
@@ -250,6 +256,7 @@ static NO_COPY wincaps wincap_nt3 = {
   chunksize:0,
   shared:FILE_SHARE_READ | FILE_SHARE_WRITE | FILE_SHARE_DELETE,
   is_winnt:true,
+  is_server:false,
   access_denied_on_delete:false,
   has_delete_on_close:true,
   has_page_guard:true,
@@ -289,6 +296,7 @@ static NO_COPY wincaps wincap_nt4 = {
   chunksize:0,
   shared:FILE_SHARE_READ | FILE_SHARE_WRITE | FILE_SHARE_DELETE,
   is_winnt:true,
+  is_server:false,
   access_denied_on_delete:false,
   has_delete_on_close:true,
   has_page_guard:true,
@@ -328,6 +336,7 @@ static NO_COPY wincaps wincap_nt4sp4 = {
   chunksize:0,
   shared:FILE_SHARE_READ | FILE_SHARE_WRITE | FILE_SHARE_DELETE,
   is_winnt:true,
+  is_server:false,
   access_denied_on_delete:false,
   has_delete_on_close:true,
   has_page_guard:true,
@@ -367,6 +376,7 @@ static NO_COPY wincaps wincap_2000 = {
   chunksize:0,
   shared:FILE_SHARE_READ | FILE_SHARE_WRITE | FILE_SHARE_DELETE,
   is_winnt:true,
+  is_server:false,
   access_denied_on_delete:false,
   has_delete_on_close:true,
   has_page_guard:true,
@@ -406,6 +416,7 @@ static NO_COPY wincaps wincap_xp = {
   chunksize:0,
   shared:FILE_SHARE_READ | FILE_SHARE_WRITE | FILE_SHARE_DELETE,
   is_winnt:true,
+  is_server:false,
   access_denied_on_delete:false,
   has_delete_on_close:true,
   has_page_guard:true,
@@ -451,8 +462,8 @@ wincapc::init ()
     return;		// already initialized

   memset (&version, 0, sizeof version);
-  version.dwOSVersionInfoSize = sizeof version;
-  GetVersionEx (&version);
+  version.dwOSVersionInfoSize = sizeof (OSVERSIONINFO);
+  GetVersionEx (reinterpret_cast<LPOSVERSIONINFO>(&version));

   switch (version.dwPlatformId)
     {
@@ -515,6 +526,15 @@ wincapc::init ()
 	caps = &wincap_unknown;
 	break;
     }
+
+  if (((wincaps *)this->caps)->is_winnt && version.dwMajorVersion > 4)
+    {
+      version.dwOSVersionInfoSize = sizeof version;
+      GetVersionEx (reinterpret_cast<LPOSVERSIONINFO>(&version));
+      if (version.wProductType != VER_NT_WORKSTATION)
+	((wincaps *)this->caps)->is_server = true;
+    }
+
   __small_sprintf (osnam, "%s-%d.%d", os, version.dwMajorVersion,
 		   version.dwMinorVersion);
 }
Index: cygwin/sched.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/sched.cc,v
retrieving revision 1.7
diff -u -p -r1.7 sched.cc
--- cygwin/sched.cc	13 Nov 2002 19:36:12 -0000	1.7
+++ cygwin/sched.cc	6 Feb 2003 12:07:03 -0000
@@ -14,6 +14,7 @@
 # include "config.h"
 #endif

+#include <windows.h>
 #include "winsup.h"
 #include <limits.h>
 #include <errno.h>
@@ -25,6 +26,8 @@
 #include "pinfo.h"
 /* for getpid */
 #include <unistd.h>
+#include "registry.h"
+

 /* Win32 priority to UNIX priority Mapping.
    For now, I'm just following the spec: any range of priorities is ok.
@@ -249,22 +252,76 @@ sched_getscheduler (pid_t pid)
 }

 /* get the time quantum for pid
-
-   We can't return -11, errno ENOSYS, because that implies that
-   sched_get_priority_max & min are also not supported (according to the spec)
-   so some spec-driven autoconf tests will likely assume they aren't present either
-
-   returning ESRCH might confuse some applications (if they assumed that when
-   rr_get_interval is called on pid 0 it always works).
-
-   If someone knows the time quanta for the various win32 platforms, then a
-   simple check for the os we're running on will finish this function
+
+   Implemented only for NT systems, it fails and sets errno to ESRCH
+   for non-NT systems.
 */
 int
 sched_rr_get_interval (pid_t pid, struct timespec *interval)
 {
-  set_errno (ESRCH);
-  return -1;
+  static const char quantable[2][2][3] =
+    {{{12, 24, 36}, { 6, 12, 18}},
+     {{36, 36, 36}, {18, 18, 18}}};
+  /* FIXME: Clocktickinterval can be 15 ms for multi-processor system. */
+  static const int clocktickinterval = 10;
+  static const int quantapertick = 3;
+
+  HWND forwin;
+  DWORD forprocid;
+  int vfindex, slindex, qindex, prisep;
+  long nsec;
+
+  if (!wincap.is_winnt ())
+    {
+      set_errno (ESRCH);
+      return -1;
+    }
+
+  forwin = GetForegroundWindow ();
+  if (!forwin)
+    GetWindowThreadProcessId (forwin, &forprocid);
+  else
+    forprocid = 0;
+
+  reg_key reg (HKEY_LOCAL_MACHINE, KEY_READ, "SYSTEM", "CurrentControlSet",
+               "Control", "PriorityControl", NULL);
+  if (reg.error ())
+    {
+      set_errno (ESRCH);
+      return -1;
+    }
+  prisep = reg.get_int ("Win32PrioritySeparation", 2);
+  pinfo pi (pid ? pid : myself->pid);
+  if (!pi)
+    {
+      set_errno (ESRCH);
+      return -1;
+    }
+
+  if (pi->dwProcessId == forprocid)
+    {
+      qindex = prisep & 3;
+      qindex = qindex == 3 ? 2 : qindex;
+    }
+  else
+    qindex = 0;
+  vfindex = ((prisep >> 2) & 3) % 3;
+  if (vfindex == 0)
+    vfindex = wincap.is_server () || prisep & 3 == 0 ? 1 : 0;
+  else
+    vfindex -= 1;
+  slindex = ((prisep >> 4) & 3) % 3;
+  if (slindex == 0)
+    slindex = wincap.is_server () ? 1 : 0;
+  else
+    slindex -= 1;
+
+  nsec = quantable[vfindex][slindex][qindex] / quantapertick
+    * clocktickinterval * 1000000;
+  interval->tv_sec = nsec / 1000000000;
+  interval->tv_nsec = nsec % 1000000000;
+
+  return 0;
 }

 /* set the scheduling parameters */
