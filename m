Return-Path: <SRS0=EpSC=SV=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w09.mail.nifty.com (mta-snd-w09.mail.nifty.com [106.153.227.41])
	by sourceware.org (Postfix) with ESMTPS id F28D33857BB3
	for <cygwin-patches@cygwin.com>; Tue, 26 Nov 2024 08:56:19 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org F28D33857BB3
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org F28D33857BB3
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.41
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1732611380; cv=none;
	b=gOc71ndXBcMAsENr59O/U8AFEEmldxMzoJHRWYlGqyApMBXquOMb4sfV0uMcarCSQoDMF15mqYpY9hFjHLfW8uKJrO2ZE5gNRUEfk0MnQyJNlcixiMhCm2NjjrJqZ8dJcnLEnw62402JA7f2uz9rthTtmEeUKmKUEwYP1WTUj7U=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1732611380; c=relaxed/simple;
	bh=TOZOJGkOvZ/N1eeF5zUYQium5uYuLaYqa7cM4iqmiqs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=DEnVHnuCS8YJPIpAd1J/a/yowR0uZFXFlNmCKsWQwNlm1NiD9rzwNfxsJRwqYvUpqoLQWRQtYuELDDEy4gwAMaKy87+VTMS8cqfPtBH0vN8zfbjKiXYlt3uXBiQ92jinRITK10zOw2NJjPgYmZYY9fTFEVgpx2wcwzrV2ju3omo=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org F28D33857BB3
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=NgyDMrtP
Received: from localhost.localdomain by mta-snd-w09.mail.nifty.com
          with ESMTP
          id <20241126085618366.NQWA.90249.localhost.localdomain@nifty.com>;
          Tue, 26 Nov 2024 17:56:18 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Christian Franke <Christian.Franke@t-online.de>
Subject: [PATCH v2 3/7] Cygwin: signal: Cleanup signal queue after processing it
Date: Tue, 26 Nov 2024 17:55:00 +0900
Message-ID: <20241126085521.49604-4-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20241126085521.49604-1-takashi.yano@nifty.ne.jp>
References: <20241126085521.49604-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1732611378;
 bh=SXFTIUrgS9iktnyUtAlifFSgHaQQsoeXZs4/DYove+Q=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=NgyDMrtPZTyRrfz5xFcKRt1cisRc/Md47je6g2skIzTVMo++q69xYtX+Hqldm0eUT1/52aGU
 YmLlBOYjf7dz9Dg2Q3WA1Hj4Y61araSJ36h32y6Ks2M5HD6sItT7AK9jdUEVocclm2f5RjPStu
 1Y6VqW72PJzOWSO3dIqu4B+kh9czK7hEy6HSeVZn2Mdqb72gcbOaHj79mfMI91taxJD85kYbVU
 e2geF7va/lvaHhtANZJ/mKvrdGu5pnVgKRYaaGZY2W02qMVYxFt2xZP05sisMz5CoUXQmRx8Qs
 GKVPIYBJB3qJzQ/fMTbdE4a8WWYVOhiiNAfC+TwhwD3ibDSg==
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

The queue is once cleaned up, however, sigpacket::process() may set
si_signo in the queue to 0 by calling sig_clear(). This patch adds
another loop for cleanup after calling sigpacket::process().

Addresses: https://cygwin.com/pipermail/cygwin/2024-November/256744.html
Fixes: 9d2155089e87 ("(wait_sig): Define variable q to be the start of the signal queue.  Just iterate through sigq queue, deleting processed or zeroed signals")
Reported-by: Christian Franke <Christian.Franke@t-online.de>
Reviewed-by:
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/sigproc.cc | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/winsup/cygwin/sigproc.cc b/winsup/cygwin/sigproc.cc
index 8f46a80ab..b8d961a07 100644
--- a/winsup/cygwin/sigproc.cc
+++ b/winsup/cygwin/sigproc.cc
@@ -1463,6 +1463,17 @@ wait_sig (VOID *)
 		      qnext->si.si_signo = 0;
 		    }
 		}
+	      /* Cleanup sigq chain. Remove entries having si_signo == 0.
+		 There were once cleaned obeve, however sigpacket::process()
+		 may set si_signo to 0 using sig_clear(). */
+	      q = &sigq.start;
+	      while ((qnext = q->next))
+		{
+		  if (qnext->si.si_signo)
+		    q = qnext;
+		  else
+		    q->next = qnext->next;
+		}
 	      /* At least one signal still queued?  The event is used in select
 		 only, and only to decide if WFMO should wake up in case a
 		 signalfd is waiting via select/poll for being ready to read a
-- 
2.45.1

