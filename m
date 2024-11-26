Return-Path: <SRS0=EpSC=SV=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w09.mail.nifty.com (mta-snd-w09.mail.nifty.com [106.153.227.41])
	by sourceware.org (Postfix) with ESMTPS id 72FE33858C50
	for <cygwin-patches@cygwin.com>; Tue, 26 Nov 2024 08:56:04 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 72FE33858C50
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 72FE33858C50
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.41
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1732611365; cv=none;
	b=qWR230zQn52gZw6aE02PQS+FdpDTbzZaHRb3LVt6YlvYtK2rUMu5DHczZzDkRjWc1eYD9ExNfxpAfBRTUO5BCma0cUkIA4dsIM+K5cr3MzTY92W34nH9s3OyjMsYrIhuVq2nv2jpfoo+dCBDczVA69irztHsq01JfvU5r02pNXE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1732611365; c=relaxed/simple;
	bh=/eABZZJwpRfVq78ISefPfftp5oVQlRWwalAso2mtPl8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=gT4TQ8EqKgAuk4EwW6lSKyxboHULtkxqB35pKszHYWK313CzDjqy6XJAEtXzy9kqAPJl0rEmxgu7n01iCiBu/rPuUgrCGX+qA3Zlwv2QHY6Dc73I5paZO1Z9/mJ3giTDC5JyaHKUxDTEenXz58wMpPpv/EC0PaOP7MU/yTWx1fI=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 72FE33858C50
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=m8zqJObI
Received: from localhost.localdomain by mta-snd-w09.mail.nifty.com
          with ESMTP
          id <20241126085602764.NQVQ.90249.localhost.localdomain@nifty.com>;
          Tue, 26 Nov 2024 17:56:02 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Christian Franke <Christian.Franke@t-online.de>
Subject: [PATCH v2 2/7] Cygwin: signal: Handle queued signal without explicit __SIGFLUSH
Date: Tue, 26 Nov 2024 17:54:59 +0900
Message-ID: <20241126085521.49604-3-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20241126085521.49604-1-takashi.yano@nifty.ne.jp>
References: <20241126085521.49604-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1732611362;
 bh=Y7snFcDoh934Lnvg/muWxv64PtAKwwLNGHlYDLtn42E=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=m8zqJObIzNxKL8ahrN/rlu0H+J8/nrKSQbUEPmYNhU+TPB9oZpH2byDbb7WjCpH33WkMsy3/
 sbBGSKzpDve7+3cbO5ttT38Qj/5sPh+dbZBTtmqI/3DW78dU+YGRx0eajMBPowsbtDTOfOpb/C
 DCC0p9Kg2WiW7CyR3PVQ34Gzdzf17wpaVC/huEL8LE5n6YE8Lj4di3ZZ04t5QOzoTSvq0tCeKW
 0yavDlvm4hv0ojtaBUB/LWdzwaU02MS8cbNOx9bs+GEWtN2kD0TWJBYm8r60hBHgMyiQ5VBnMD
 Ndw/lNVhgoinsFO2jWsEZX4a2vJk4e6Ws1ksQIuIeLqiUMcA==
X-Spam-Status: No, score=-10.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

With the previous code, the queued signal is tried to resend only when
a new signal arrives or pending_signals::pending() is called.
With this patch, if the signal is queued and the retry flag is not set
and the new signal is not received yet, the sig thread tries to handle
the queued signal again. Without this patch, the chance to handle the
queue would be delayed.

Addresses: https://cygwin.com/pipermail/cygwin/2024-November/256744.html
Fixes: 5e31c80e4e8d ("(pending_signals::pending): Force an additional loop through wait_sig by setting retry whenever this function is called.")
Reported-by: Christian Franke <Christian.Franke@t-online.de>
Reviewed-by:
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/sigproc.cc | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/winsup/cygwin/sigproc.cc b/winsup/cygwin/sigproc.cc
index b67eccf4d..8f46a80ab 100644
--- a/winsup/cygwin/sigproc.cc
+++ b/winsup/cygwin/sigproc.cc
@@ -1321,6 +1321,9 @@ wait_sig (VOID *)
       sigpacket pack = {};
       if (sigq.retry)
 	pack.si.si_signo = __SIGFLUSH;
+      else if (sigq.start.next
+	       && PeekNamedPipe (my_readsig, NULL, 0, NULL, &nb, NULL) && !nb)
+	pack.si.si_signo = __SIGFLUSH;
       else if (!ReadFile (my_readsig, &pack, sizeof (pack), &nb, NULL))
 	Sleep (INFINITE);	/* Assume were exiting.  Never exit this thread */
       else if (nb != sizeof (pack) || !pack.si.si_signo)
-- 
2.45.1

