Return-Path: <SRS0=ZTWV=S4=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w10.mail.nifty.com (mta-snd-w10.mail.nifty.com [106.153.227.42])
	by sourceware.org (Postfix) with ESMTPS id 95EAA3858D33
	for <cygwin-patches@cygwin.com>; Tue,  3 Dec 2024 14:02:22 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 95EAA3858D33
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 95EAA3858D33
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.42
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1733234543; cv=none;
	b=x0uABe8oPa+SdkAluC9JzT6bhjIyFOy6e0RQhfd9vFQKOjrsXOc86nwe8/NgFWyfLLVA/CC4uMigNSbfQBEd2DvKYNwpk+Pu9BfHzyx6LrEpvar873GySIIQQld2U4YMkuxOAeOriXj3qrdfuuVUmK9LaTFWSNw/vQrZ8SUh7EU=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1733234543; c=relaxed/simple;
	bh=0JgQyaTCgRbDjp9SthfRtEu8XhZxSSXbXt/ycJLRV/0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=bnsuoXaPku4G/YNBo0cE4S441+8DvrnGB8lhQXjD8VuTwsh2AY65BCLAngTcizb9upxtcdML3aESiaoD2141lNO0j+2vhROsAh7p3fkTDXpcGfmAUoDoCUY+DWub3Ayot0GCrU6TqfrWw/ZikR506DBT2nf/A3LcjxLZuYXUxIA=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 95EAA3858D33
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=Et2sORTH
Received: from localhost.localdomain by mta-snd-w10.mail.nifty.com
          with ESMTP
          id <20241203140220362.FAPR.96847.localhost.localdomain@nifty.com>;
          Tue, 3 Dec 2024 23:02:20 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Christian Franke <Christian.Franke@t-online.de>,
	Corinna Vinschen <corinna@vinschen.de>
Subject: [PATCH v4] Cygwin: signal: Optimize the priority of the sig thread
Date: Tue,  3 Dec 2024 23:01:49 +0900
Message-ID: <20241203140203.8351-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1733234540;
 bh=kgdON3wkxJVpRKygbIfzrLcOkns/1Xm/4z6/Yt/OTQ4=;
 h=From:To:Cc:Subject:Date;
 b=Et2sORTHgPLYmOQt2UtblzcMZ9/zIs6RFmUUNtpoHgA2c83cYFv0QLtvspzxERQLrmanCmLu
 k1Iln7WoRrjcPG8TuMecNwejcMOtjG7WisKdNVemuw9RcKce9jqbwdb6dnIjh0yKD0X4h4lgqY
 NxfmsQINdAIlDmyAzDhB86VijIH3gFiH+SjUBGxQThCRUohhdqCcoR6znvhNmKYz0hv6cSVWMY
 sKg43GBPIT77Jd5Pxvx+rP0BRhr/0R0Ktp44F+CeJa1Zf33d4kWXAHHsxN6/EHbtUCgDlre/ER
 OBIloGU3LPm6+scbYpOGUDlL8eoatp415uxl2L73o+A6eqMQ==
X-Spam-Status: No, score=-10.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Previously, the sig thread ran in THREAD_PRIORITY_HIGHEST priority.
This causes a critical delay in the signal handling in the main
thread if too many signals are received rapidly and the CPU is very
busy. In this case, most of the CPU time is allocated to the sig
thread, so the main thread cannot have a chance of handling signals.
With this patch, to avoid such a situation, the priority of the sig
thread is set to THREAD_PRIORITY_NORMAL priority.

Addresses: https://cygwin.com/pipermail/cygwin/2024-November/256744.html
Fixes: 53ad6f1394aa ("(cygthread::cygthread): Use three only arguments for detached threads, and start the thread via QueueUserAPC/async_create.")
Reported-by: Christian Franke <Christian.Franke@t-online.de>
Reviewed-by: Corinna Vinschen <corinna@vinschen.de>
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/sigproc.cc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/winsup/cygwin/sigproc.cc b/winsup/cygwin/sigproc.cc
index 730259484..4c557f048 100644
--- a/winsup/cygwin/sigproc.cc
+++ b/winsup/cygwin/sigproc.cc
@@ -1333,6 +1333,7 @@ wait_sig (VOID *)
 
   hntdll = GetModuleHandle ("ntdll.dll");
 
+  SetThreadPriority (GetCurrentThread (), THREAD_PRIORITY_NORMAL);
   for (;;)
     {
       DWORD nb;
-- 
2.45.1

