Return-Path: <SRS0=o9c9=JC=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from dmta0010.nifty.com (mta-snd00012.nifty.com [106.153.226.44])
	by sourceware.org (Postfix) with ESMTPS id 9D3723858D1E
	for <cygwin-patches@cygwin.com>; Wed, 24 Jan 2024 13:45:15 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 9D3723858D1E
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 9D3723858D1E
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.44
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1706103918; cv=none;
	b=RikzfgrgP4mehmcxsIszd2FY2Y1i8cuOk7nlSggG9G+uaQsWyeKHKNEtXXWo1vbFOZPf2bbAtxQWzgQLAi8PRg3QrMSetVgd+CiVWpCVwRStyGkKqFLssZ+jtv7GLyPldQV24erTyRHpO0O2o74hIc6Of5q5LayHDiF4rA6iIqw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1706103918; c=relaxed/simple;
	bh=BNaXHzRBeB5QXXe5kSBGFVVNzXWDPpkvv0Q0p+byBpc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=UcD1wkb9WOwTNrYXkqHkLd55UBIARNgWzn8uPZw2k/jnhA5M+kT6CwXU/f2C2jUAqk17EUcAH3TRTRc/3ba8msZVPEb1YtRa5IOKm8+AI3ulTxdqjpFyrq1R+7H3obNBoOtHb2jc86WGlKPe7D8FCNu2ksasBBysH5nOxWUzC7c=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from localhost.localdomain by dmta0010.nifty.com with ESMTP
          id <20240124134513234.ZSBM.108497.localhost.localdomain@nifty.com>;
          Wed, 24 Jan 2024 22:45:13 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Corinna Vinschen <corinna@vinschen.de>
Subject: [PATCH] Cygwin: pthread: Fix handle leak in pthread_once.
Date: Wed, 24 Jan 2024 22:44:48 +0900
Message-ID: <20240124134448.39071-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

If pthread_once() is called with pthread_once_t initialized using
PTREAD_ONCE_INIT, pthread_once does not release pthread_mutex used
internally. This patch fixes that by calling pthread_mutex_destroy()
in the thread which has called init_routine.

Reviewed-by: Corinna Vinschen <corinna@vinschen.de>
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/thread.cc | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/winsup/cygwin/thread.cc b/winsup/cygwin/thread.cc
index 7bb4f9fc8..0f8327831 100644
--- a/winsup/cygwin/thread.cc
+++ b/winsup/cygwin/thread.cc
@@ -2060,6 +2060,9 @@ pthread::once (pthread_once_t *once_control, void (*init_routine) (void))
     {
       init_routine ();
       once_control->state = 1;
+      pthread_mutex_unlock (&once_control->mutex);
+      while (pthread_mutex_destroy (&once_control->mutex) == EBUSY);
+      return 0;
     }
   /* Here we must remove our cancellation handler */
   pthread_mutex_unlock (&once_control->mutex);
-- 
2.43.0

