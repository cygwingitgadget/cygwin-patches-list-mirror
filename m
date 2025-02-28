Return-Path: <SRS0=PYjw=VT=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e08.mail.nifty.com (mta-snd-e08.mail.nifty.com [106.153.226.40])
	by sourceware.org (Postfix) with ESMTPS id B9C6C3858C5F
	for <cygwin-patches@cygwin.com>; Fri, 28 Feb 2025 13:43:11 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B9C6C3858C5F
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org B9C6C3858C5F
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.40
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1740750192; cv=none;
	b=pdxATuhcAZ0Mcs37ko3M5zzVpbRvh9S9OEfIKXhdSIKSmXDl6UYA+ejYfNbJcK60e/Erc0DwDBs8qMk/rjJ6UPGPN8O8pnJjUe9nVeOqzF2f3zpgXieQuV3YpZVJSgPdMatdPEnUb3M2NSD87oQB2MrwPdyNql14H/9SnNTnMXQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1740750192; c=relaxed/simple;
	bh=bEvQAIYksfuwrmEo80NxEHWqyDd22vWFy/maQ7GXR34=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=dNrpoTA+el06zTEdFF0yTaEPcA8CYyUcpmUOACjzWlVmvQ//lJPKN/g+Sc0oE/fG1Al2NMlqzdsVWYtD0fIyb3DiYudrHaGvQYJ2aNBVTfY0Eugfw6NBVxusmlmshgJcEVW0pD25FXbp+Y4/2iWBZMqDdhyIy8zqCIRK32xiT4M=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org B9C6C3858C5F
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=Asj3wHeS
Received: from localhost.localdomain by mta-snd-e08.mail.nifty.com
          with ESMTP
          id <20250228134310003.ETSB.40215.localhost.localdomain@nifty.com>;
          Fri, 28 Feb 2025 22:43:10 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Christian Franke <Christian.Franke@t-online.de>
Subject: [PATCH 3/3] Cygwin: signal: Fix a problem that process hangs on exit
Date: Fri, 28 Feb 2025 22:42:20 +0900
Message-ID: <20250228134231.1701-4-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250228134231.1701-1-takashi.yano@nifty.ne.jp>
References: <20250228134231.1701-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1740750190;
 bh=4nYswNUNLYMGuXy1ouh88bkUf+ltZsmUzcDe+REyIrc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Asj3wHeSGBccphZFAeVQGgj9NHfi0SUMZuvRelbhstFR0XKlNhVJe2qgcVSPDOSp1bc9jdxq
 c08mUZtUDGKWAcmQIIvsvKGM6PmHnn/bibY6X+QrgeAhXcC/y+WgTjUssKNYrR3KIoZ82bsr2Y
 9vE5o9WO/9glTtY6UR/vycdxus4kYaa3AKn3UHQngRCit7brVdhYuZq6KZoMDL+Kilw0xmQo0/
 uT0YnLPjPOOUzptghhXJFH7j7fvpnaGQxEWJtN8mBZbXNeEH7HTPYnRGwKUozwvbuT9pqwrdzj
 C/gZ6KYoMM8XRO/7R3/Y9dTlPhRLv2XjByCnc6bkRLvmJkoQ==
X-Spam-Status: No, score=-10.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

The process that receives many SIGSTOP/SIGCONT signals sometimes hangs
on exit in sig_dispatch_pending(). This patch avoids processing signals
in sig_dispatch_pending() as if __SIGFLASHFAST is used.

Addresses: https://cygwin.com/pipermail/cygwin/2025-February/257473.html
Fixes: d243e51ef1d3 ("Cygwin: signal: Fix deadlock between main thread and sig thread")
Reported-by: Christian Franke <Christian.Franke@t-online.de>
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/sigproc.cc | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/sigproc.cc b/winsup/cygwin/sigproc.cc
index 8739f18f5..7cfa37d8f 100644
--- a/winsup/cygwin/sigproc.cc
+++ b/winsup/cygwin/sigproc.cc
@@ -743,7 +743,8 @@ sig_send (_pinfo *p, siginfo_t& si, _cygtls *tls)
     }
 
   unsigned cw_mask;
-  cw_mask = pack.si.si_signo == __SIGFLUSHFAST ? 0 : cw_sig_restart;
+  cw_mask =
+    (pack.si.si_signo == __SIGFLUSHFAST || exit_state) ? 0 : cw_sig_restart;
 
   DWORD nb;
   BOOL res;
-- 
2.45.1

