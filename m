Return-Path: <SRS0=oSj3=V7=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w05.mail.nifty.com (mta-snd-w05.mail.nifty.com [106.153.227.37])
	by sourceware.org (Postfix) with ESMTPS id 2CB093858CD1
	for <cygwin-patches@cygwin.com>; Wed, 12 Mar 2025 03:28:38 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 2CB093858CD1
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 2CB093858CD1
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1741750119; cv=none;
	b=hAXMx6z5PYR2z0Gv4WYVmJQQkFSdRW7wtBG4dJg4hTn8cVM7CO9ZvIB8NwzkhkqxbTy85b7kyw6wxc80w3djUpsYSKnQ9S0CnGmJURD6AyOM+c8MPHxcKSZzs4ApP/u1aNVIdc+5c+zob4onld/xlCaIL6uRMGgJ+r6AlwoTPWs=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1741750119; c=relaxed/simple;
	bh=EnlLLm+aNRHzUEN8EGbcrK4lBWJD0r5mBaLDx7i8P4E=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=JzdwMGyRmdIRP+0hJygvc+e4ElE2nPgGPd59vu9n8HE11A1X3Hhl16RZuYWqFE3r2agNk4CwMg/0ZBovDlk3l7K6OVDZNRUHakJgsmEBeYUoZQRDH1BmS1fbTV9/7cT2M+TpYzEJQYeiySUr+S0Pk+8tRHYhBTH0RQ0p/hp4Mig=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 2CB093858CD1
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=BCziuTf/
Received: from localhost.localdomain by mta-snd-w05.mail.nifty.com
          with ESMTP
          id <20250312032837022.XTRZ.17135.localhost.localdomain@nifty.com>;
          Wed, 12 Mar 2025 12:28:37 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v3 3/6] Cygwin: signal: Ignore SIGSTOP while process is already stopping
Date: Wed, 12 Mar 2025 12:27:29 +0900
Message-ID: <20250312032748.233077-4-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250312032748.233077-1-takashi.yano@nifty.ne.jp>
References: <20250312032748.233077-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1741750117;
 bh=gTLG6RiHBHLUZ6yfgTnqcfDbR3xRjxREiQcQxNjcRbk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=BCziuTf/lyqG1XWybsmQAcMKlrPEPnhBHvQS37NMpqqprcpH3UTRs76y10+szTlu0xr24qi6
 8GzgRmNt4NnBoY7QjgqmElcNEKPyQba9ltWNONTn6HIUl8GU6ckasIQ2clGbrCFrXp69Wv/Qqo
 QZ9aG70gVvTHXwVm1Pxav4TVhnM5542B4Lw2KYIKkcz3bvU+Q5PGaq1scHKIM0cS0JFoaKqe1Q
 WOI7pgBXQoCChCkxrLFL66qNYairzrZ+ZWhxU7d3hkcrKXTGipdSG10IjiEqvD+2X53Y3fJx2t
 VJWnYvzR/bOY3tPd8mrw7wo30AwyGcp1ryOpTPTKWUeND0jg==
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Linux, SIGSTOP while the process is stopping is ignored. With
this patch, SIGSTOP is processed as a success with no effect while
the process is already stopping.

Fixes: 8f8eeb70ba73 ("* exceptions.cc (sigpacket::process): ...")
Reviewed-by:
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/exceptions.cc | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/exceptions.cc b/winsup/cygwin/exceptions.cc
index 73cfc7967..18a566c45 100644
--- a/winsup/cygwin/exceptions.cc
+++ b/winsup/cygwin/exceptions.cc
@@ -1482,7 +1482,10 @@ sigpacket::process ()
     }
   else if (ISSTATE (myself, PID_STOPPED))
     {
-      rc = -1;		/* Don't send signals when stopped */
+      if (si.si_signo == SIGSTOP)
+	rc = 1;		/* Ignore (discard) SIGSTOP */
+      else
+	rc = -1;	/* Don't send signals when stopped */
       goto done;
     }
   else if (!sigtls)
-- 
2.45.1

