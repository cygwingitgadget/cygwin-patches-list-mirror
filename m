Return-Path: <SRS0=SJZz=SU=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w02.mail.nifty.com (mta-snd-w02.mail.nifty.com [106.153.227.34])
	by sourceware.org (Postfix) with ESMTPS id 96F15385841D
	for <cygwin-patches@cygwin.com>; Mon, 25 Nov 2024 12:17:32 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 96F15385841D
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 96F15385841D
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.34
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1732537053; cv=none;
	b=E84ypHGXhIRUcgvZU3P6Hk+aPURUn2f++roQ/EU2rVmnmdCT8Ey9Xu9SEgXZrsZow/6Nz8dRwQKuZktjG5Dts5X4pNnAjqoTv9qhHOw9ePhCa28PW/zVXB0e35B8i3n2jHt3seoVGLzOZrrPOGHgwXpIFqG+gqSxJY8JFZPNA6M=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1732537053; c=relaxed/simple;
	bh=4fjsC7YQpKr3EgjXYls60ZZ0Fjb/OtWZuUF3PaYzIyU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=xlXAYjd8QbUMDx4xG5dmBrLSnZniXYkgxQcsZnCDGzcx8+PX3wx6hy/fBKg6W9u0J8U3/rfTUIzh8JcqUaji0V2OxL18uQ9fu4jEYiIEvlKNoGF7tRr8vzDXqtnV9/Hy6MaF3CKfrRNP7m2KOI+ukwhoX0jiim5Db6Qo6aMA5VQ=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 96F15385841D
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=cIxS2s9C
Received: from localhost.localdomain by mta-snd-w02.mail.nifty.com
          with ESMTP
          id <20241125121730982.KEMF.47547.localhost.localdomain@nifty.com>;
          Mon, 25 Nov 2024 21:17:30 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Christian Franke <Christian.Franke@t-online.de>
Subject: [PATCH 4/6] Cygwin: signal: Optimize the priority of the sig thread
Date: Mon, 25 Nov 2024 21:16:20 +0900
Message-ID: <20241125121632.1822-5-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20241125121632.1822-1-takashi.yano@nifty.ne.jp>
References: <20241125121632.1822-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1732537051;
 bh=jRtsLKhFFP2NhGasfLO53SAxyNChAFIYGPynESuZpS4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=cIxS2s9C8ZVTn5/FZsv/JoiJkwAcz3LWoMbTjYKSc1ZrlyfgssuE9+ZBjPYPn1YaQQ756fL9
 ASnqWZgRzU/eYi4hFFyDpbmC/NnSymksOjs8Bm4vvoiDc/AG8xZUAcHifQM6QgMP6VZbvH83JS
 lweiNA4UF2ciQtpOzooqiPGjc6/45o8emwt2lDo4suRXMK11yiU2VKMIQYSS8XuJRPxy0qeHfM
 Z3gDHKSI7AMMl2rUm5i5Cne5OshDh7IHF7GNGUxgGClYFYCNvtnC3PhYn8jDnp8HUN/v8zrI+y
 GJuUq+t3G/t8a/3AH1yp1RJqgHWKAodzwG2auEAzd4I1Du9A==
X-Spam-Status: No, score=-10.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Previously, sig thread ran in THREAD_PRIORITY_HIGHEST priority.
This caused critical delay in signal handling in the main thread
if the too many signales are received rapidly and CPU is very busy.
I this case, most of CPU time is allocated to sig thread, so the
main thread cannot have a chance to handle signals. With this patch,
the sig thread priority is set to the same priority with main thread
to avoid such situation. Furthermore, if the signal is alarted to
the main thread, but main thread does not handle it yet, in order to
increase the chance to handle it in the main thread, reduce the sig
thread priority is to THREAD_PRIORITY_LOWEST temporarily.

Addresses: https://cygwin.com/pipermail/cygwin/2024-November/256744.html
Fixes: 53ad6f1394aa ("(cygthread::cygthread): Use three only arguments for detached threads, and start the thread via QueueUserAPC/async_create.")
Reported-by: Christian Franke <Christian.Franke@t-online.de>
Reviewed-by:
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/sigproc.cc | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/winsup/cygwin/sigproc.cc b/winsup/cygwin/sigproc.cc
index 541f90cb7..75a5142fd 100644
--- a/winsup/cygwin/sigproc.cc
+++ b/winsup/cygwin/sigproc.cc
@@ -1327,6 +1327,10 @@ wait_sig (VOID *)
     {
       DWORD nb;
       sigpacket pack = {};
+      /* Follow to the main thread priority */
+      int prio = GetThreadPriority (OpenThread (THREAD_QUERY_INFORMATION,
+						FALSE, _main_tls->thread_id));
+      SetThreadPriority (GetCurrentThread (), prio);
       if (sigq.retry)
 	pack.si.si_signo = __SIGFLUSH;
       else if (sigq.start.next
@@ -1339,6 +1343,10 @@ wait_sig (VOID *)
 	  system_printf ("garbled signal pipe data nb %u, sig %d", nb, pack.si.si_signo);
 	  continue;
 	}
+      if (_main_tls->current_sig)
+	/* Decrease the priority in order to make main thread process
+	   this signal. */
+	SetThreadPriority (GetCurrentThread (), THREAD_PRIORITY_LOWEST);
 
       sigq.retry = false;
       /* Don't process signals when we start exiting */
-- 
2.45.1

