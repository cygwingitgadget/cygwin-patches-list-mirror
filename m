Return-Path: <SRS0=EpSC=SV=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w09.mail.nifty.com (mta-snd-w09.mail.nifty.com [106.153.227.41])
	by sourceware.org (Postfix) with ESMTPS id 757F43857704
	for <cygwin-patches@cygwin.com>; Tue, 26 Nov 2024 08:57:01 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 757F43857704
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 757F43857704
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.41
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1732611422; cv=none;
	b=qDH/eG9GoL5kKIpPnBxldEMX0zVO5yjyRyT+khPBHimR6k1KjDX//ZQCy1n8wA9DYCtp4KJeKl/5i411zy+d90sMF3r3+NbgNDuq+b6bFz/VzhA0zRuSNUhI38uOOQ0imtXisTcn34SlG/06/srKWKn0V3Vrd0hc/XWsfyxKTVg=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1732611422; c=relaxed/simple;
	bh=DhW1/Ik2rrOgZPPJ4W/GQSymxh/6IVClOTp8fbAlmGQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=Y16RwIPk75fq4bIf/Hnev32vuSHjPM3vynveEKqNn5t9Pq89m4YQkhlJNwjT699uoczfqUgNIkwfeic7zbZWCkeCvNLLZiE9DDLDGyH1eyj71/yAAu1Y/m+sI+fuYZxoixfsq0uMwJlmauPcWdRY7cXUpGfNvEMsdpLmufE1ZXc=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 757F43857704
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=CJuVpWI0
Received: from localhost.localdomain by mta-snd-w09.mail.nifty.com
          with ESMTP
          id <20241126085659776.NQXB.90249.localhost.localdomain@nifty.com>;
          Tue, 26 Nov 2024 17:56:59 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v2 7/7] Cygwin: Document several fixes for signal handling in release note
Date: Tue, 26 Nov 2024 17:55:04 +0900
Message-ID: <20241126085521.49604-8-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20241126085521.49604-1-takashi.yano@nifty.ne.jp>
References: <20241126085521.49604-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1732611419;
 bh=oxqKhuJxyZ0yiJq6mc8veGlyoDVnDjxkUfFGfTJXnk4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=CJuVpWI0U6ehRNw5ovyebZGoo0BdJbhNQraHrKbY4AY1pzsxrhAVqQGBNj9AE+lUXvJBVEuQ
 sCLlnJYFYvym5VYBqDns0jnt6TBRVbsDOcMOECvd88HBVYnn2bnnloYqMLgYVL81ohJs8CNFY7
 SBTZnD+WGzDA9ZfeodNLyw+fqaiLP7FoADPafOkgPhKF7F3lvyJ/nXLtCqGNdnWqMMAXIzIAod
 IESbfZQblwM1omW/ZakIecaKUfTSFFP2Tsh6MMh3eijPzHBM+eKDLHUaFp8Nflvj9rCn6ppGjN
 HJBEXYD9oxQ6Y8ML4BebsIaDXyiBXxFv+VKzkHQNtowk26sw==
X-Spam-Status: No, score=-10.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

---
 winsup/cygwin/release/3.5.5 | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/winsup/cygwin/release/3.5.5 b/winsup/cygwin/release/3.5.5
index d91f2b92c..e7c0decbf 100644
--- a/winsup/cygwin/release/3.5.5
+++ b/winsup/cygwin/release/3.5.5
@@ -45,3 +45,7 @@ Fixes:
 
 - Fix segfault in sigtimedwait() when using timeout.
   Addresses: https://cygwin.com/pipermail/cygwin/2024-November/256762.html
+
+- Fix several problems triggered when a lot of SIGSTOP/SIGCONT signals
+  are received rapidly.
+  Addresses: https://cygwin.com/pipermail/cygwin/2024-November/256744.html
-- 
2.45.1

