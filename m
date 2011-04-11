Return-Path: <cygwin-patches-return-7277-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29283 invoked by alias); 11 Apr 2011 02:00:09 -0000
Received: (qmail 28885 invoked by uid 22791); 11 Apr 2011 02:00:05 -0000
X-SWARE-Spam-Status: No, hits=-2.4 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,TW_CP,TW_FP,TW_UF
X-Spam-Check-By: sourceware.org
Received: from mail-gy0-f171.google.com (HELO mail-gy0-f171.google.com) (209.85.160.171)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 11 Apr 2011 02:00:00 +0000
Received: by gye5 with SMTP id 5so2481526gye.2        for <cygwin-patches@cygwin.com>; Sun, 10 Apr 2011 18:59:59 -0700 (PDT)
Received: by 10.150.47.6 with SMTP id u6mr4519980ybu.31.1302487199599;        Sun, 10 Apr 2011 18:59:59 -0700 (PDT)
Received: from [127.0.0.1] (S0106000cf16f58b1.wp.shawcable.net [174.5.115.130])        by mx.google.com with ESMTPS id t12sm2444469ybe.0.2011.04.10.18.59.57        (version=SSLv3 cipher=OTHER);        Sun, 10 Apr 2011 18:59:58 -0700 (PDT)
Subject: [PATCH] implement /proc/swaps
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
To: cygwin-patches <cygwin-patches@cygwin.com>
Content-Type: multipart/mixed; boundary="=-UE6gM+xKtlS/eAd1vJ8X"
Date: Mon, 11 Apr 2011 02:00:00 -0000
Message-ID: <1302487196.4944.9.camel@YAAKOV04>
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
X-SW-Source: 2011-q2/txt/msg00043.txt.bz2


--=-UE6gM+xKtlS/eAd1vJ8X
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 837

This patch implements /proc/swaps, as found on Linux[1]:

$ cat /proc/swaps
Filename				Type		Size	Used	Priority
/cygdrive/c/pagefile.sys                file            4192440 16376   0
/cygdrive/d/pagefile.sys                file            4192440 14208   0

(The first line is tab-delineated, the following lines use spaces.)

If there is no paging file on the system (a legal but discouraged
configuration), then only the header line is displayed.

According to Microsoft[2], there's no simple way to set or determine
which paging file will be used at any given time.  Therefore I list all
paging files with priority 0.

Patches for winsup/cygwin and winsup/doc attached.


Yaakov

[1] http://docs.redhat.com/docs/en-US/Red_Hat_Enterprise_Linux/6/html/Deployment_Guide/s2-proc-swaps.html
[2] http://support.microsoft.com/kb/314482


--=-UE6gM+xKtlS/eAd1vJ8X
Content-Disposition: attachment; filename="doc-proc-swaps.patch"
Content-Type: text/x-patch; name="doc-proc-swaps.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 774

2011-04-10  Yaakov Selkowitz  <yselkowitz@users.sourceforge.net>

	* new-features.sgml (ov-new1.7.10): Document /proc/swaps.

Index: new-features.sgml
===================================================================
RCS file: /cvs/src/src/winsup/doc/new-features.sgml,v
retrieving revision 1.73
diff -u -r1.73 new-features.sgml
--- new-features.sgml	4 Apr 2011 12:25:37 -0000	1.73
+++ new-features.sgml	11 Apr 2011 01:16:27 -0000
@@ -19,6 +19,10 @@
 </para></listitem>
 
 <listitem><para>
+Added /proc/swaps, which shows the location and size of Windows paging file(s).
+</para></listitem>
+
+<listitem><para>
 Added /proc/sysvipc/msg, /proc/sysvipc/sem, and /proc/sysvipc/shm which
 provide information about System V IPC message queues, semaphores, and
 shared memory.

--=-UE6gM+xKtlS/eAd1vJ8X
Content-Disposition: attachment; filename="proc-swaps.patch"
Content-Type: text/x-patch; name="proc-swaps.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 3255

2011-04-10  Yaakov Selkowitz  <yselkowitz@users.sourceforge.net>

	* fhandler_proc.cc (proc_tab): Add /proc/swaps virtual file.
	(format_proc_swaps): New function.

Index: fhandler_proc.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_proc.cc,v
retrieving revision 1.100
diff -u -r1.100 fhandler_proc.cc
--- fhandler_proc.cc	4 Apr 2011 12:23:35 -0000	1.100
+++ fhandler_proc.cc	11 Apr 2011 01:11:57 -0000
@@ -12,6 +12,7 @@
 #include "miscfuncs.h"
 #include <unistd.h>
 #include <stdlib.h>
+#include <stdio.h>
 #include "cygerrno.h"
 #include "security.h"
 #include "path.h"
@@ -43,6 +44,7 @@
 static _off64_t format_proc_self (void *, char *&);
 static _off64_t format_proc_mounts (void *, char *&);
 static _off64_t format_proc_filesystems (void *, char *&);
+static _off64_t format_proc_swaps (void *, char *&);
 
 /* names of objects in /proc */
 static const virt_tab_t proc_tab[] = {
@@ -60,6 +62,7 @@
   { _VN ("registry64"),  FH_REGISTRY,	virt_directory,	NULL },
   { _VN ("self"),	 FH_PROC,	virt_symlink,	format_proc_self },
   { _VN ("stat"),	 FH_PROC,	virt_file,	format_proc_stat },
+  { _VN ("swaps"),	 FH_PROC,	virt_file,	format_proc_swaps },
   { _VN ("sys"),	 FH_PROCSYS,	virt_directory,	NULL },
   { _VN ("sysvipc"),	 FH_PROCSYSVIPC,	virt_directory,	NULL },
   { _VN ("uptime"),	 FH_PROC,	virt_file,	format_proc_uptime },
@@ -1301,4 +1304,64 @@
   return bufptr - buf;
 }
 
+static _off64_t
+format_proc_swaps (void *, char *&destbuf)
+{
+  unsigned long total = 0UL, used = 0UL;
+  char *filename = NULL;
+  ssize_t filename_len;
+  PSYSTEM_PAGEFILE_INFORMATION spi = NULL;
+  ULONG size = 512;
+  NTSTATUS ret = STATUS_SUCCESS;
+
+  tmp_pathbuf tp;
+  char *buf = tp.c_get ();
+  char *bufptr = buf;
+
+  spi = (PSYSTEM_PAGEFILE_INFORMATION) malloc (size);
+  if (spi)
+    {
+      ret = NtQuerySystemInformation (SystemPagefileInformation, (PVOID) spi,
+				      size, &size);
+      if (ret == STATUS_INFO_LENGTH_MISMATCH)
+	{
+	  free (spi);
+	  spi = (PSYSTEM_PAGEFILE_INFORMATION) malloc (size);
+	  if (spi)
+	    ret = NtQuerySystemInformation (SystemPagefileInformation,
+					    (PVOID) spi, size, &size);
+	}
+    }
+
+  bufptr += __small_sprintf (bufptr,
+                             "Filename\t\t\t\tType\t\tSize\tUsed\tPriority\n");
+
+  if (spi && !ret && GetLastError () != ERROR_PROC_NOT_FOUND)
+    {
+      PSYSTEM_PAGEFILE_INFORMATION spp = spi;
+      do
+	{
+	  total = spp->CurrentSize * getsystempagesize ();
+	  used = spp->TotalUsed * getsystempagesize ();
+
+	  filename_len = cygwin_conv_path (CCP_WIN_W_TO_POSIX, spp->FileName.Buffer, filename, 0);
+	  filename = (char *) malloc (filename_len);
+	  cygwin_conv_path (CCP_WIN_W_TO_POSIX, spp->FileName.Buffer, filename, filename_len);
+
+	  bufptr += sprintf (bufptr, "%-40s%-16s%-8ld%-8ld%-8d\n",
+	                     filename, "file", total >> 10, used >> 10, 0);
+	}
+      while (spp->NextEntryOffset
+	     && (spp = (PSYSTEM_PAGEFILE_INFORMATION)
+			   ((char *) spp + spp->NextEntryOffset)));
+    }
+
+  if (spi)
+    free (spi);
+
+  destbuf = (char *) crealloc_abort (destbuf, bufptr - buf);
+  memcpy (destbuf, buf, bufptr - buf);
+  return bufptr - buf;
+}
+
 #undef print

--=-UE6gM+xKtlS/eAd1vJ8X--
