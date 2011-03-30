Return-Path: <cygwin-patches-return-7222-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3393 invoked by alias); 30 Mar 2011 00:32:25 -0000
Received: (qmail 3383 invoked by uid 22791); 30 Mar 2011 00:32:25 -0000
X-SWARE-Spam-Status: No, hits=-2.5 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW
X-Spam-Check-By: sourceware.org
Received: from mail-gw0-f43.google.com (HELO mail-gw0-f43.google.com) (74.125.83.43)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 30 Mar 2011 00:32:19 +0000
Received: by gwj21 with SMTP id 21so395789gwj.2        for <cygwin-patches@cygwin.com>; Tue, 29 Mar 2011 17:32:18 -0700 (PDT)
Received: by 10.236.143.66 with SMTP id k42mr825677yhj.125.1301445136697;        Tue, 29 Mar 2011 17:32:16 -0700 (PDT)
Received: from [127.0.0.1] (S0106000cf16f58b1.wp.shawcable.net [174.5.115.130])        by mx.google.com with ESMTPS id 51sm2749012yha.58.2011.03.29.17.32.13        (version=SSLv3 cipher=OTHER);        Tue, 29 Mar 2011 17:32:15 -0700 (PDT)
Subject: [PATCH] /proc/loadavg: add running/total processes
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
To: cygwin-patches <cygwin-patches@cygwin.com>
Content-Type: multipart/mixed; boundary="=-yDAC4JoTBipu3DWdjZhE"
Date: Wed, 30 Mar 2011 00:32:00 -0000
Message-ID: <1301445133.756.11.camel@YAAKOV04>
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
X-SW-Source: 2011-q1/txt/msg00077.txt.bz2


--=-yDAC4JoTBipu3DWdjZhE
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 382

This patch adds the fourth component of Linux's /proc/loadavg[1], the
current running/total processes count.  My only question is if states
other than 'O' and 'R' should be considered "running" for this purpose.

Patches for winsup/cygwin and winsup/doc attached.


Yaakov

[1] http://docs.redhat.com/docs/en-US/Red_Hat_Enterprise_Linux/4/html/Reference_Guide/s2-proc-loadavg.html


--=-yDAC4JoTBipu3DWdjZhE
Content-Disposition: attachment; filename="proc-loadavg-running.patch"
Content-Type: text/x-patch; name="proc-loadavg-running.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 1994

2011-03-29  Yaakov Selkowitz  <yselkowitz@users.sourceforge.net>

	* fhandler_proc.cc (format_proc_loadavg): Add running/total
	processes as fourth component of output.
	* fhandler_process.cc (get_process_state): Make non-static.

Index: fhandler_proc.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_proc.cc,v
retrieving revision 1.95
diff -u -r1.95 fhandler_proc.cc
--- fhandler_proc.cc	17 Jan 2011 14:31:30 -0000	1.95
+++ fhandler_proc.cc	23 Feb 2011 05:44:03 -0000
@@ -379,9 +379,21 @@
 static _off64_t
 format_proc_loadavg (void *, char *&destbuf)
 {
+  extern int get_process_state (DWORD dwProcessId);
+  unsigned running = 0;
+  winpids pids ((DWORD) 0);
+
+  for (unsigned i = 0; i < pids.npids; i++)
+    switch (get_process_state (i)) {
+      case 'O':
+      case 'R':
+        running++;
+        break;
+    }
+
   destbuf = (char *) crealloc_abort (destbuf, 16);
-  return __small_sprintf (destbuf, "%u.%02u %u.%02u %u.%02u\n",
-				    0, 0, 0, 0, 0, 0);
+  return __small_sprintf (destbuf, "%u.%02u %u.%02u %u.%02u %u/%u\n",
+				    0, 0, 0, 0, 0, 0, running, pids.npids);
 }
 
 static _off64_t
Index: fhandler_process.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_process.cc,v
retrieving revision 1.93
diff -u -r1.93 fhandler_process.cc
--- fhandler_process.cc	13 Sep 2010 13:02:19 -0000	1.93
+++ fhandler_process.cc	23 Feb 2011 05:44:03 -0000
@@ -79,8 +79,7 @@
 
 static const int PROCESS_LINK_COUNT =
   (sizeof (process_tab) / sizeof (virt_tab_t)) - 1;
-
-static int get_process_state (DWORD dwProcessId);
+int get_process_state (DWORD dwProcessId);
 static bool get_mem_values (DWORD dwProcessId, unsigned long *vmsize,
 			    unsigned long *vmrss, unsigned long *vmtext,
 			    unsigned long *vmdata, unsigned long *vmlib,
@@ -928,7 +927,7 @@
   return len;
 }
 
-static int
+int
 get_process_state (DWORD dwProcessId)
 {
   /*

--=-yDAC4JoTBipu3DWdjZhE
Content-Disposition: attachment; filename="doc-proc-loadavg.patch"
Content-Type: text/x-patch; name="doc-proc-loadavg.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 750

2011-03-29  Yaakov Selkowitz  <yselkowitz@users.sourceforge.net>

	* new-features.sgml (ov-new1.7.10): /proc/loadavg now shows
	current running/total processes count.

Index: new-features.sgml
===================================================================
RCS file: /cvs/src/src/winsup/doc/new-features.sgml,v
retrieving revision 1.69
diff -u -r1.69 new-features.sgml
--- new-features.sgml	29 Mar 2011 10:35:08 -0000	1.69
+++ new-features.sgml	30 Mar 2011 00:12:53 -0000
@@ -9,6 +9,11 @@
 pthread_spin_lock, pthread_spin_trylock, pthread_spin_unlock.
 </para></listitem>
 
+<listitem><para>
+/proc/loadavg now shows the number of currently running processes and the
+total number of processes.
+</para></listitem>
+
 </itemizedlist>
 
 </sect2>

--=-yDAC4JoTBipu3DWdjZhE--
