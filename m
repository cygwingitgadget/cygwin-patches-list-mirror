Return-Path: <SRS0=Vhwg=BK=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w09.mail.nifty.com (mta-snd-w09.mail.nifty.com [106.153.227.41])
	by sourceware.org (Postfix) with ESMTPS id 8963A4BA23C9
	for <cygwin-patches@cygwin.com>; Tue, 10 Mar 2026 08:50:59 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 8963A4BA23C9
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 8963A4BA23C9
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.41
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1773132660; cv=none;
	b=xCwjvaX4MS8/eVT44CuGS6VVGjfpOJjOvsl0kGlJ3fMlea+jdCyYs/GcwDbAQYWJq9Co8LfJ79oiTV6ruk04NPZqlDr+7d3WlL3y3W+giD5IQP0BmgsulO7CgSesCIC8i2bGf7XHMOOqE6edivAKCxRmlne50+1sLR+9UkzeKEc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1773132660; c=relaxed/simple;
	bh=+Yv5KAU+y6oGTJQRgOfclwVxPvCiO4E4gEidVIFEVUU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=bErXd74qa7ENR2mJmAegco9Wfgifp1WscLwaGT6XVzyFYX996i7xdV2k40eWXkA+dBOLh4mP68OExlRPfpg9+Jj3rnRngmyXxQC6hj+ErN5dQB85EjBmvfTGEqHXZ8iBf5C7z7JiDBChXsgPgykWn7liM4r0OJTtrNklNcIT5S4=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 8963A4BA23C9
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=cocTQp0z
Received: from HP-Z230 by mta-snd-w09.mail.nifty.com with ESMTP
          id <20260310085057495.MMBY.116672.HP-Z230@nifty.com>;
          Tue, 10 Mar 2026 17:50:57 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH 1/3] Cygwin: signal: Wait for `sendsig` for a sufficient amount of time
Date: Tue, 10 Mar 2026 17:50:07 +0900
Message-ID: <20260310085041.102-2-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260310085041.102-1-takashi.yano@nifty.ne.jp>
References: <20260310085041.102-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1773132657;
 bh=BHfWotsadic2TLSyR4o02z/8vqVuhXWIQIIm/3Gy/CQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=cocTQp0zPhZV5T01YosQC0p55Ve/HqLx+M9FGGWHvmQjAV1e6s2+gKcRIgX+Hoi3uNSHW+Bh
 jOpdTsvCQo9t0cqsdragyDT67IBulY4SSgenqJzBWg4/vg0w249YPFZAiuBg9girLfeRkF/FLN
 QGLP1M+P14zdbszs+0Uic8oDiIv8vAWPpiKsGneTuXTuHpLT1MzRskTF8f8IPaAVm58X1FbBAV
 FBtqF4zKbmq8AQqV9h+8cEmLQ355kLL77YMFmua/02FXYRy31D0OOXh/rrG2UPqvFDQ9ttkUWA
 0dyPdPGKg/6Y/m9C5je0g25S9UtJZOGGdDdH3CPgvYcMlmig==
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

The current code waits for `sendsig` by `for` loop in sigproc.cc,
however, the wait time might be insufficient for recent CPU.
The current code is as follows.

   for (int i = 0; !p->sendsig && i < 10000; i++)
     yield ();

Due to this problem, in tcsh, the following command occasionally
cannot be terminated by Ctrl-C. This is because, SIGCONT does not
wake-up `sleep` process correctly.

  $ cat | sleep 100 &
  $ fg
  $ (type Ctrl-C)

With this patch, the wait time for `sendsig` is guaranteed to be
up to 100ms instead of looping for 10000 times.

Fixes: d584454c8231 ("* sigproc.cc (sig_send): Wait for dwProcessId to be non-zero as well as sendsig.")
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by:
---
 winsup/cygwin/sigproc.cc | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/sigproc.cc b/winsup/cygwin/sigproc.cc
index 30779cf8e..0fd7ed3ba 100644
--- a/winsup/cygwin/sigproc.cc
+++ b/winsup/cygwin/sigproc.cc
@@ -646,7 +646,8 @@ sig_send (_pinfo *p, siginfo_t& si, _cygtls *tls)
     {
       HANDLE dupsig;
       DWORD dwProcessId;
-      for (int i = 0; !p->sendsig && i < 10000; i++)
+      DWORD t0 = GetTickCount ();
+      while (GetTickCount () - t0 < 100 && !p->sendsig)
 	yield ();
       if (p->sendsig)
 	{
-- 
2.51.0

