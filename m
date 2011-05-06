Return-Path: <cygwin-patches-return-7320-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2964 invoked by alias); 6 May 2011 19:04:18 -0000
Received: (qmail 2952 invoked by uid 22791); 6 May 2011 19:04:16 -0000
X-SWARE-Spam-Status: No, hits=-2.4 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RFC_ABUSE_POST,TW_FP,TW_UF
X-Spam-Check-By: sourceware.org
Received: from mail-gx0-f171.google.com (HELO mail-gx0-f171.google.com) (209.85.161.171)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 06 May 2011 19:03:59 +0000
Received: by gxk22 with SMTP id 22so1725824gxk.2        for <cygwin-patches@cygwin.com>; Fri, 06 May 2011 12:03:58 -0700 (PDT)
Received: by 10.236.157.103 with SMTP id n67mr3144673yhk.463.1304708638358;        Fri, 06 May 2011 12:03:58 -0700 (PDT)
Received: from [127.0.0.1] (S0106000cf16f58b1.wp.shawcable.net [174.5.115.130])        by mx.google.com with ESMTPS id u29sm1603641yhn.69.2011.05.06.12.03.56        (version=SSLv3 cipher=OTHER);        Fri, 06 May 2011 12:03:57 -0700 (PDT)
Subject: [PATCH] Fix /proc/meminfo and /proc/swaps for >4GB
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
To: cygwin-patches <cygwin-patches@cygwin.com>
Content-Type: multipart/mixed; boundary="=-UI4/1+ZGG36oiPS+6Sys"
Date: Fri, 06 May 2011 19:04:00 -0000
Message-ID: <1304708638.5504.5.camel@YAAKOV04>
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
X-SW-Source: 2011-q2/txt/msg00086.txt.bz2


--=-UI4/1+ZGG36oiPS+6Sys
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 862

As promised, this patch ports the /proc/meminfo code to use sysinfo(2),
and fixes the case where RAM or swap space totals more than 4GB.  It
also fixes the /proc/swaps code for paging files larger than 4GB.

For example:

$ cat /proc/meminfo
            total:         used:         free:
Mem:     4293058560    1828151296    2464907264
Swap:   12884901888      14680064   12870221824
MemTotal:        4192440 kB
MemFree:         2407136 kB
MemShared:             0 kB
HighTotal:             0 kB
HighFree:              0 kB
LowTotal:        4192440 kB
LowFree:         2407136 kB
SwapTotal:      12582912 kB
SwapFree:       12568576 kB

$ cat /proc/swaps
Filename				Type		Size	Used	Priority
/cygdrive/c/pagefile.sys                file            8388608 8192
0
/cygdrive/d/pagefile.sys                file            4194304 6144
0

Patch attached.


Yaakov


--=-UI4/1+ZGG36oiPS+6Sys
Content-Disposition: attachment; filename="proc-largemem.patch"
Content-Type: text/x-patch; name="proc-largemem.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 4680

2011-05-06  Yaakov Selkowitz  <yselkowitz@...>

	* fhandler_proc.cc (format_proc_meminfo): Rewrite to use sysinfo().
	Support RAM and swap space larger than 4GB.
	(format_proc_swaps): Support paging files larger than 4GB.

Index: fhandler_proc.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_proc.cc,v
retrieving revision 1.102
diff -u -r1.102 fhandler_proc.cc
--- fhandler_proc.cc	19 Apr 2011 08:39:38 -0000	1.102
+++ fhandler_proc.cc	6 May 2011 04:24:33 -0000
@@ -24,6 +24,7 @@
 #include "tls_pbuf.h"
 #include <sys/utsname.h>
 #include <sys/param.h>
+#include <sys/sysinfo.h>
 #include "ntdll.h"
 #include <winioctl.h>
 #include <wchar.h>
@@ -402,63 +403,28 @@
 static _off64_t
 format_proc_meminfo (void *, char *&destbuf)
 {
-  unsigned long mem_total = 0UL, mem_free = 0UL, swap_total = 0UL,
-		swap_free = 0UL;
-  MEMORYSTATUS memory_status;
-  GlobalMemoryStatus (&memory_status);
-  mem_total = memory_status.dwTotalPhys;
-  mem_free = memory_status.dwAvailPhys;
-  PSYSTEM_PAGEFILE_INFORMATION spi = NULL;
-  ULONG size = 512;
-  NTSTATUS ret = STATUS_SUCCESS;
+  unsigned long long mem_total, mem_free, swap_total, swap_free;
+  struct sysinfo info;
+
+  sysinfo (&info);
+  mem_total = (unsigned long long) info.totalram * info.mem_unit;
+  mem_free = (unsigned long long) info.freeram * info.mem_unit;
+  swap_total = (unsigned long long) info.totalswap * info.mem_unit;
+  swap_free = (unsigned long long) info.freeswap * info.mem_unit;
 
-  spi = (PSYSTEM_PAGEFILE_INFORMATION) malloc (size);
-  if (spi)
-    {
-      ret = NtQuerySystemInformation (SystemPagefileInformation, (PVOID) spi,
-				      size, &size);
-      if (ret == STATUS_INFO_LENGTH_MISMATCH)
-	{
-	  free (spi);
-	  spi = (PSYSTEM_PAGEFILE_INFORMATION) malloc (size);
-	  if (spi)
-	    ret = NtQuerySystemInformation (SystemPagefileInformation,
-					    (PVOID) spi, size, &size);
-	}
-    }
-  if (!spi || ret || (!ret && GetLastError () == ERROR_PROC_NOT_FOUND))
-    {
-      swap_total = memory_status.dwTotalPageFile - mem_total;
-      swap_free = memory_status.dwAvailPageFile - mem_total;
-    }
-  else
-    {
-      PSYSTEM_PAGEFILE_INFORMATION spp = spi;
-      do
-	{
-	  swap_total += spp->CurrentSize * getsystempagesize ();
-	  swap_free += (spp->CurrentSize - spp->TotalUsed)
-		       * getsystempagesize ();
-	}
-      while (spp->NextEntryOffset
-	     && (spp = (PSYSTEM_PAGEFILE_INFORMATION)
-			   ((char *) spp + spp->NextEntryOffset)));
-    }
-  if (spi)
-    free (spi);
   destbuf = (char *) crealloc_abort (destbuf, 512);
-  return __small_sprintf (destbuf, "         total:      used:      free:\n"
-				   "Mem:  %10lu %10lu %10lu\n"
-				   "Swap: %10lu %10lu %10lu\n"
-				   "MemTotal:     %10lu kB\n"
-				   "MemFree:      %10lu kB\n"
+  return sprintf (destbuf, "            total:         used:         free:\n"
+				   "Mem:  %13llu %13llu %13llu\n"
+				   "Swap: %13llu %13llu %13llu\n"
+				   "MemTotal:     %10llu kB\n"
+				   "MemFree:      %10llu kB\n"
 				   "MemShared:             0 kB\n"
 				   "HighTotal:             0 kB\n"
 				   "HighFree:              0 kB\n"
-				   "LowTotal:     %10lu kB\n"
-				   "LowFree:      %10lu kB\n"
-				   "SwapTotal:    %10lu kB\n"
-				   "SwapFree:     %10lu kB\n",
+				   "LowTotal:     %10llu kB\n"
+				   "LowFree:      %10llu kB\n"
+				   "SwapTotal:    %10llu kB\n"
+				   "SwapFree:     %10llu kB\n",
 				   mem_total, mem_total - mem_free, mem_free,
 				   swap_total, swap_total - swap_free, swap_free,
 				   mem_total >> 10, mem_free >> 10,
@@ -1298,7 +1264,7 @@
 static _off64_t
 format_proc_swaps (void *, char *&destbuf)
 {
-  unsigned long total = 0UL, used = 0UL;
+  unsigned long long total = 0ULL, used = 0ULL;
   char *filename = NULL;
   ssize_t filename_len;
   PSYSTEM_PAGEFILE_INFORMATION spi = NULL;
@@ -1332,14 +1298,14 @@
       PSYSTEM_PAGEFILE_INFORMATION spp = spi;
       do
 	{
-	  total = spp->CurrentSize * getsystempagesize ();
-	  used = spp->TotalUsed * getsystempagesize ();
+	  total = (unsigned long long) spp->CurrentSize * getsystempagesize ();
+	  used = (unsigned long long) spp->TotalUsed * getsystempagesize ();
 
 	  filename_len = cygwin_conv_path (CCP_WIN_W_TO_POSIX, spp->FileName.Buffer, filename, 0);
 	  filename = (char *) malloc (filename_len);
 	  cygwin_conv_path (CCP_WIN_W_TO_POSIX, spp->FileName.Buffer, filename, filename_len);
 
-	  bufptr += sprintf (bufptr, "%-40s%-16s%-8ld%-8ld%-8d\n",
+	  bufptr += sprintf (bufptr, "%-40s%-16s%-8llu%-8llu%-8d\n",
 	                     filename, "file", total >> 10, used >> 10, 0);
 	}
       while (spp->NextEntryOffset

--=-UI4/1+ZGG36oiPS+6Sys--
