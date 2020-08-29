Return-Path: <jon.turney@dronecode.org.uk>
Received: from re-prd-fep-041.btinternet.com (mailomta25-re.btinternet.com
 [213.120.69.118])
 by sourceware.org (Postfix) with ESMTPS id 587AB385043D
 for <cygwin-patches@cygwin.com>; Sat, 29 Aug 2020 14:43:48 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 587AB385043D
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from re-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.54.5])
 by re-prd-fep-041.btinternet.com with ESMTP id
 <20200829144347.MZIE30588.re-prd-fep-041.btinternet.com@re-prd-rgout-002.btmx-prd.synchronoss.net>;
 Sat, 29 Aug 2020 15:43:47 +0100
Authentication-Results: btinternet.com;
 auth=pass (LOGIN) smtp.auth=jonturney@btinternet.com
X-Originating-IP: [31.51.206.212]
X-OWM-Source-IP: 31.51.206.212 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedrudefuddgkedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeeuieejgeduvdeutdffieeileefffdufeekhefgjefffeehtdekjeegkeeftdfffeenucfkphepfedurdehuddrvddtiedrvdduvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepfedurdehuddrvddtiedrvdduvddpmhgrihhlfhhrohhmpeeojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqpdhrtghpthhtohepoegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmqedprhgtphhtthhopeeojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (31.51.206.212) by
 re-prd-rgout-002.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5ED9C0CC0E5029BF; Sat, 29 Aug 2020 15:43:47 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH] Cygwin: Remove waitloop argument from try_to_debug()
Date: Sat, 29 Aug 2020 15:43:32 +0100
Message-Id: <20200829144332.9065-1-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 GIT_PATCH_0, KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, RCVD_IN_DNSWL_LOW,
 RCVD_IN_MSPIKE_H3, RCVD_IN_MSPIKE_WL, SPF_HELO_PASS, SPF_NONE,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
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
X-List-Received-Date: Sat, 29 Aug 2020 14:43:50 -0000

Currently, when using CYGWIN='error_start=dumper', the core dump written
in response to an exception is non-deterministic, as the faulting
process isn't stopped while the dumper is started (it even seems
possible in theory that the faulting process could have exited before
the dumper process attaches).

Remove the waitloop argument, only used in this case, so the faulting
process busy-waits until the dump starts.

Code archeology to determine why the code is this way didn't really turn
up any answers, but this seems a low-risk change, as this only changes
the behaviour when:

 - a debugger isn't already attached
 - an error_start is specified in CYGWIN env var
 - an exception has occured which will be translated to a signal

Future work: This probably can be further simplified to make it
completely synchronous by waiting for the dumper process to exit. This
would avoid the race condition of the dumper attaching and detaching
before we get around to checking for that (which we try to work around
by juggling thread priorities), and the failure state where the dumper
doesn't attach and we spin indefinitely.
---
 winsup/cygwin/exceptions.cc | 8 ++------
 winsup/cygwin/winsup.h      | 2 +-
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/winsup/cygwin/exceptions.cc b/winsup/cygwin/exceptions.cc
index bb7704f94..3ed2db1eb 100644
--- a/winsup/cygwin/exceptions.cc
+++ b/winsup/cygwin/exceptions.cc
@@ -461,10 +461,8 @@ cygwin_stackdump ()
   exc.dumpstack ();
 }
 
-#define TIME_TO_WAIT_FOR_DEBUGGER 10000
-
 extern "C" int
-try_to_debug (bool waitloop)
+try_to_debug ()
 {
   if (!debugger_command)
     return 0;
@@ -537,8 +535,6 @@ try_to_debug (bool waitloop)
     system_printf ("Failed to start debugger, %E");
   else
     {
-      if (!waitloop)
-	return dbg;
       SetThreadPriority (GetCurrentThread (), THREAD_PRIORITY_IDLE);
       while (!being_debugged ())
 	Sleep (1);
@@ -812,7 +808,7 @@ exception::handle (EXCEPTION_RECORD *e, exception_list *frame, CONTEXT *in,
   if (exit_state >= ES_SIGNAL_EXIT
       && (NTSTATUS) e->ExceptionCode != STATUS_CONTROL_C_EXIT)
     api_fatal ("Exception during process exit");
-  else if (!try_to_debug (0))
+  else if (!try_to_debug ())
     rtl_unwind (frame, e);
   else
     {
diff --git a/winsup/cygwin/winsup.h b/winsup/cygwin/winsup.h
index 79844cb87..0ffd8c5af 100644
--- a/winsup/cygwin/winsup.h
+++ b/winsup/cygwin/winsup.h
@@ -190,7 +190,7 @@ void close_all_files (bool = false);
 
 /* debug_on_trap support. see exceptions.cc:try_to_debug() */
 extern "C" void error_start_init (const char*);
-extern "C" int try_to_debug (bool waitloop = 1);
+extern "C" int try_to_debug ();
 
 void ld_preload ();
 void fixup_hooks_after_fork ();
-- 
2.28.0

