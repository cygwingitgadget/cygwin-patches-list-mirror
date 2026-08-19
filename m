Return-Path: <SRS0=SG5m=GM=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e09.mail.nifty.com (mta-snd-e09.mail.nifty.com [IPv6:2001:268:fa04:731:6a:99:e2:29])
	by sourceware.org (Postfix) with ESMTPS id C23444BA2E1A
	for <cygwin-patches@cygwin.com>; Wed, 19 Aug 2026 06:44:14 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C23444BA2E1A
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org C23444BA2E1A
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2001:268:fa04:731:6a:99:e2:29
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1787121855; cv=none;
	b=G7H90k300nhhxKfAW3SThy6yaxf19LUFM3MuYfPorocOxxKyziEAh7CovnNUutdVGB9i80luZNDyHWLrv7Zug9P+GNyFw6UhK40L5HdeD9r7OFLxVJ2GUpDj88SzzxD+4C2sNBjuXQndJjaCE5mbcOyhJjDrvgm54zh1KotMVFU=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1787121855; c=relaxed/simple;
	bh=NUJHxOTiObsq32TDQ9QmtFrIg8YHv6SaJ0HIKpPOSJc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=Y5RF+yBxP0/11B7VfFAmGQ7BuZ+vPKJZQA7+ym5F/HHS6m82tkX9y25eMfpp0KEMsnumbezh8LMNe6pVpMGm2rozIwWeJdHkHR2VlqXJ/Dzt6htUxKMmwTJy70ApDCAKKQPOsBQ1yAiZII90vctLtCpuqUYXeCP2ikZGZL6xggE=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=VIrZWJ7C
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C23444BA2E1A
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=VIrZWJ7C
Received: from HP-Z230 by mta-snd-e09.mail.nifty.com with ESMTP
          id <20260819064412866.SRTW.60338.HP-Z230@nifty.com>;
          Wed, 19 Aug 2026 15:44:12 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: console: Fix argument of process_input_message() in read()
Date: Wed, 19 Aug 2026 15:43:56 +0900
Message-ID: <20260819064404.128384-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1787121852;
 bh=Ntc1SM3A5cz+Y0Ptn0v2qieYo1aDnhKElfxI86Q03og=;
 h=From:To:Cc:Subject:Date;
 b=VIrZWJ7Cj5/qemXgp5LuZKdDPIdI4jY5Cuz8ECUXLLFTV75ozHpXXjrPr8j6FnVbLJ3CBp1O
 5lKQqPx49t3ikeQOEgZ2TYU5XjfOJsEOYBramFz1ByvOipBFGeDbU1YLvGcR/2NiLbi8tOPiwG
 4qqbL4ae3wys/Fyxjr48s7B9qTRDXPiJkAAimzzE2HOHEvpvSXovJqgSiekQgaCfmG5ujZNSwE
 WZorZodvpwa0ORudqc/m/RaEP5tnr5qH/J1yIhjsxqF/i0A1+gSjIKjyT43M2CATQ74KRL904E
 q0RPIH1gvUF5IemuxrWFm0r0qeGW+CeCqesntB+Axx5WQpKA==
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

The commit fac73911f5a0 ("Cygwin: console: Fix typeahead input for
bash") introduced an argument to process_input_message() to restict
the maximum length to be processed by this function. However, the
commit failed to account for the number of chars already copied into
the buffer.  This patch corrects the argument to process_input_message()
to address this issue.

Fixes: fac73911f5a0 ("Cygwin: console: Fix typeahead input for bash")
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by:
---
 winsup/cygwin/fhandler/console.cc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
index e349afe9c..f04cb1b48 100644
--- a/winsup/cygwin/fhandler/console.cc
+++ b/winsup/cygwin/fhandler/console.cc
@@ -1367,7 +1367,7 @@ wait_retry:
 
       int ret;
       acquire_input_mutex (mutex_timeout);
-      ret = process_input_message (buflen);
+      ret = process_input_message (buflen - copied_chars);
       switch (ret)
 	{
 	case input_error:
-- 
2.51.0

