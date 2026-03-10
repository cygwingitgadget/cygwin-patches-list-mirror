Return-Path: <SRS0=Vhwg=BK=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w09.mail.nifty.com (mta-snd-w09.mail.nifty.com [106.153.227.41])
	by sourceware.org (Postfix) with ESMTPS id 70BCE4BA2E18
	for <cygwin-patches@cygwin.com>; Tue, 10 Mar 2026 08:51:07 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 70BCE4BA2E18
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 70BCE4BA2E18
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.41
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1773132668; cv=none;
	b=LrSSCeo7clKMXfkxCvB9A4uB/o8BsmleN+ChQmQ/dZ6OvmS48oiRAz8eW8N8J0BuaspMwilPB/9v+ULQHwQXFVWCaNNgB1qgkX6rXFOs4K/CgrR/b414XcZvWMTG407WHDtV2BisDVuDg6k86Ig8fvcYkrHvqgPZv2krq6k2seM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1773132668; c=relaxed/simple;
	bh=LaH0Sot1eG50EXbLmA5G4CB4SzbvH93l2IgwklyEXKg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=cZ5bRk2HVzpY0V+gVkjahxRVLJd0+wYXmmvdyUjrwPg+wbBYZkz1Rv9vVbdpHYsykZ1V1JgBgwhfqsGcTF+EUJ5Pa7MueUvgqap6zlNEFZ1ftO/dDb9gLqBY2LbwYhVMOW5XHYK0YNQgxeUesznO8OmSCXIoG6eJ0/dnlZeX8VM=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 70BCE4BA2E18
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=g4DDkB7t
Received: from HP-Z230 by mta-snd-w09.mail.nifty.com with ESMTP
          id <20260310085105231.MMDJ.116672.HP-Z230@nifty.com>;
          Tue, 10 Mar 2026 17:51:05 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH 2/3] Cygwin: signal: Do not wait for sendsig for non-cygwin process
Date: Tue, 10 Mar 2026 17:50:08 +0900
Message-ID: <20260310085041.102-3-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260310085041.102-1-takashi.yano@nifty.ne.jp>
References: <20260310085041.102-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1773132665;
 bh=5i8ntgJ+/vcq75Fs8GwBk3dxIBFntl3z0Nh24qajlOQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=g4DDkB7tmD0MPrnPU513UpZVTMfQVyvkw7AJmpUnh1nvvS3LmjXbL9IqZr/ih9fyKz2/4vyh
 GeX9IIz+aYLtfDogBN0qqZCkVgUwtCIjLzOPhmGuZHeJ4jTWUxWVLSm2fd6RQG7vXaZHBnx7iJ
 LjlbtNdzz9TslM4XwcQYlrMCA65fhnZxMlOifBnaK3PXxWnYsV4Dtn4qa0h1GTdn9Ua02g/yUB
 g4h9jh8qmma06gTFKjd6ebnE+2eg2AG7fsJCkk+i/YyXGUM9CXF5uzTTKVK3TRQN/oIS9b/vcb
 fxxGKTRcI7PsPRGY2X3MiXMh/ecOEKAyR2h+DE8fUZ4aNs7A==
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Waiting for `sendsig` to be non-zero for non-cygwin process is
pointless, because it never becomes non-zero (see spawn.cc).
Do not wait `sendsig` for a non-cygwin process.

Fixes: d584454c8231 ("* sigproc.cc (sig_send): Wait for dwProcessId to be non-zero as well as sendsig.")
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by:
---
 winsup/cygwin/sigproc.cc | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/winsup/cygwin/sigproc.cc b/winsup/cygwin/sigproc.cc
index 0fd7ed3ba..4ff05967b 100644
--- a/winsup/cygwin/sigproc.cc
+++ b/winsup/cygwin/sigproc.cc
@@ -646,9 +646,12 @@ sig_send (_pinfo *p, siginfo_t& si, _cygtls *tls)
     {
       HANDLE dupsig;
       DWORD dwProcessId;
-      DWORD t0 = GetTickCount ();
-      while (GetTickCount () - t0 < 100 && !p->sendsig)
-	yield ();
+      if (!ISSTATE (p, PID_NOTCYGWIN))
+	{
+	  DWORD t0 = GetTickCount ();
+	  while (GetTickCount () - t0 < 100 && !p->sendsig)
+	    yield ();
+	}
       if (p->sendsig)
 	{
 	  dupsig = p->sendsig;
-- 
2.51.0

