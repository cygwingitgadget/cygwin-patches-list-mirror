Return-Path: <cygwin-patches-return-7313-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10088 invoked by alias); 6 May 2011 05:09:35 -0000
Received: (qmail 10074 invoked by uid 22791); 6 May 2011 05:09:32 -0000
X-SWARE-Spam-Status: No, hits=-1.5 required=5.0	tests=AWL,BAYES_20,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RFC_ABUSE_POST,TW_VP
X-Spam-Check-By: sourceware.org
Received: from mail-iy0-f171.google.com (HELO mail-iy0-f171.google.com) (209.85.210.171)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 06 May 2011 05:09:15 +0000
Received: by iyi20 with SMTP id 20so3363263iyi.2        for <cygwin-patches@cygwin.com>; Thu, 05 May 2011 22:09:14 -0700 (PDT)
Received: by 10.42.147.74 with SMTP id m10mr1883059icv.288.1304658554496;        Thu, 05 May 2011 22:09:14 -0700 (PDT)
Received: from [127.0.0.1] (S0106000cf16f58b1.wp.shawcable.net [174.5.115.130])        by mx.google.com with ESMTPS id ui7sm1098912icb.14.2011.05.05.22.09.12        (version=SSLv3 cipher=OTHER);        Thu, 05 May 2011 22:09:13 -0700 (PDT)
Subject: [PATCH] sysinfo
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
To: cygwin-patches <cygwin-patches@cygwin.com>
Content-Type: multipart/mixed; boundary="=-mOvNYXZPMCregZqsZ3P3"
Date: Fri, 06 May 2011 05:09:00 -0000
Message-ID: <1304658552.5468.7.camel@YAAKOV04>
Mime-Version: 1.0
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q2/txt/msg00079.txt.bz2


--=-mOvNYXZPMCregZqsZ3P3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 500

This implements sysinfo(2), a GNU extension:

http://www.kernel.org/doc/man-pages/online/pages/man2/sysinfo.2.html

The code is partially based on our /proc/meminfo and /proc/uptime code.
(My next patch will port the former to use sysinfo(2), but the latter
cannot as it uses .01s resolution, more than sysinfo's 1s.  That patch
will also fix /proc/meminfo and /proc/swaps for RAM and paging files
larger than 4GB.)

Patches for winsup/cygwin and winsup/doc, plus a test program, attached.


Yaakov


--=-mOvNYXZPMCregZqsZ3P3
Content-Disposition: attachment; filename="sysinfo.patch"
Content-Type: text/x-patch; name="sysinfo.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 7126

2011-05-05  Yaakov Selkowitz  <yselkowitz@...>

	* sysconf.cc (sysinfo): New function.
	* cygwin.din (sysinfo): Export.
	* posix.sgml (std-gnu): Add sysinfo.
	* include/sys/sysinfo.h (struct sysinfo): Define.
	(sysinfo): Declare.
	* include/cygwin/version.h (CYGWIN_VERSION_API_MINOR): Bump.

Index: cygwin.din
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/cygwin.din,v
retrieving revision 1.238
diff -u -r1.238 cygwin.din
--- cygwin.din	4 May 2011 22:12:15 -0000	1.238
+++ cygwin.din	6 May 2011 04:25:50 -0000
@@ -1682,6 +1682,7 @@
 sync SIGFE
 sysconf SIGFE
 _sysconf = sysconf SIGFE
+sysinfo SIGFE
 syslog SIGFE
 _syslog = syslog SIGFE
 system SIGFE
Index: posix.sgml
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/posix.sgml,v
retrieving revision 1.60
diff -u -r1.60 posix.sgml
--- posix.sgml	5 May 2011 06:48:51 -0000	1.60
+++ posix.sgml	6 May 2011 04:25:50 -0000
@@ -1124,6 +1124,7 @@
     removexattr
     setxattr
     strchrnul
+    sysinfo
     tdestroy
     timegm
     timelocal
Index: sysconf.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/sysconf.cc,v
retrieving revision 1.55
diff -u -r1.55 sysconf.cc
--- sysconf.cc	2 May 2011 16:11:06 -0000	1.55
+++ sysconf.cc	6 May 2011 04:25:50 -0000
@@ -1,7 +1,7 @@
 /* sysconf.cc
 
    Copyright 1996, 1997, 1998, 1999, 2000, 2001, 2002, 2003, 2004, 2005,
-   2006, 2007, 2009 Red Hat, Inc.
+   2006, 2007, 2009, 2011 Red Hat, Inc.
 
 This file is part of Cygwin.
 
@@ -17,6 +17,7 @@
 #include "path.h"
 #include "fhandler.h"
 #include "dtable.h"
+#include "pinfo.h"
 #include "ntdll.h"
 
 static long
@@ -317,3 +318,99 @@
 {
   return get_avphys (_SC_AVPHYS_PAGES);
 }
+
+extern "C" int
+sysinfo (struct sysinfo *info)
+{
+  unsigned long long uptime = 0ULL, totalram = 0ULL, freeram = 0ULL,
+		totalswap = 0ULL, freeswap = 0ULL;
+  MEMORYSTATUSEX memory_status;
+  PSYSTEM_PAGEFILE_INFORMATION spi = NULL;
+  ULONG sizeof_spi = 512;
+  PSYSTEM_TIME_OF_DAY_INFORMATION stodi = NULL;
+  ULONG sizeof_stodi = sizeof (SYSTEM_TIME_OF_DAY_INFORMATION);
+  NTSTATUS ret = STATUS_SUCCESS;
+  winpids pids ((DWORD) 0);
+
+  if (!info)
+    {
+      set_errno (EFAULT);
+      return -1;
+    }
+
+  stodi = (PSYSTEM_TIME_OF_DAY_INFORMATION) malloc (sizeof_stodi);
+  ret = NtQuerySystemInformation (SystemTimeOfDayInformation, (PVOID) stodi,
+				  sizeof_stodi, NULL);
+  if (NT_SUCCESS (ret))
+    uptime = (stodi->CurrentTime.QuadPart - stodi->BootTime.QuadPart) / 10000000ULL;
+  else
+    {
+      debug_printf ("NtQuerySystemInformation(SystemTimeOfDayInformation), "
+		  "status %p", ret);
+    }
+
+  if (stodi)
+    free (stodi);
+
+  memory_status.dwLength = sizeof (MEMORYSTATUSEX);
+  GlobalMemoryStatusEx (&memory_status);
+  totalram = memory_status.ullTotalPhys / getsystempagesize ();
+  freeram = memory_status.ullAvailPhys / getsystempagesize ();
+
+  spi = (PSYSTEM_PAGEFILE_INFORMATION) malloc (sizeof_spi);
+  if (spi)
+    {
+      ret = NtQuerySystemInformation (SystemPagefileInformation, (PVOID) spi,
+				      sizeof_spi, &sizeof_spi);
+      if (ret == STATUS_INFO_LENGTH_MISMATCH)
+	{
+	  free (spi);
+	  spi = (PSYSTEM_PAGEFILE_INFORMATION) malloc (sizeof_spi);
+	  if (spi)
+	    ret = NtQuerySystemInformation (SystemPagefileInformation,
+					    (PVOID) spi, sizeof_spi, &sizeof_spi);
+	}
+    }
+  if (!spi || ret || (!ret && GetLastError () == ERROR_PROC_NOT_FOUND))
+    {
+      debug_printf ("NtQuerySystemInformation(SystemPagefileInformation), "
+		  "status %p", ret);
+      totalswap = (memory_status.ullTotalPageFile - memory_status.ullTotalPhys)
+                        / getsystempagesize ();
+      freeswap = (memory_status.ullAvailPageFile - memory_status.ullTotalPhys)
+                        / getsystempagesize ();
+    }
+  else
+    {
+      PSYSTEM_PAGEFILE_INFORMATION spp = spi;
+      do
+	{
+	  totalswap += spp->CurrentSize;
+	  freeswap += spp->CurrentSize - spp->TotalUsed;
+	}
+      while (spp->NextEntryOffset
+	     && (spp = (PSYSTEM_PAGEFILE_INFORMATION)
+			   ((char *) spp + spp->NextEntryOffset)));
+    }
+  if (spi)
+    free (spi);
+
+  info->uptime = (long) uptime;
+  info->totalram = (unsigned long) totalram;
+  info->freeram = (unsigned long) freeram;
+  info->totalswap = (unsigned long) totalswap;
+  info->freeswap = (unsigned long) freeswap;
+  info->procs = (unsigned short) pids.npids;
+  info->mem_unit = (unsigned int) getsystempagesize ();
+
+  /* FIXME: unsupported */
+  info->loads[0] = 0UL;
+  info->loads[1] = 0UL;
+  info->loads[2] = 0UL;
+  info->sharedram = 0UL;
+  info->bufferram = 0UL;
+  info->totalhigh = 0UL;
+  info->freehigh = 0UL;
+
+  return 0;
+}
Index: include/cygwin/version.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/cygwin/version.h,v
retrieving revision 1.343
diff -u -r1.343 version.h
--- include/cygwin/version.h	4 May 2011 22:12:15 -0000	1.343
+++ include/cygwin/version.h	6 May 2011 04:25:50 -0000
@@ -408,12 +408,13 @@
       241: Export pthread_attr_getstack, pthread_attr_getstackaddr,
 	   pthread_getattr_np.
       242: Export psiginfo, psignal, sys_siglist.
+      243: Export sysinfo.
      */
 
      /* Note that we forgot to bump the api for ualarm, strtoll, strtoull */
 
 #define CYGWIN_VERSION_API_MAJOR 0
-#define CYGWIN_VERSION_API_MINOR 242
+#define CYGWIN_VERSION_API_MINOR 243
 
      /* There is also a compatibity version number associated with the
 	shared memory regions.  It is incremented when incompatible
Index: include/sys/sysinfo.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/sys/sysinfo.h,v
retrieving revision 1.1
diff -u -r1.1 sysinfo.h
--- include/sys/sysinfo.h	12 Nov 2009 14:40:48 -0000	1.1
+++ include/sys/sysinfo.h	6 May 2011 04:25:50 -0000
@@ -1,6 +1,6 @@
 /* sys/sysinfo.h
 
-   Copyright 2009 Red Hat, Inc.
+   Copyright 2009, 2011 Red Hat, Inc.
 
 This file is part of Cygwin.
 
@@ -17,6 +17,23 @@
 
 __BEGIN_DECLS
 
+struct sysinfo {
+  long uptime;                /* Seconds since boot */
+  unsigned long loads[3];     /* 1, 5, and 15 minute load averages */
+  unsigned long totalram;     /* Total usable main memory size */
+  unsigned long freeram;      /* Available memory size */
+  unsigned long sharedram;    /* Amount of shared memory */
+  unsigned long bufferram;    /* Memory used by buffers */
+  unsigned long totalswap;    /* Total swap space size */
+  unsigned long freeswap;     /* swap space still available */
+  unsigned short procs;       /* Number of current processes */
+  unsigned long totalhigh;    /* Total high memory size */
+  unsigned long freehigh;     /* Available high memory size */
+  unsigned int mem_unit;      /* Memory unit size in bytes */
+  char __unused[10];          /* Pads structure to 64 bytes */
+};
+
+extern int sysinfo (struct sysinfo *);
 extern int get_nprocs_conf (void);
 extern int get_nprocs (void);
 extern long get_phys_pages (void);

--=-mOvNYXZPMCregZqsZ3P3
Content-Disposition: attachment; filename="doc-sysinfo.patch"
Content-Type: text/x-patch; name="doc-sysinfo.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 610

Index: new-features.sgml
===================================================================
RCS file: /cvs/src/src/winsup/doc/new-features.sgml,v
retrieving revision 1.78
diff -u -r1.78 new-features.sgml
--- new-features.sgml	4 May 2011 22:18:16 -0000	1.78
+++ new-features.sgml	6 May 2011 05:01:49 -0000
@@ -40,7 +40,7 @@
 
 <listitem><para>
 Other new API: ppoll, psiginfo, psignal, sys_siglist, pthread_attr_getstack,
-pthread_attr_getstackaddr, pthread_getattr_np, pthread_setschedprio.
+pthread_attr_getstackaddr, pthread_getattr_np, pthread_setschedprio, sysinfo.
 </para></listitem>
 
 </itemizedlist>

--=-mOvNYXZPMCregZqsZ3P3
Content-Disposition: attachment; filename="sysinfo-test.c"
Content-Type: text/x-csrc; name="sysinfo-test.c"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 1272

#pragma CCOD:script no

#include <dlfcn.h>
#include <stdio.h>
#include <sys/sysinfo.h>

int
main (void)
{
	unsigned long long totalram, freeram, sharedram;
	unsigned long long totalswap, freeswap, totalhigh, freehigh;
	struct sysinfo info;

#ifdef __CYGWIN__
	/* allow linking with existing libcygwin.a */
	int (*sysinfo) (struct sysinfo *);
	void *dll = dlopen ("cygwin1.dll", RTLD_GLOBAL);
	sysinfo = dlsym (dll, "sysinfo");
#endif
	sysinfo (&info);
	totalram = (unsigned long long) info.totalram * info.mem_unit;
	freeram = (unsigned long long) info.freeram * info.mem_unit;
	sharedram = (unsigned long long) info.sharedram * info.mem_unit;
	totalswap = (unsigned long long) info.totalswap * info.mem_unit;
	freeswap = (unsigned long long) info.freeswap * info.mem_unit;
	totalhigh = (unsigned long long) info.totalhigh * info.mem_unit;
	freehigh = (unsigned long long) info.totalhigh * info.mem_unit;

	printf ("Uptime: %ld\n"
		"Number of processes: %u\n"
		"RAM: %llu kB total, %llu kB free, %llu kB shared\n"
		"Swap space: %llu kB total, %llu kB free\n"
		"High memory: %llu kB total, %llu kB free\n",
		info.uptime, info.procs,
		totalram >> 10, freeram >> 10, sharedram >> 10,
		totalswap >> 10, freeswap >> 10,
		totalhigh >> 10, freehigh >> 10);

	return 0;
}

--=-mOvNYXZPMCregZqsZ3P3--
