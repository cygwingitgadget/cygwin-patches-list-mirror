Return-Path: <cygwin-patches-return-7422-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1247 invoked by alias); 23 Jun 2011 17:53:05 -0000
Received: (qmail 1235 invoked by uid 22791); 23 Jun 2011 17:53:04 -0000
X-SWARE-Spam-Status: No, hits=-0.6 required=5.0	tests=AWL,BAYES_05,RCVD_IN_DNSWL_NONE,T_RP_MATCHES_RCVD,UNPARSEABLE_RELAY
X-Spam-Check-By: sourceware.org
Received: from mailout08.t-online.de (HELO mailout08.t-online.de) (194.25.134.20)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 23 Jun 2011 17:52:50 +0000
Received: from fwd19.aul.t-online.de (fwd19.aul.t-online.de )	by mailout08.t-online.de with smtp 	id 1QZo5A-0007Y6-57; Thu, 23 Jun 2011 19:52:48 +0200
Received: from [192.168.2.100] (XVRBKTZOghJmkzi7oolJLnvaMKnET9ipqK7ExR-jOTSJuBNgBg-SCpkiTJMuDFCwFY@[79.224.119.35]) by fwd19.t-online.de	with esmtp id 1QZo50-0R9iSW0; Thu, 23 Jun 2011 19:52:38 +0200
Message-ID: <4E037D68.6090907@t-online.de>
Date: Thu, 23 Jun 2011 17:53:00 -0000
From: Christian Franke <Christian.Franke@t-online.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.1.19) Gecko/20110420 SeaMonkey/2.0.14
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [PATCH] Prevent restart of crashing non-Cygwin exe
Content-Type: multipart/mixed; boundary="------------050209080601010702060202"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q2/txt/msg00188.txt.bz2

This is a multi-part message in MIME format.
--------------050209080601010702060202
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 727

If a non-Cygwin .exe started from a Cygwin shell window segfaults, 
Cygwin restarts the .exe 5 times.

Testcase:

$ cat crash.c
#include <stdio.h>

int main()
{
   printf("Hello, "); fflush(stdout);
   *(char *)0 = 42;
   printf("World\n");
   return 0;
}

$ gcc -o crash-c crash.c

$ ./crash-c
Hello, Segmentation fault (core dumped)

$ i686-w64-mingw32-gcc -o crash-w crash.c

$ ./crash-w
Hello, Hello, Hello, Hello, Hello, Hello,

(The repeated outputs are not be visible on 1.7.9-1 when shell runs in a 
Windows console without CYGWIN=tty)

The problem is that Cygwin retries CreateProcess() if process aborts 
with an unknown 0xc0000XXXX exit code also for non-Cygwin programs. The 
attached patch fixes this.

Christian


--------------050209080601010702060202
Content-Type: text/x-diff;
 name="spawn-no-retry.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="spawn-no-retry.patch"
Content-length: 1234

2011-06-23  Christian Franke  <franke@computer.org>

	* sigproc.cc (child_info::sync): Add exit_code to debug
	message.
	(child_info::proc_retry): Don't retry on unknown exit_code
	from non-cygwin programs.

diff --git a/winsup/cygwin/sigproc.cc b/winsup/cygwin/sigproc.cc
index 2f42db2..1e57876 100644
--- a/winsup/cygwin/sigproc.cc
+++ b/winsup/cygwin/sigproc.cc
@@ -883,7 +883,8 @@ child_info::sync (pid_t pid, HANDLE& hProcess, DWORD howlong)
 	      hProcess = NULL;
 	    }
 	}
-      sigproc_printf ("pid %u, WFMO returned %d, res %d", pid, x, res);
+      sigproc_printf ("pid %u, WFMO returned %d, exit_code 0x%x, res %d",
+		      pid, x, exit_code, res);
     }
   return res;
 }
@@ -915,11 +916,11 @@ child_info::proc_retry (HANDLE h)
     case EXITCODE_FORK_FAILED: /* windows prevented us from forking */
       break;
 
-    /* Count down non-recognized exit codes more quickly since they aren't
-       due to known conditions.  */
     default:
-      if (!iscygwin () && (exit_code & 0xffff0000) != 0xc0000000)
+      if (!iscygwin ())
 	break;
+      /* Count down non-recognized exit codes more quickly since they aren't
+         due to known conditions.  */
       if ((retry -= 2) < 0)
 	retry = 0;
       else

--------------050209080601010702060202--
