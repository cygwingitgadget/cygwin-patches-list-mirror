Return-Path: <cygwin-patches-return-3515-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23226 invoked by alias); 6 Feb 2003 00:50:08 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 23215 invoked from network); 6 Feb 2003 00:50:07 -0000
Date: Thu, 06 Feb 2003 00:50:00 -0000
From: Vaclav Haisman <V.Haisman@sh.cvut.cz>
To: cygwin-patches@cygwin.com
Subject: Implementation of sched_rr_get_interval for NT systems.
Message-ID: <20030206012720.V68017-100000@logout.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: AMaViS at Silicon Hill
X-Spam-Status: No, hits=-1.3 required=5.0
	tests=CARRIAGE_RETURNS,PATCH_CONTEXT_DIFF,SPAM_PHRASE_00_01
	version=2.43
X-Spam-Level: 
X-SW-Source: 2003-q1/txt/msg00164.txt.bz2


Hi,
this patch implements sched_rr_get_interval for NT systems. The patch consists
of two parts.

The first part is detection of NT server systems, NT servers have different
time quanta than workstations. Unfortunately the server detection is not
perfect because GetVersionEx call with OSVERSIONINFOEX structure is supported
only on NT 4 SP6 and newer system. Therefore new is_system wincaps flag
defaults to false as I assume that there are more NT workstations than servers.

The second part is implementation of sched_rr_get_interval in sched.cc itself.
I have used two main sources of informations about time quanta for NT systems.
Those sources are two web pages:
http://www.microsoft.com/mspress/books/sampchap/4354c.asp
http://www.jsifaq.com/SUBH/tip3700/rh3795.htm

Vaclav Haisman


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
diff -p -c -r1.114 Makefile.in
*** cygwin/Makefile.in	24 Jan 2003 03:53:46 -0000	1.114
--- cygwin/Makefile.in	5 Feb 2003 23:58:43 -0000
*************** EXTRA_OFILES=$(bupdir1)/libiberty/random
*** 141,147 ****

  MALLOC_OFILES=@MALLOC_OFILES@

! DLL_IMPORTS:=$(w32api_lib)/libkernel32.a

  # Please maintain this list in sorted order, with maximum files per 80 col line
  DLL_OFILES:=assert.o autoload.o cxx.o cygheap.o cygserver_client.o \
--- 141,147 ----

  MALLOC_OFILES=@MALLOC_OFILES@

! DLL_IMPORTS:=$(w32api_lib)/libkernel32.a $(w32api_lib)/libuser32.a

  # Please maintain this list in sorted order, with maximum files per 80 col line
  DLL_OFILES:=assert.o autoload.o cxx.o cygheap.o cygserver_client.o \
Index: cygwin/sched.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/sched.cc,v
retrieving revision 1.7
diff -p -c -r1.7 sched.cc
*** cygwin/sched.cc	13 Nov 2002 19:36:12 -0000	1.7
--- cygwin/sched.cc	5 Feb 2003 23:58:55 -0000
***************
*** 14,19 ****
--- 14,20 ----
  # include "config.h"
  #endif

+ #include <windows.h>
  #include "winsup.h"
  #include <limits.h>
  #include <errno.h>
***************
*** 25,30 ****
--- 26,33 ----
  #include "pinfo.h"
  /* for getpid */
  #include <unistd.h>
+ #include "registry.h"
+

  /* Win32 priority to UNIX priority Mapping.
     For now, I'm just following the spec: any range of priorities is ok.
*************** sched_getscheduler (pid_t pid)
*** 249,270 ****
  }

  /* get the time quantum for pid
!
!    We can't return -11, errno ENOSYS, because that implies that
!    sched_get_priority_max & min are also not supported (according to the spec)
!    so some spec-driven autoconf tests will likely assume they aren't present either
!
!    returning ESRCH might confuse some applications (if they assumed that when
!    rr_get_interval is called on pid 0 it always works).
!
!    If someone knows the time quanta for the various win32 platforms, then a
!    simple check for the os we're running on will finish this function
  */
  int
  sched_rr_get_interval (pid_t pid, struct timespec *interval)
  {
!   set_errno (ESRCH);
!   return -1;
  }

  /* set the scheduling parameters */
--- 252,322 ----
  }

  /* get the time quantum for pid
!
!    Implemented only for NT systems, it fails and sets errno to ESRCH
!    for non-NT systems.
  */
  int
  sched_rr_get_interval (pid_t pid, struct timespec *interval)
  {
!   static const char quantable[2][2][3] =
!     {{{12, 24, 36}, { 6, 12, 18}},
!      {{36, 36, 36}, {18, 18, 18}}};
!   /* FIXME: Clocktickinterval can be 15 ms for multi-processor system. */
!   static const int clocktickinterval = 10;
!   static const int quantapertick = 3;
!
!   HWND forwin;
!   DWORD forprocid;
!   int vfindex, slindex, qindex, prisep;
!   long nsec;
!
!   if (!wincap.is_winnt ())
!     {
!       set_errno (ESRCH);
!       return -1;
!     }
!
!   forwin = GetForegroundWindow ();
!   if (!forwin)
!     GetWindowThreadProcessId (forwin, &forprocid);
!   else
!     forprocid = 0;
!
!   reg_key reg (HKEY_LOCAL_MACHINE, KEY_READ, "SYSTEM", "CurrentControlSet",
!                "Control", "PriorityControl", NULL);
!   prisep = reg.get_int ("Win32PrioritySeparation", 2);
!   pinfo pi (pid ? pid : myself->pid);
!   if (!pi)
!     {
!       set_errno(ESRCH);
!       return -1;
!     }
!
!   if (pi->dwProcessId == forprocid)
!     {
!       qindex = prisep & 3;
!       qindex = qindex == 3 ? 2 : qindex;
!     }
!   else
!     qindex = 0;
!   vfindex = ((prisep >> 2) & 3) % 3;
!   if (vfindex == 0)
!     vfindex = wincap.is_server () || prisep & 3 == 0 ? 1 : 0;
!   else
!     vfindex -= 1;
!   slindex = ((prisep >> 4) & 3) % 3;
!   if (slindex == 0)
!     slindex = wincap.is_server () ? 1 : 0;
!   else
!     slindex -= 1;
!
!   nsec = quantable[vfindex][slindex][qindex] / quantapertick
!     * clocktickinterval * 1000000;
!   interval->tv_sec = nsec / 1000000000;
!   interval->tv_nsec = nsec % 1000000000;
!
!   return 0;
  }

  /* set the scheduling parameters */
Index: cygwin/wincap.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/wincap.cc,v
retrieving revision 1.18
diff -p -c -r1.18 wincap.cc
*** cygwin/wincap.cc	15 Oct 2002 17:04:20 -0000	1.18
--- cygwin/wincap.cc	5 Feb 2003 23:58:58 -0000
*************** static NO_COPY wincaps wincap_unknown =
*** 16,21 ****
--- 16,22 ----
    chunksize:0x0,
    shared:FILE_SHARE_READ | FILE_SHARE_WRITE,
    is_winnt:false,
+   is_server:false,
    access_denied_on_delete:false,
    has_delete_on_close:false,
    has_page_guard:false,
*************** static NO_COPY wincaps wincap_95 = {
*** 55,60 ****
--- 56,62 ----
    chunksize:32 * 1024 * 1024,
    shared:FILE_SHARE_READ | FILE_SHARE_WRITE,
    is_winnt:false,
+   is_server:false,
    access_denied_on_delete:true,
    has_delete_on_close:false,
    has_page_guard:false,
*************** static NO_COPY wincaps wincap_95osr2 = {
*** 94,99 ****
--- 96,102 ----
    chunksize:32 * 1024 * 1024,
    shared:FILE_SHARE_READ | FILE_SHARE_WRITE,
    is_winnt:false,
+   is_server:false,
    access_denied_on_delete:true,
    has_delete_on_close:false,
    has_page_guard:false,
*************** static NO_COPY wincaps wincap_98 = {
*** 133,138 ****
--- 136,142 ----
    chunksize:32 * 1024 * 1024,
    shared:FILE_SHARE_READ | FILE_SHARE_WRITE,
    is_winnt:false,
+   is_server:false,
    access_denied_on_delete:true,
    has_delete_on_close:false,
    has_page_guard:false,
*************** static NO_COPY wincaps wincap_98se = {
*** 172,177 ****
--- 176,182 ----
    chunksize:32 * 1024 * 1024,
    shared:FILE_SHARE_READ | FILE_SHARE_WRITE,
    is_winnt:false,
+   is_server:false,
    access_denied_on_delete:true,
    has_delete_on_close:false,
    has_page_guard:false,
*************** static NO_COPY wincaps wincap_me = {
*** 211,216 ****
--- 216,222 ----
    chunksize:32 * 1024 * 1024,
    shared:FILE_SHARE_READ | FILE_SHARE_WRITE,
    is_winnt:false,
+   is_server:false,
    access_denied_on_delete:true,
    has_delete_on_close:false,
    has_page_guard:false,
*************** static NO_COPY wincaps wincap_nt3 = {
*** 250,255 ****
--- 256,262 ----
    chunksize:0,
    shared:FILE_SHARE_READ | FILE_SHARE_WRITE | FILE_SHARE_DELETE,
    is_winnt:true,
+   is_server:false,
    access_denied_on_delete:false,
    has_delete_on_close:true,
    has_page_guard:true,
*************** static NO_COPY wincaps wincap_nt4 = {
*** 289,294 ****
--- 296,302 ----
    chunksize:0,
    shared:FILE_SHARE_READ | FILE_SHARE_WRITE | FILE_SHARE_DELETE,
    is_winnt:true,
+   is_server:false,
    access_denied_on_delete:false,
    has_delete_on_close:true,
    has_page_guard:true,
*************** static NO_COPY wincaps wincap_nt4sp4 = {
*** 328,333 ****
--- 336,342 ----
    chunksize:0,
    shared:FILE_SHARE_READ | FILE_SHARE_WRITE | FILE_SHARE_DELETE,
    is_winnt:true,
+   is_server:false,
    access_denied_on_delete:false,
    has_delete_on_close:true,
    has_page_guard:true,
*************** static NO_COPY wincaps wincap_2000 = {
*** 367,372 ****
--- 376,382 ----
    chunksize:0,
    shared:FILE_SHARE_READ | FILE_SHARE_WRITE | FILE_SHARE_DELETE,
    is_winnt:true,
+   is_server:false,
    access_denied_on_delete:false,
    has_delete_on_close:true,
    has_page_guard:true,
*************** static NO_COPY wincaps wincap_xp = {
*** 406,411 ****
--- 416,422 ----
    chunksize:0,
    shared:FILE_SHARE_READ | FILE_SHARE_WRITE | FILE_SHARE_DELETE,
    is_winnt:true,
+   is_server:false,
    access_denied_on_delete:false,
    has_delete_on_close:true,
    has_page_guard:true,
*************** wincapc::init ()
*** 450,458 ****
    if (caps)
      return;		// already initialized

!   memset (&version, 0, sizeof version);
!   version.dwOSVersionInfoSize = sizeof version;
!   GetVersionEx (&version);

    switch (version.dwPlatformId)
      {
--- 461,469 ----
    if (caps)
      return;		// already initialized

!   memset (&version, 0, sizeof version);
!   version.dwOSVersionInfoSize = sizeof (OSVERSIONINFO);
!   GetVersionEx (reinterpret_cast<LPOSVERSIONINFO>(&version));

    switch (version.dwPlatformId)
      {
*************** wincapc::init ()
*** 515,520 ****
--- 526,540 ----
  	caps = &wincap_unknown;
  	break;
      }
+
+   if (((wincaps *)this->caps)->is_winnt && version.dwMajorVersion > 4)
+     {
+       version.dwOSVersionInfoSize = sizeof version;
+       GetVersionEx (reinterpret_cast<LPOSVERSIONINFO>(&version));
+       if (version.wProductType != VER_NT_WORKSTATION)
+ 	((wincaps *)this->caps)->is_server = true;
+     }
+
    __small_sprintf (osnam, "%s-%d.%d", os, version.dwMajorVersion,
  		   version.dwMinorVersion);
  }
Index: cygwin/wincap.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/wincap.h,v
retrieving revision 1.14
diff -p -c -r1.14 wincap.h
*** cygwin/wincap.h	15 Oct 2002 17:04:20 -0000	1.14
--- cygwin/wincap.h	5 Feb 2003 23:58:59 -0000
*************** struct wincaps
*** 17,22 ****
--- 17,23 ----
    DWORD    chunksize;
    int      shared;
    unsigned is_winnt                                     : 1;
+   unsigned is_server                                    : 1;
    unsigned access_denied_on_delete                      : 1;
    unsigned has_delete_on_close                          : 1;
    unsigned has_page_guard                               : 1;
*************** struct wincaps
*** 53,61 ****

  class wincapc
  {
!   OSVERSIONINFO version;
!   char          osnam[40];
!   void          *caps;

  public:
    void init ();
--- 54,62 ----

  class wincapc
  {
!   OSVERSIONINFOEX  version;
!   char             osnam[40];
!   void             *caps;

  public:
    void init ();
*************** public:
*** 70,75 ****
--- 71,77 ----
    DWORD IMPLEMENT (chunksize)
    int   IMPLEMENT (shared)
    bool  IMPLEMENT (is_winnt)
+   bool  IMPLEMENT (is_server)
    bool  IMPLEMENT (access_denied_on_delete)
    bool  IMPLEMENT (has_delete_on_close)
    bool  IMPLEMENT (has_page_guard)
