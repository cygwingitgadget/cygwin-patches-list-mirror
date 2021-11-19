Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-11.nifty.com (conuserg-11.nifty.com [210.131.2.78])
 by sourceware.org (Postfix) with ESMTPS id E8EF23857C50
 for <cygwin-patches@cygwin.com>; Fri, 19 Nov 2021 18:39:28 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org E8EF23857C50
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (z221123.dynamic.ppp.asahi-net.or.jp
 [110.4.221.123]) (authenticated)
 by conuserg-11.nifty.com with ESMTP id 1AJId9cp019511;
 Sat, 20 Nov 2021 03:39:14 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 1AJId9cp019511
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1637347154;
 bh=57erYlq/U1dHBJmYotJns+Ypprv8mEmRUHgzaFgns38=;
 h=From:To:Cc:Subject:Date:From;
 b=iyl5RDECUyrIedv9SSfZC10AwlNzqlw5aE8ucPK/udePzpVQZFjOZt6D9GVnyZ7+6
 uUfhTYpK3WRTfIjtULrwliSORKLohWCKsZ4SZXAt3trp1ElZYQ1T4etM3sw5XnYRgd
 2Q3oDNh6wGBAcD0fVhj/URNwuEnqr2PHd8dv3YVI685RY7PMc8o6aqWkrenbqr86i9
 kOOxMY2M++wTexgVsZkW6+uAJcmHtpL8mrEhqXRyh5KpaD3zOEgBpczCt+l/DWlMjy
 f5Q9awIq10G/tff1jyejvfb112TjzCBpg15frK7aFqDjk/nluQiP8NUiE5dn1tLkCS
 513NpmFJTZAmQ==
X-Nifty-SrcIP: [110.4.221.123]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: sigproc: Fix potential race issue regarding
 exit_state.
Date: Sat, 20 Nov 2021 03:39:05 +0900
Message-Id: <20211119183905.1878-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, RCVD_IN_DNSWL_NONE,
 SPF_HELO_NONE, SPF_PASS, TXREP autolearn=ham autolearn_force=no version=3.4.4
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
X-List-Received-Date: Fri, 19 Nov 2021 18:39:33 -0000

- If sig_send() is called while another thread is processing exit(),
  race issue regarding exit_state may occur. This patch fixes the
  issue.
---
 winsup/cygwin/sigproc.cc | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/winsup/cygwin/sigproc.cc b/winsup/cygwin/sigproc.cc
index fde41a9f6..02d875a7f 100644
--- a/winsup/cygwin/sigproc.cc
+++ b/winsup/cygwin/sigproc.cc
@@ -603,11 +603,6 @@ sig_send (_pinfo *p, siginfo_t& si, _cygtls *tls)
       its_me = false;
     }
 
-  /* Do not send signal to myself if exiting, which will be
-     ignored in wait_sig thread. */
-  if (its_me && exit_state > ES_EXIT_STARTING && si.si_signo > 0)
-    goto out;
-
   if (its_me)
     sendsig = my_sendsig;
   else
@@ -1372,7 +1367,7 @@ wait_sig (VOID *)
       sigq.retry = false;
       /* Don't process signals when we start exiting */
       if (exit_state > ES_EXIT_STARTING && pack.si.si_signo > 0)
-	continue;
+	goto skip_process_signal;
 
       sigset_t dummy_mask;
       threadlist_t *tl_entry;
@@ -1384,8 +1379,10 @@ wait_sig (VOID *)
 	  pack.mask = &dummy_mask;
 	}
 
-      sigpacket *q = &sigq.start;
-      bool clearwait = false;
+      sigpacket *q;
+      q = &sigq.start;
+      bool clearwait;
+      clearwait = false;
       switch (pack.si.si_signo)
 	{
 	case __SIGCOMMUNE:
@@ -1482,6 +1479,7 @@ wait_sig (VOID *)
 	}
       if (clearwait && !have_execed)
 	proc_subproc (PROC_CLEARWAIT, 0);
+skip_process_signal:
       if (pack.wakeup)
 	{
 	  sigproc_printf ("signalling pack.wakeup %p", pack.wakeup);
-- 
2.33.0

