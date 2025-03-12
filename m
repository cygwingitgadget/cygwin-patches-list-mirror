Return-Path: <SRS0=oSj3=V7=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w05.mail.nifty.com (mta-snd-w05.mail.nifty.com [106.153.227.37])
	by sourceware.org (Postfix) with ESMTPS id 9018C3858C2D
	for <cygwin-patches@cygwin.com>; Wed, 12 Mar 2025 03:29:08 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 9018C3858C2D
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 9018C3858C2D
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1741750149; cv=none;
	b=M9eiQTyoXsj0na3lwyLifg56Y/i7RSN2wbvKdjfz/zLGiMPZ7GT58ZPCaXmJZNdUGBAR20kNJfvn1iMm+tf+V5gZxMUivkPFM8kIWmSPiPzXU3ahqPtyGDxZp2ggj2O0+IyRggQiNkjlcWe9MmK0LfCbyE8kxtZmqMezpKzt7zY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1741750149; c=relaxed/simple;
	bh=rz5GDkHajnfebEIAPWo6UJ+hROhX7lsUzmeStsASnX0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=GoFvHUXdKctJ4ni97xNUFI7TqCCPeTGJCaNR51gJnsjR/elDwzLckIQV1BOK8yFSXoVtOx0Qh35ZMRgpS7ZKMvcT3Ak5mvtVtOLu6lmGhMczW/5wKXjDi/y//hNwGf6Tl9E43NWcTgNrabVkytrUGB6IUbrPcTEFrlSpEYH6FQM=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 9018C3858C2D
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=Cas2zFDb
Received: from localhost.localdomain by mta-snd-w05.mail.nifty.com
          with ESMTP
          id <20250312032906429.XTSR.17135.localhost.localdomain@nifty.com>;
          Wed, 12 Mar 2025 12:29:06 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v3 6/6] Cygwin: signal: Remove context_copy in call_signal_handler()
Date: Wed, 12 Mar 2025 12:27:32 +0900
Message-ID: <20250312032748.233077-7-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250312032748.233077-1-takashi.yano@nifty.ne.jp>
References: <20250312032748.233077-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1741750146;
 bh=VI0sS3DRSMOCYOMMiMGwUU+ThkQv+3BJXmbePIbvkC4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Cas2zFDb4JWPjZOvIiuMhCHvn0UjEeK3YVXLNy+H2SJeP1Moemoh3iVSLk3xPc1GUpX5kfWH
 QD3+7taO2tXxj7cuD2zHTjgYAKQDrsZFK7VQljO7zPsXZCWgZX6mgNZ5FmHoZD7wwkBhSThDUx
 q5K5ISde/e+R32FNys1h8O/0ZtubjAlre5twWO0M3cQcmkuK2Qk+A++AcAtAw979E9h6YExkcQ
 3+pbe3AG2hKfHAgSinqglgb3lADKT0Mbqde+Wf3YUqXpt7nFgUax1j3NTJFwwfIsE7LqpQLicf
 /RsOlzxP94ezLJi1sIyI0DoQF3mMuoODPVRB6zKZDKPz3MHA==
X-Spam-Status: No, score=-10.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

After the commit 1d97f8aa4385, context_copy in call_signal_handle()
is not used anymore. This patch removes it.

Fixes: 1d97f8aa4385 ("Cygwin: signals: don't evaluate SA_SIGINFO context after handler returns")
Reviewed-by:
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/exceptions.cc | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/winsup/cygwin/exceptions.cc b/winsup/cygwin/exceptions.cc
index 1e19af68c..c9fe6a386 100644
--- a/winsup/cygwin/exceptions.cc
+++ b/winsup/cygwin/exceptions.cc
@@ -1694,7 +1694,7 @@ _cygtls::call_signal_handler ()
       siginfo_t thissi = infodata;
       void (*thisfunc) (int, siginfo_t *, void *) = func;
 
-      ucontext_t *thiscontext = NULL, context_copy;
+      ucontext_t *thiscontext = NULL;
 
       /* Only make a context for SA_SIGINFO handlers */
       if (this_sa_flags & SA_SIGINFO)
@@ -1752,7 +1752,6 @@ _cygtls::call_signal_handler ()
 				     ? (uintptr_t) thissi.si_addr : 0;
 
 	  thiscontext = &context1;
-	  context_copy = context1;
 	}
 
       int this_errno = saved_errno;
-- 
2.45.1

