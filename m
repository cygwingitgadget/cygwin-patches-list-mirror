Return-Path: <SRS0=haOa=BZ=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [IPv6:2001:268:fa04:731:6a:99:e2:25])
	by sourceware.org (Postfix) with ESMTPS id 61E8D4B920E4
	for <cygwin-patches@cygwin.com>; Wed, 25 Mar 2026 13:07:44 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 61E8D4B920E4
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 61E8D4B920E4
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2001:268:fa04:731:6a:99:e2:25
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1774444065; cv=none;
	b=P/iPkbdu65gDEVcGyOkuLHkiCiRU6ZPGyChr4G3JC9/2wSv6+Kuc1aBSwC4PLNZaJihU1RyPJqylLoMKA1GcwWSHRdGEQ1wSFDlh6ENmlNQaeXlsTdTkZV9xnn2dAR62gMzFYxc4ewEJhgF9sglEgN6umF9WJqR5k0Xf0nxUnk8=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1774444065; c=relaxed/simple;
	bh=ooe5tjDY/R/sGIUOyH7It75PGl7b9WOu3cWbQdh3Nyo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=havZz+kaU7L63t5nOEeMkzAL7z+bawhI8m9vKJSij6fdSStri56oJgT9tHiuPzCdRXZ53XnfHHMkCOjCn6o2owzYPOqxCyPdlcZjQCuohM+5jDnitspUvuex/l8Ppojqsp6BCNA+daLutI1Sw+Urrp+MKLwixFVZyNKg2Df5tVw=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 61E8D4B920E4
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=hlKiXypi
Received: from HP-Z230 by mta-snd-e05.mail.nifty.com with ESMTP
          id <20260325130742574.GXJF.36235.HP-Z230@nifty.com>;
          Wed, 25 Mar 2026 22:07:42 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: pty: Clear discard_input flag on master write()
Date: Wed, 25 Mar 2026 22:07:22 +0900
Message-ID: <20260325130734.65955-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1774444062;
 bh=rp6RTNMkUO2xG8C1xnV+N/Vao/8KdL/rn11XGCz/Vmo=;
 h=From:To:Cc:Subject:Date;
 b=hlKiXypiZW5R9eN25C0Tk3AiCyy9VwqiyFpp4a41wAC3a0dWVA0Qtbx5ulGoC58DltlmINLn
 FJbGoUvQ7FCZ4HOOQ/wH6OTYV+1exDdlPCwrwp/QK3C/zQHOGXGRKfGmT9XupPzkfJGoqne+Za
 Pw0959UPAyk5q5qIWckZi84fior7Wzh04Xhq/Y58y3GH9PdgJ8xaqlyQdq5Kh523CH9LicrnC0
 yxP/PvE0xoL2uCTkTk65IMdCggkyeJpK6ZCkanxSh5URZ4eEILKYPrzacHAl662Jn9KDu3NE1C
 o4x9yFXUNDza7h1IdZNl1ZHxboLB2nHTpr5STWrknb/CCEPQ==
X-Spam-Status: No, score=-10.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Currently, the first transfer_input() after Ctrl-C does not work
because discard_input flag remains asserted. This can cause loosing
typeahead input for non-cygwin app after Ctrl-C. With this patch,
the discard_input flag is cleared on master write() because the
input is new valid input after discarding input.

Fixes: 4e16e575db04 ("Cygwin: pty: Discard input already accepted on interrupt.")
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by:
---
 winsup/cygwin/fhandler/pty.cc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index 0c50e50f5..c05462d1f 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -2224,6 +2224,8 @@ fhandler_pty_master::write (const void *ptr, size_t len)
 
   push_process_state process_state (PID_TTYOU);
 
+  get_ttyp ()->discard_input = false;
+
   if (get_ttyp ()->pcon_start)
     { /* Reaches here when pseudo console initialization is on going. */
       /* Pseudo condole support uses "CSI6n" to get cursor position.
-- 
2.51.0

