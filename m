Return-Path: <SRS0=da5c=YP=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w08.mail.nifty.com (mta-snd-w08.mail.nifty.com [106.153.227.40])
	by sourceware.org (Postfix) with ESMTPS id DED433858D20
	for <cygwin-patches@cygwin.com>; Sat, 31 May 2025 01:17:02 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org DED433858D20
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org DED433858D20
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.40
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1748654223; cv=none;
	b=t8FEdGz/CxSKvluNTFYJ52qbjJNUgKH9n+VkRLqW/hNjaj9mh515T+4Q80goxYfHb/PHWuOVUv5XQcnWRzuvEP0vzEzB6/gacmI3k+LEMi9LUc+yEl1mLh151QZa2CP++VaLBCx3kG4WaRl4TEbnxPXmZLUJjg4ubRCxyb6RoLw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1748654223; c=relaxed/simple;
	bh=Z9lgV8HRvK4jL4HdbY2ToTLFOfWf72IBOo1ksRR45RE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=edOCAw9nQtjf65vq8K1EOvKQMrHmJisd5V6r9K06w/wrJK/YqASXSiQ1gIYHjg5cHgiO+/X6YcqxOJDeqfqSugbs+yR1+rjLxOEzWOZcwIU4p6ScNaIJ8ajl1XPJUIy/B4vIxS2XiqIAfN89rvlJrQyNQxDTSjDCyNqWbgXgrSQ=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org DED433858D20
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=JtXLa9FQ
Received: from localhost.localdomain by mta-snd-w08.mail.nifty.com
          with ESMTP
          id <20250531011700828.CSQV.78984.localhost.localdomain@nifty.com>;
          Sat, 31 May 2025 10:17:00 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: signal: Set _cygtls::sigmask earlier
Date: Sat, 31 May 2025 10:16:22 +0900
Message-ID: <20250531011630.1500-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1748654220;
 bh=a3nRREggbhN0uKLxBZGMBSSasJ/PeIJ+cigzfCiUyYY=;
 h=From:To:Cc:Subject:Date;
 b=JtXLa9FQYOovKiwIfSfGqQ/ZRimJY9NU+gyvIE4ynBIjybs+UqgsW8hsn5LDnjQlGE8hyP7o
 0HTOUU9+L4oJeN0NA5gLf4a9eA/zVzzRsgARhWOA6jvWMfOFWmUBcCEUlj5RwshJNw0s9a3ZWf
 STq65fAaWwz02JGB7doky0bgUNOY5CPKMC1hJ+Z5E3qYCF+68gIQVLR29otIV67XtGs81H3C3v
 9L0UAjBKv2Jn2WY1KSpcPrgDKFve5Q6MtVz1UAALzIYHh4PNDh/dTJo5aZ464YiB9LzSdV4Ask
 FVXaLTkcO4VdaJziEMHYKEb1LD8fBvXaWiR7xJ6oy+W7Zf8Q==
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Currently, _cygtls::sigmask is set in call_signal_handler(), but this
is too late to effectively prevent a masked signal from being armed. 
With this patch, sigmask is set in _cygtls::interrupt_setup() instead.

Fixes: 0d675c5d7f24 ("* exceptions.cc (interrupt_setup): Don't set signal mask here or races occur with main thread.  Set it in sigdelayed instead.")
Reviewed-by:
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/exceptions.cc | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/exceptions.cc b/winsup/cygwin/exceptions.cc
index bcc7fe6f8..688297d76 100644
--- a/winsup/cygwin/exceptions.cc
+++ b/winsup/cygwin/exceptions.cc
@@ -980,7 +980,8 @@ void
 _cygtls::interrupt_setup (siginfo_t& si, void *handler, struct sigaction& siga)
 {
   push ((__tlsstack_t) sigdelayed);
-  deltamask = siga.sa_mask & ~SIG_NONMASKABLE;
+  oldmask = sigmask;
+  sigmask = (sigmask | siga.sa_mask) & ~SIG_NONMASKABLE;
   sa_flags = siga.sa_flags;
   func = (void (*) (int, siginfo_t *, void *)) handler;
   if (siga.sa_flags & SA_RESETHAND)
@@ -1721,7 +1722,7 @@ _cygtls::call_signal_handler ()
       debug_only_printf ("dealing with signal %d", current_sig);
       this_sa_flags = sa_flags;
 
-      sigset_t this_oldmask = set_process_mask_delta ();
+      sigset_t this_oldmask = _my_tls.oldmask;
 
       if (infodata.si_code == SI_TIMER)
 	{
-- 
2.45.1

