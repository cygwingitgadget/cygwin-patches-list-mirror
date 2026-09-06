Return-Path: <SRS0=5WD9=G6=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [106.153.227.117])
	by sourceware.org (Postfix) with ESMTPS id D6C214BC7EF1
	for <cygwin-patches@cygwin.com>; Sun,  6 Sep 2026 23:45:03 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D6C214BC7EF1
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org D6C214BC7EF1
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.227.117
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1788738305; cv=none;
	b=sd+nLWmreoYHdfUbuw0jIyYjpI7a4yr/9y65OADJzQ4sHc1NxtLnsGw7X+qPl4kW1Sbm28bxjugyo7dI86fSE6kPXocmPXa4VTmHFDVU7xHMuohvOGsd1aaw+X9iSiuSOikXaaczURJibHViWsiM3i5JUE488KsXjQSHICWxArU=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1788738305; c=relaxed/simple;
	bh=23rSpS6pMWukQi7cD3Ul+ahU2VwlZfBxvuszYdml0fs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=kz8a67M1J2yseNqlIML5J8uv7JgpwLa1y4G9aC/4jr76rRx2SOljojF/ystG1cTPx8+OKmuwJ2dxs0kQ/qkixofxSPIBn8ZUliS69wMuLXKy7F7VykE/5JybC//rOgHl7Ac5MjgzS396Rvl3Y/EaiL/TDjTpoQe6uo3cok+O7I4=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=Q2cVdqGP
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D6C214BC7EF1
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=Q2cVdqGP
Received: from HP-Z230 by mta-snd-e05.mail.nifty.com with ESMTP
          id <20260906234500669.TBCI.102121.HP-Z230@nifty.com>;
          Mon, 7 Sep 2026 08:45:00 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: cygcheck: Fix unused-but-set-variable error
Date: Mon,  7 Sep 2026 08:44:43 +0900
Message-ID: <20260906234452.1593-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1788738300;
 bh=Mm6nJHiAyozrzW8KcyXFoeM2/UA6DN802L60g6ddfWg=;
 h=From:To:Cc:Subject:Date;
 b=Q2cVdqGPvxE3siMZg2jIe19mORF3iVVg7moaVzV6hvtqj8SaOH3yFMQQ9z1NNePDUTnTRIiX
 3u3NOEFsp6SGA8XabyuGnSNABBqC9zo5mOMp/oLdLSMoZmLMQaDUpSaZbrVPZ68C5PX72jiLkc
 XKo6THNGPLFFT1ECjds4leM8loMPTAIw4eQ5OPPjje0JUDOXxWqUptz9CHxNaJgZZGuCHBSByE
 zmahPo5BjyWUegh5BUAZNS30V0BTsLjZmaEQO3KrkQLOwiFxqEFKyTYVPsXLPQFrAAi0HcOvom
 4URdm2vWtKF09Kvai9VJV6cj68M+lyGMaMoQ21EMYxYJZwxw==
X-Spam-Status: No, score=-10.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Fixes: 1fd5e000ace5 ("import winsup-2000-02-17 snapshot");
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/utils/mingw/cygcheck.cc | 2 --
 1 file changed, 2 deletions(-)

diff --git a/winsup/utils/mingw/cygcheck.cc b/winsup/utils/mingw/cygcheck.cc
index 89a08e560..934816939 100644
--- a/winsup/utils/mingw/cygcheck.cc
+++ b/winsup/utils/mingw/cygcheck.cc
@@ -1707,7 +1707,6 @@ dump_sysinfo ()
   else
     {
       char sep = strchr (s, ';') ? ';' : ':';
-      int count_path_items = 0;
       while (1)
 	{
 	  for (e = s; *e && *e != sep; e++);
@@ -1715,7 +1714,6 @@ dump_sysinfo ()
 	    printf ("\t%.*s\n", (int) (e - s), s);
 	  else
 	    puts ("\t.");
-	  count_path_items++;
 	  if (!*e)
 	    break;
 	  s = e + 1;
-- 
2.51.0

