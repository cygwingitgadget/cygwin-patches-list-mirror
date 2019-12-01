Return-Path: <cygwin-patches-return-9860-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 124887 invoked by alias); 1 Dec 2019 03:58:48 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 124873 invoked by uid 89); 1 Dec 2019 03:58:48 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-16.1 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,SPF_HELO_PASS autolearn=ham version=3.3.1 spammy=H*F:D*gov, sid, HContent-Transfer-Encoding:8bit
X-HELO: nihsmtpxway.hub.nih.gov
Received: from nihsmtpxway.hub.nih.gov (HELO nihsmtpxway.hub.nih.gov) (128.231.90.103) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 01 Dec 2019 03:58:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;  d=nih.gov; i=@nih.gov; q=dns/txt; s=NIH; t=1575172726;  x=1606708726;  h=from:to:cc:subject:date:message-id:mime-version:   content-transfer-encoding;  bh=lT9Y8ElRD7IUV5g9H/NhxH7hd09GDqcDW1hUmwca8Zs=;  b=kaiUY1v8/ZL6hrCv3p6/BVqU7ge34kHjtjMsp9FbzvsVWtwHy9fnH/CF   5h33CXpLRCVV4HOvAxpPVWpUqxci2p9y7LLc6kZIwnD37sF5Zz2qX9Uym   NxImkWe+8Wbyn0J6RTh2AnZA/DmYr2SdgLaMymzHB/uso/b6OXlCfohQ9   VCok9v6ApcBSfZKXDY7wW8wa42SBOmsoleEqx9vNY6QbjT6DcJsaRLTnc   qBdazAiCPa/8bfMsrpfRDvbOPNFxUyf/u2JIjGvmg3eqNgvULKagMWITk   orWSZVhV2AUKTcFmCPvPX7X7ESdO87uwxHmMGh0zp8GtbTgU8RLHK8hpM   A==;
IronPort-SDR: UfoSx2yAH+KdUnyj9QDKjjw1kY8GxtL/gpHg1vrehLgHZLvu5jKis598jqR+ot0i8n7lX+oLnl DMEJQQ4Y3H6+Tlt7HMi7ncckyZsU8ATUs0fohrKFOuOhTZCwGTz3hgvaJbOUay3k6+w16lmJCb RXVBUvyqUVqbA5787qZNFj0TzTIFBQIysQPX3JrRG83E/EY1keR/suF/Yu/XuRReDvB6hj3YqP RUB0XMkrxcvCJkvQU/4fY0KiI3Rf0EVxgDrPAQ2QoYdwL2GKJoIVssMu/V1sXueh2IYQPaQhzU o/I=
Received: from msg-b12-ltm1_v9.hub.nih.gov (HELO mail1.ncbi.nlm.nih.gov) ([128.231.90.73])  by nihsmtpxway.hub.nih.gov with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2019 22:58:44 -0500
Received: from mail1.ncbi.nlm.nih.gov (vhod11.be-md.ncbi.nlm.nih.gov [130.14.26.81])	by mail1.ncbi.nlm.nih.gov (Postfix) with ESMTP id CF9D4340002;	Sat, 30 Nov 2019 22:58:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ncbi.nlm.nih.gov;	s=ncbi-nlm; t=1575172723;	bh=GQSB+X5ragQ9lusxVFlHM0T6s0K4+aT0TSSqQozF9Io=;	h=From:To:Cc:Subject:Date;	b=drO2gqVu6fR7UA0S77cA1Wok5mA6RRNxbwq4To6540lDmUrzpekkg3dypJegFpYyq	 CieZPXRmAXM3bKXhU2UWtgn/Xctsh5ZajrkbNDxt262CaZdQPsoAlJtn8ZGNR0Iy/1	 NEPYftbmELCp25a9HZSCwqmzxBTG507NFz8RWG90=
From: "Anton Lavrentiev via cygwin-patches" <cygwin-patches@cygwin.com>
Reply-To: Anton Lavrentiev <lavr@ncbi.nlm.nih.gov>
To: cygwin-patches@cygwin.com
Cc: Anton Lavrentiev <lavr@ncbi.nlm.nih.gov>
Subject: [PATCH] Cygwin: /proc/[PID]/stat to pull process priority correctly
Date: Sun, 01 Dec 2019 03:58:00 -0000
Message-Id: <20191201035814.1595-1-lavr@ncbi.nlm.nih.gov>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q4/txt/msg00131.txt.bz2

Fix to prior commit 5fa9a0e7 to address https://cygwin.com/ml/cygwin/2019-08/msg00082.html
---
 winsup/cygwin/fhandler_process.cc | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/fhandler_process.cc b/winsup/cygwin/fhandler_process.cc
index 9527fea7d..6fc3476b2 100644
--- a/winsup/cygwin/fhandler_process.cc
+++ b/winsup/cygwin/fhandler_process.cc
@@ -1076,6 +1076,7 @@ format_process_stat (void *data, char *&destbuf)
   unsigned long fault_count = 0UL,
 		vmsize = 0UL, vmrss = 0UL, vmmaxrss = 0UL;
   uint64_t utime = 0ULL, stime = 0ULL, start_time = 0ULL;
+  int nice = 0;
 
   if (p->process_state & PID_EXITED)
     strcpy (cmd, "<defunct>");
@@ -1138,6 +1139,7 @@ format_process_stat (void *data, char *&destbuf)
       if (!NT_SUCCESS (status))
 	debug_printf ("NtQueryInformationProcess(ProcessQuotaLimits): "
 		      "status %y", status);
+      nice = winprio_to_nice (GetPriorityClass (hProcess));
       CloseHandle (hProcess);
     }
   status = NtQuerySystemInformation (SystemTimeOfDayInformation,
@@ -1157,7 +1159,6 @@ format_process_stat (void *data, char *&destbuf)
   vmsize = vmc.PagefileUsage;
   vmrss = vmc.WorkingSetSize / page_size;
   vmmaxrss = ql.MaximumWorkingSetSize / page_size;
-  int nice = winprio_to_nice(GetPriorityClass(hProcess));
 
   destbuf = (char *) crealloc_abort (destbuf, strlen (cmd) + 320);
   return __small_sprintf (destbuf, "%d (%s) %c "
@@ -1169,7 +1170,7 @@ format_process_stat (void *data, char *&destbuf)
 			  p->pid, cmd, state,
 			  p->ppid, p->pgid, p->sid, p->ctty, -1,
 			  0, fault_count, fault_count, 0, 0, utime, stime,
-                         utime, stime, NZERO + nice, nice, 0, 0,
+			  utime, stime, NZERO + nice, nice, 0, 0,
 			  start_time, vmsize,
 			  vmrss, vmmaxrss
 			  );
-- 
2.21.0
