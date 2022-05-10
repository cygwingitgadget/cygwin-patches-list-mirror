Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from omta002.cacentral1.a.cloudfilter.net
 (omta002.cacentral1.a.cloudfilter.net [3.97.99.33])
 by sourceware.org (Postfix) with ESMTPS id DBB523954455
 for <cygwin-patches@cygwin.com>; Tue, 10 May 2022 14:44:48 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org DBB523954455
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=systematicsw.ab.ca
Received: from shw-obgw-4003a.ext.cloudfilter.net ([10.228.9.183])
 by cmsmtp with ESMTP
 id oMVjnFpNBWi4QoR6Tn0nOx; Tue, 10 May 2022 14:44:45 +0000
Received: from BWINGLISD.cg.shawcable.net. ([184.64.124.72])
 by cmsmtp with ESMTP
 id oR6VnVxitCg6joR6VngMYV; Tue, 10 May 2022 14:44:48 +0000
X-Authority-Analysis: v=2.4 cv=SMhR6cjH c=1 sm=1 tr=0 ts=627a7a60
 a=oHm12aVswOWz6TMtn9zYKg==:117 a=oHm12aVswOWz6TMtn9zYKg==:17
 a=r77TgQKjGQsHNAKrUKIA:9 a=mhVjSWa7ORy0E7oRo4QA:9 a=QEXdDO2ut3YA:10
 a=DRThqkZ18VTMjfal9yEA:9 a=B2y7HmGcmWMA:10
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: Cygwin Patches <cygwin-patches@cygwin.com>
Subject: [PATCH 1/1] fhandler_process.cc(format_process_stat): fix
 /proc/pid/stat issues
Date: Tue, 10 May 2022 08:44:42 -0600
Message-Id: <20220510144443.5555-2-Brian.Inglis@SystematicSW.ab.ca>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220510144443.5555-1-Brian.Inglis@SystematicSW.ab.ca>
References: <20220510144443.5555-1-Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------2.36.0"
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfOitN4c/fsu+siOwI8I+p6zlQFLPrPEy/p1Xww41LXMGpCW0uNC84oN6uAeV0T8HOSghrtyRBMAk4yHfhM6B0/v564GzEGubCLMydF8/f5ilSwRusxrs
 WVx2IeqMY1WIvKoFrOfYqGMLhJIe+Va4QlnE27BWLHW3l4jP+zGPRu/xNfpG1tLBnfOSJFENV34TdYhU+IuwX18DYY03kWdR/dphdBS8A+yCsn8e7keN6JJL
 I0p/65jzDdo++HSr3vflQU0RCK4u68DWvgMFAX48EUY=
X-Spam-Status: No, score=-1170.0 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, SPF_HELO_NONE, SPF_NONE, TXREP,
 T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Tue, 10 May 2022 14:44:50 -0000

This is a multi-part message in MIME format.
--------------2.36.0
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


fix tty_nr maj/min bits, vmmaxrss units, and x86 format mismatch:
ctty maj is 31:16, min is 15:0; tty_nr s/b maj 15:8, min 31:20, 7:0;
vmmaxrss s/b bytes not pages;
times all 64 bit - change formats of first two instances from %lu to %U;
realign sprintf formats and variables/values in more logical groups
---
 winsup/cygwin/fhandler_process.cc | 33 +++++++++++++++++++------------
 1 file changed, 20 insertions(+), 13 deletions(-)


--------------2.36.0
Content-Type: text/x-patch; name="0001-fhandler_process.cc-format_process_stat-fix-proc-pid-stat-issues.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="0001-fhandler_process.cc-format_process_stat-fix-proc-pid-stat-issues.patch"

diff --git a/winsup/cygwin/fhandler_process.cc b/winsup/cygwin/fhandler_process.cc
index 4c42bc01568d..718945b9a3ff 100644
--- a/winsup/cygwin/fhandler_process.cc
+++ b/winsup/cygwin/fhandler_process.cc
@@ -1092,6 +1092,11 @@ format_process_stat (void *data, char *&destbuf)
 		vmsize = 0UL, vmrss = 0UL, vmmaxrss = 0UL;
   uint64_t utime = 0ULL, stime = 0ULL, start_time = 0ULL;
   int nice = 0;
+/* ctty maj is 31:16, min is 15:0; tty_nr s/b maj 15:8, min 31:20, 7:0;
+   maj is 31:16 >> 16 & fff << 8; min is 15:0 >> 8 & ff << 20 | & ff */
+  int tty_nr =    (((p->ctty >>  8) & 0xff)  << 20)
+		| (((p->ctty >> 16) & 0xfff) <<  8)
+		|   (p->ctty        & 0xff);
 
   if (p->process_state & PID_EXITED)
     strcpy (cmd, "<defunct>");
@@ -1171,23 +1176,25 @@ format_process_stat (void *data, char *&destbuf)
   else
     start_time = (p->start_time - to_time_t (&stodi.BootTime)) * CLOCKS_PER_SEC;
   unsigned page_size = wincap.page_size ();
-  vmsize = vmc.PagefileUsage;
-  vmrss = vmc.WorkingSetSize / page_size;
-  vmmaxrss = ql.MaximumWorkingSetSize / page_size;
+  vmsize = vmc.PagefileUsage;			/* bytes */
+  vmrss = vmc.WorkingSetSize / page_size;	/* pages */
+  vmmaxrss = ql.MaximumWorkingSetSize;		/* bytes */
 
   destbuf = (char *) crealloc_abort (destbuf, strlen (cmd) + 320);
   return __small_sprintf (destbuf, "%d (%s) %c "
-				   "%d %d %d %d %d "
-				   "%u %lu %lu %u %u %lu %lu "
-				   "%U %U %d %d %d %d "
-				   "%U %lu "
-				   "%ld %lu\n",
+				   "%d %d %d %d "
+				   "%d %u %lu %lu %u %u "
+				   "%U %U %U %U "
+				   "%d %d %d %d "
+				   "%U "
+				   "%lu %ld %lu\n",
 			  p->pid, cmd, state,
-			  p->ppid, p->pgid, p->sid, p->ctty, -1,
-			  0, fault_count, fault_count, 0, 0, utime, stime,
-			  utime, stime, NZERO + nice, nice, 0, 0,
-			  start_time, vmsize,
-			  vmrss, vmmaxrss
+			  p->ppid, p->pgid, p->sid, tty_nr,
+			  -1, 0, fault_count, fault_count, 0, 0,
+			  utime, stime, utime, stime,
+			  NZERO + nice, nice, 0, 0,
+			  start_time,
+			  vmsize, vmrss, vmmaxrss
 			  );
 }
 

--------------2.36.0--


