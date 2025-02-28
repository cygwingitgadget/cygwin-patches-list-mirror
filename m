Return-Path: <SRS0=PYjw=VT=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w09.mail.nifty.com (mta-snd-w09.mail.nifty.com [106.153.227.41])
	by sourceware.org (Postfix) with ESMTPS id 6BB903858D1E
	for <cygwin-patches@cygwin.com>; Fri, 28 Feb 2025 23:34:55 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 6BB903858D1E
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 6BB903858D1E
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.41
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1740785696; cv=none;
	b=luFYi10UpcPmNRMO1FLUTHv+AUVasUGJKHmzQXLEwk7l/Cxtnb206IWWZgQT++txEYug7P9rcW6XjQQJ2z1vHy2Bu56t+bCX/TELxWRBg+Nh+O9zt6GTBgzKdcrssDoa4odwebyI2LN88SAq6+xwNtZedoYCaGezy3Uw2eQC5ME=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1740785696; c=relaxed/simple;
	bh=3LUg5Hl3EZRoYDzDAsx63Ag3/pRwjTfe3OwwGw/LeOA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=I026KdZSZLec8ikVkxwG4Qjth0QY8dwoL1bjrYDZofSQ4+49xhmoc1zsKvRHfOci/NJkNqfMeKrP7dP3ynK1eyKqVI4TzkjeKFktyZtHvKm6CetsogmQBXvRca0PS7wIjzDIX7tqHPWYmCjtHfXwfvzuPWcc8UFTc9ptbtRUbJQ=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 6BB903858D1E
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=Hv0tpc/0
Received: from localhost.localdomain by mta-snd-w09.mail.nifty.com
          with ESMTP
          id <20250228233453738.JZUF.33121.localhost.localdomain@nifty.com>;
          Sat, 1 Mar 2025 08:34:53 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Christian Franke <Christian.Franke@t-online.de>
Subject: [PATCH v3 3/3] Cygwin: signal: Fix a problem that process hangs on exit
Date: Sat,  1 Mar 2025 08:33:48 +0900
Message-ID: <20250228233406.950-4-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250228233406.950-1-takashi.yano@nifty.ne.jp>
References: <20250228233406.950-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1740785693;
 bh=t7ujjoiEoXmuI4cbpki+xa4hdQTNq7AhKntvgjmPrzs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Hv0tpc/0A85/YckVkIryjGwg5/2T/HUeo2yYiPTHd3LP5aKIJELrRWmSAkFgWRz6sJksKL8m
 hCAul3mUju+IFoUhsjPEbrhKn4gwuwh7xMAYNgca1xmMG5IL007DkLXn8tXbOHdmiP3BlclUDU
 /O3eCWb4dmPmOlcRCu1gCvJtP23JSP1S+t0zLsnGQAuByAWPPNmNQsjff9G3/H8Olclnzr8nBm
 h9bX7Ndz00UcOewkGJWx3qh48cgUZ+HZQgsT1hpsYZQvhoUIdvdjAZKZwnuCBeGGwDxh73e4RX
 +pUbkg7IeC+62c3pGeZQbj9RxC5LSzyoQGqhCpnHiLqQpmRg==
X-Spam-Status: No, score=-10.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

The process that receives many SIGSTOP/SIGCONT signals sometimes hangs
on exit in sig_dispatch_pending(). This patch skips processing signals
in call_signal_handler() when exit_state > ES_EXIT_STARTING to avoid
that situation.

Addresses: https://cygwin.com/pipermail/cygwin/2025-February/257473.html
Fixes: d243e51ef1d3 ("Cygwin: signal: Fix deadlock between main thread and sig thread")
Reported-by: Christian Franke <Christian.Franke@t-online.de>
Reviewed-by:
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/exceptions.cc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/winsup/cygwin/exceptions.cc b/winsup/cygwin/exceptions.cc
index 45c71cbdf..759f89dca 100644
--- a/winsup/cygwin/exceptions.cc
+++ b/winsup/cygwin/exceptions.cc
@@ -1675,7 +1675,7 @@ _cygtls::call_signal_handler ()
   while (1)
     {
       lock ();
-      if (!current_sig)
+      if (!current_sig || exit_state > ES_EXIT_STARTING)
 	{
 	  unlock ();
 	  break;
-- 
2.45.1

