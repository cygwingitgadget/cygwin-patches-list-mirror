Return-Path: <SRS0=ExB5=IW=dronecode.org.uk=jon.turney@sourceware.org>
Received: from sa-prd-fep-042.btinternet.com (mailomta21-sa.btinternet.com [213.120.69.27])
	by sourceware.org (Postfix) with ESMTPS id D3EEB3858433
	for <cygwin-patches@cygwin.com>; Fri, 12 Jan 2024 14:10:33 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D3EEB3858433
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org D3EEB3858433
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=213.120.69.27
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1705068636; cv=none;
	b=PeqpOQX6uUQUAVsrsiiopzBKLHwrfwwIS+hskeNVfOgeS8uN7yc59uzKC+L+w8RYjdKXIsACBlYs/PCGX4LGNfIy5fMkAQiFSZ0XoopJ3eHaOzndKGJqci+iMrVZ5a6RatZ/3g0MdfpUvxgqYe+OXH6eHPVmqIrVQ8OA4oeLsyI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1705068636; c=relaxed/simple;
	bh=NNctDR97IdzhzQ9zelSSKh1c1OXVRdhPfUzLw1kG6Lc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=UBIkAL+ESRFaGNdaP+yI7qSeNnrdE77TEDWISkZC5f8BRQC8d9DaifVzlwVy1QBHSheVlgVqgU3MdbdEb8C/3RCHmIY86YxvleBqxnmr0swSdKKKIH7+l3ktlPNjXDkqVn/6LhI0/TONBkSZD3SFwHayj1k0a0C0+vYq7saqVgY=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from sa-prd-rgout-005.btmx-prd.synchronoss.net ([10.2.38.8])
          by sa-prd-fep-042.btinternet.com with ESMTP
          id <20240112141032.NJXZ20040.sa-prd-fep-042.btinternet.com@sa-prd-rgout-005.btmx-prd.synchronoss.net>;
          Fri, 12 Jan 2024 14:10:32 +0000
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 6567D00805BEFB6D
X-Originating-IP: [86.139.158.103]
X-OWM-Source-IP: 86.139.158.103
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeihedgiedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepleeitdejhfdtveekheeugeffgeevfedtjeejveefhfeiffefkedtvdetheehieejnecukfhppeekiedrudefledrudehkedruddtfeenucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddufeelrdduheekrddutdefpdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdpnhgspghrtghpthhtohepvddprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmpdhrtghpthhtohepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdprhgvvhfkrfephhhoshhtkeeiqddufeelqdduheekqddutdefrdhrrghnghgvkeeiqddufeelrdgsthgtvghnthhrrghlphhluhhsrdgtohhmpdgruhhthhgpuhhsvghrpehjohhnthhurhhnvgihsegsthhinhhtvghrnhgvthdrtgho
	mhdpghgvohfkrfepifeupdfovfetjfhoshhtpehsrgdqphhrugdqrhhgohhuthdqtddthe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.139.158.103) by sa-prd-rgout-005.btmx-prd.synchronoss.net (authenticated as jonturney@btinternet.com)
        id 6567D00805BEFB6D; Fri, 12 Jan 2024 14:10:32 +0000
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 4/5] Cygwin: Treat api_fatal() similarly to a core-dumping signal
Date: Fri, 12 Jan 2024 14:09:55 +0000
Message-ID: <20240112140958.1694-5-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240112140958.1694-1-jon.turney@dronecode.org.uk>
References: <20240112140958.1694-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Provide the same debugging opportunities for api_fatal() as we do for a
core-dumping signal:

1) Break into any attached debugger
2) Start JIT debugger (if configured) (keeping these under DEBUGGING doesn't seem helpful)
3) Write a coredump (if rlim_core > 1MB)
4) Write a stackdump (if that failed, or 0 < rlim_core <= 1MB)
---
 winsup/cygwin/dcrt0.cc                |  6 +-----
 winsup/cygwin/exceptions.cc           | 18 ++++++++++++++++++
 winsup/cygwin/local_includes/winsup.h |  1 +
 3 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/winsup/cygwin/dcrt0.cc b/winsup/cygwin/dcrt0.cc
index 130d652aa..17c9be731 100644
--- a/winsup/cygwin/dcrt0.cc
+++ b/winsup/cygwin/dcrt0.cc
@@ -1250,11 +1250,7 @@ vapi_fatal (const char *fmt, va_list ap)
   __small_vsprintf (buf + n, fmt, ap);
   va_end (ap);
   strace.prntf (_STRACE_SYSTEM, NULL, "%s", buf);
-
-#ifdef DEBUGGING
-  try_to_debug ();
-#endif
-  cygwin_stackdump ();
+  api_fatal_debug();
   myself.exit (__api_fatal_exit_val);
 }
 
diff --git a/winsup/cygwin/exceptions.cc b/winsup/cygwin/exceptions.cc
index 05ffdc27e..32c64b3d7 100644
--- a/winsup/cygwin/exceptions.cc
+++ b/winsup/cygwin/exceptions.cc
@@ -1396,6 +1396,24 @@ signal_exit (int sig, siginfo_t *si, void *)
 }
 } /* extern "C" */
 
+/* As above, but before exiting due to api_fatal */
+extern "C"
+void
+api_fatal_debug ()
+{
+  if (try_to_debug ())
+    return;
+
+  if (cygheap->rlim_core == 0Ul)
+    return;
+
+  if (cygheap->rlim_core > 1024*1024)
+    if (exec_prepared_command (dumper_command))
+      return;
+
+  cygwin_stackdump();
+}
+
 /* Attempt to carefully handle SIGCONT when we are stopped. */
 void
 _cygtls::handle_SIGCONT ()
diff --git a/winsup/cygwin/local_includes/winsup.h b/winsup/cygwin/local_includes/winsup.h
index 76957618b..38313962d 100644
--- a/winsup/cygwin/local_includes/winsup.h
+++ b/winsup/cygwin/local_includes/winsup.h
@@ -181,6 +181,7 @@ void close_all_files (bool = false);
 extern "C" void error_start_init (const char*);
 extern "C" void dumper_init (void);
 extern "C" int try_to_debug ();
+extern "C" void api_fatal_debug ();
 
 void ld_preload ();
 void fixup_hooks_after_fork ();
-- 
2.43.0

