Return-Path: <SRS0=ZTWV=S4=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w10.mail.nifty.com (mta-snd-w10.mail.nifty.com [106.153.227.42])
	by sourceware.org (Postfix) with ESMTPS id 5C8223858CDA
	for <cygwin-patches@cygwin.com>; Tue,  3 Dec 2024 14:02:37 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 5C8223858CDA
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 5C8223858CDA
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.42
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1733234557; cv=none;
	b=D5uG0sm9Z7Yeeq8XRVKPbtA9pDtFjNbbCw7jG7Ya9vvRwi8raXm91Q6kcf9znuVw6/MI6d2DCS7c3hwst2vxdZQZhIC9ZRpAgT7jwv9H15GqQPRz8O3jDuODcRGTi2DFPYnIkmb4IZGvv3gSjeuzGq6YMxzuF7n7nTxvxgsFTfE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1733234557; c=relaxed/simple;
	bh=XAtd7r0v09zD4w8DXvmukAlCCtlYHxCqP8XV+owVUDo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=Ay/9IH8v5J0HvG9NMzvMByDuJ5e/fE6PUtRQdCKtcznkMHY+sm6LoXfgFl5qNKXt1EEFty9djUg5z5CZdWKBtuz8u1dwhFB3MBGOK/wm0qqu/cdNJtyUsQa0xgsHlEZpbJLU0cYyoqdugvUqavVDpxoUSZOqBP7gbGnu/wKYUVE=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 5C8223858CDA
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=ZU1DDBWt
Received: from localhost.localdomain by mta-snd-w10.mail.nifty.com
          with ESMTP
          id <20241203140235659.FAQG.96847.localhost.localdomain@nifty.com>;
          Tue, 3 Dec 2024 23:02:35 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Christian Franke <Christian.Franke@t-online.de>
Subject: [PATCH] Cygwin: signal: Increase chance of handling signal in main thread
Date: Tue,  3 Dec 2024 23:01:50 +0900
Message-ID: <20241203140203.8351-2-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20241203140203.8351-1-takashi.yano@nifty.ne.jp>
References: <20241203140203.8351-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1733234555;
 bh=o0/7BDrQyk7kDVZHwWZrTPgnFOd7HZyOvUDk6LtCwRY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ZU1DDBWt/Ec45dgcG13vuNDwCqZk0dp0p1Pv7LxGFjSxT8uic6p/swebks8lYl4mtzQgUbqa
 SLBOryS/cSdvJ7rktpxJALQBFphcrr7Itwxxae2T1TkhxWji2JNgiS3Ip9VKlyXtMB7w6kH7/y
 K58EkRQvr6N7w798T0WJs8pi/oh+reMSvoCjL8tRwGC+OvVbQjjTH7XRVLQaPRh6SJspzrGsNw
 UdE1jCZ33rHL0cLmxPI4WGq8uISGWfph7kO31GvsrtxXx/Ae32520Bpofv7UloGsLozkwsILTd
 evRCMlqRL/+CKhxI01a79gNR910urOZLBJUZ+9HehqSKszfg==
X-Spam-Status: No, score=-10.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

If process() failed and the signal remains in the queue, the most
possible reason is that the target thread already armed by another
signal and do not handle it yet. With this patch, to increase the
chance of handling it in the other threads, call yield() before
retrying process().

Addresses: https://cygwin.com/pipermail/cygwin/2024-November/256744.html
Fixes: e10f822a2b39 ("Cygwin: signal: Handle queued signal without explicit __SIGFLUSH")
Reported-by: Christian Franke <Christian.Franke@t-online.de>
Reviewed-by:
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/sigproc.cc | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/sigproc.cc b/winsup/cygwin/sigproc.cc
index 4c557f048..7e02e61f7 100644
--- a/winsup/cygwin/sigproc.cc
+++ b/winsup/cygwin/sigproc.cc
@@ -1342,7 +1342,10 @@ wait_sig (VOID *)
 	pack.si.si_signo = __SIGFLUSH;
       else if (sigq.start.next
 	       && PeekNamedPipe (my_readsig, NULL, 0, NULL, &nb, NULL) && !nb)
-	pack.si.si_signo = __SIGFLUSH;
+	{
+	  yield ();
+	  pack.si.si_signo = __SIGFLUSH;
+	}
       else if (!ReadFile (my_readsig, &pack, sizeof (pack), &nb, NULL))
 	Sleep (INFINITE);	/* Assume were exiting.  Never exit this thread */
       else if (nb != sizeof (pack) || !pack.si.si_signo)
-- 
2.45.1

