Return-Path: <SRS0=zjkU=SY=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w09.mail.nifty.com (mta-snd-w09.mail.nifty.com [106.153.227.41])
	by sourceware.org (Postfix) with ESMTPS id CA4713858C66
	for <cygwin-patches@cygwin.com>; Fri, 29 Nov 2024 12:00:45 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org CA4713858C66
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org CA4713858C66
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.41
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1732881646; cv=none;
	b=tm0jhTbDcLp1JTLT5JzXJfYekCTEHLb6hg0jUMIvuTOW7qhCmeMtH9zTA5mIVWuhGygHcHEW/ow8oxOavpwxEcTTzejGhI6oePocQ+A0vqEX4fJUOiGmk7EZJ//RDd+JC7naDcOn1V3Z75csLiUgciaSVHQ8JAK1V/ka6xM3B8U=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1732881646; c=relaxed/simple;
	bh=6HciRyn/3HQLbyr5O/GHl/hdtesOWvnFX5GvFsfrs4w=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=JsPMTxWaIaV5O35WqPP0WkfG9jIvjaMhvfOPelpO9S9RvqUXaCqTxN4LV9L4sxxVuPcqrnmnt9TJP9Zdw1CiwV1B/P8fgqJVUnh1+H4RGTt0PL5fSGNwDP361OePJw+NkbFyAeYi0zcrWrqh1oOaVbY3t2+8fTC31oXOlXBxHok=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org CA4713858C66
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=p05M+crf
Received: from localhost.localdomain by mta-snd-w09.mail.nifty.com
          with ESMTP
          id <20241129120044186.ZBKP.90249.localhost.localdomain@nifty.com>;
          Fri, 29 Nov 2024 21:00:44 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Christian Franke <Christian.Franke@t-online.de>
Subject: [PATCH 9/9] Cygwin: signal: Fix a short period of deadlock
Date: Fri, 29 Nov 2024 20:59:55 +0900
Message-ID: <20241129120007.14516-3-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20241129120007.14516-1-takashi.yano@nifty.ne.jp>
References: <20241129120007.14516-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1732881644;
 bh=F8xJt4LppBFWWUuqbfgZzZ7PZ25ketjKuNfExVFokcE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=p05M+crf3lpP0sSD4PnaTT/2NlKBlyRBkKFWKDsLy2pok0uGgmPjCGd76NsgaPxnRhajyERr
 DrlxdNynYww18i3Z+ECA5e9C77CoJZ72dUazaZ0SnQi4tud/DuzJ5Lv10sauen23G2FiGaScqA
 x2g1Pi7z98e3TXtv1kt5emM1GruuH8fQ7pnMFcqBWntpTm9wBieLhvBKXMno3gV9x4WtHQA+gV
 qpMcISytXYanAFpJ8RAKBZV5UfGxj+49RkGpuo7WGQxxkeYg+YOzZC8Wo/VUpnu9kdaIrLi/mt
 3yT+FDNvdhCI+cOSIAU3po3rNHqhfm6oTegs1aqZ57GLsWjg==
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

The main thread waits for the sig thread to read the signal pipe by
calling Sleep(10) if writing to the signal pipe has failed. However,
if the signal thread waiting for another signal being handled in the
main thread, the sig thread does not read the signal pipe. To avoid
such a situation, this patch replaces Sleep(10) to cygwait().

Addresses: https://cygwin.com/pipermail/cygwin/2024-November/256744.html
Fixes: 6f05b327678f ("(sig_send): Retry WriteFiles which fail when there is no error but packbytes have not been sent.")
Reported-by: Christian Franke <Christian.Franke@t-online.de>
Reviewed-by:
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/sigproc.cc | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/sigproc.cc b/winsup/cygwin/sigproc.cc
index 8c788bd20..4c557f048 100644
--- a/winsup/cygwin/sigproc.cc
+++ b/winsup/cygwin/sigproc.cc
@@ -741,7 +741,8 @@ sig_send (_pinfo *p, siginfo_t& si, _cygtls *tls)
       res = WriteFile (sendsig, leader, packsize, &nb, NULL);
       if (!res || packsize == nb)
 	break;
-      Sleep (10);
+      if (cygwait (NULL, 10, cw_sig_eintr) == WAIT_SIGNALED)
+	_my_tls.call_signal_handler ();
       res = 0;
     }
 
-- 
2.45.1

