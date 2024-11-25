Return-Path: <SRS0=SJZz=SU=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w02.mail.nifty.com (mta-snd-w02.mail.nifty.com [106.153.227.34])
	by sourceware.org (Postfix) with ESMTPS id CB7CF3857BB9
	for <cygwin-patches@cygwin.com>; Mon, 25 Nov 2024 12:17:46 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org CB7CF3857BB9
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org CB7CF3857BB9
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.34
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1732537067; cv=none;
	b=rOJB4nqeCkYDYoE7OzJyM3bd9Spze1CGLjReUHSaQbMzidA23l4Yub2dwZwd4fyOXOGRVtB9nSbYmAvuPE4a8SFgy6YVMsmAe7T2ud1OgjGoXlgiHv8iALgDIEJvniYWSzG7rs9+V7tKPLUQVvKfH6kqSreuJjmCtgTPATBIPuk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1732537067; c=relaxed/simple;
	bh=Rc0uiTi3+sskVZNk0vIVsumFBd+sqK1KuMgdidwNtSI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=V44f1nOgE6yyzdHRQgp/Q9uqkIgs3REWbLJ+qiIApU2TUXDkVBdFJSD01qClZ08YKBkuGDhns9US5jYR7VlQ6r4q7VSoxQFiwyqnc/CoOLSZwFGwl3Ti7Cg4sdCTafgx/sQ0CQone45VDXQYyn/vZz1W/ZQKErRdoCBdI3rJFXI=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org CB7CF3857BB9
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=HgETFpKG
Received: from localhost.localdomain by mta-snd-w02.mail.nifty.com
          with ESMTP
          id <20241125121745196.KENB.47547.localhost.localdomain@nifty.com>;
          Mon, 25 Nov 2024 21:17:45 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Christian Franke <Christian.Franke@t-online.de>
Subject: [PATCH 5/6] Cygwin: signal: Drop unnecessary queue flush
Date: Mon, 25 Nov 2024 21:16:21 +0900
Message-ID: <20241125121632.1822-6-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20241125121632.1822-1-takashi.yano@nifty.ne.jp>
References: <20241125121632.1822-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1732537065;
 bh=Eiq9sq1IumgCreK3c4pJMnD37RhT0MP5Pu2hjRfxr+4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=HgETFpKGpAmgJP8cmz9XzO2x5wzF9gdfyh8OBu7HAbPSvTkvu0u92rhX/JThexgoXZbQWB4Z
 fDYNvvKo6Zs6GlGhZfAgizYk2VPu6/lrljZhYuhsYjNfEy6y/b7ucTmmiCZmj+zATB6otEKnz7
 C6a9YiFkQ+U3lFIIxSjE/Ck0RS6CnB/ZG1z8nJwwzaZ2DprtDqI5nzLsVxQ/i1L0qabEFPCTCU
 jYTVLwY5M6mu42KKzi2Jp0TIWx/hniFBHy2pK/x7UDDWEskEnjGngrX15Tpo+xf4M5tQdt2APN
 I5hqhOBbjpLJLwHfBBYIZPsPlr6TgMhcvZpAArQ937MW65vg==
X-Spam-Status: No, score=-10.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Previously, retry flag was always set when pending_signal::pending()
was called. However, if the queue is empty sig thread try to flush
the queue even though it was not necessary. With this patch, the
retry flag is set only if the queue is not empty.

Addresses: https://cygwin.com/pipermail/cygwin/2024-November/256744.html
Fixes: 5e31c80e4e8d ("(pending_signals::pending): Force an additional loop through wait_sig by setting retry whenever this function is called.")
Reported-by: Christian Franke <Christian.Franke@t-online.de>
Reviewed-by:
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/sigproc.cc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/winsup/cygwin/sigproc.cc b/winsup/cygwin/sigproc.cc
index 75a5142fd..01fd47a06 100644
--- a/winsup/cygwin/sigproc.cc
+++ b/winsup/cygwin/sigproc.cc
@@ -110,7 +110,7 @@ class pending_signals
 
 public:
   void add (sigpacket&);
-  bool pending () {retry = true; return !!start.next;}
+  bool pending () {retry = !!start.next; return retry;}
   void clear (int sig) {sigs[sig].si.si_signo = 0;}
   void clear (_cygtls *tls);
   friend void sig_dispatch_pending (bool);
-- 
2.45.1

