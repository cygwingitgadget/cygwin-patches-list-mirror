Return-Path: <SRS0=7Ga2=FM=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e07.mail.nifty.com (mta-snd-e07.mail.nifty.com [106.153.226.39])
	by sourceware.org (Postfix) with ESMTPS id 979EF4BA2E1B
	for <cygwin-patches@cygwin.com>; Sat, 18 Jul 2026 14:47:58 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 979EF4BA2E1B
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 979EF4BA2E1B
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.226.39
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1784386080; cv=none;
	b=aCgBA3IejyhY3alqx1CEgRYW6b/BmiVbc4C6QG+l7p+sHzpj/nZF5k41QsfMJSKnbSonK1TTVArS6x9QHBdKST1o1KQW8sL99AOkWWgx2zM7Nyn4ClJEPjb2IEqqG0k5oeY1U7STbCSGi3RDzY3/RXH3bx1njfXkLr8vQC00Lsk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1784386080; c=relaxed/simple;
	bh=lb0XidPgPpHhVQ9XmKKBBLqQwBUkKv61uELWuDd7FPo=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=sUuekBDfP81yUFTrFBaEV74ZrXh+7iBLZ6eP/lTUo4tqHZivzRDFO/C/P9iYjyJS9ZyAjUH+znSLZSXeag7b0mkeBY8H1bajbOuhnIPAyhr+Pg80ozc883UjQEkOBCncd9FGpTguBCnupvOKnkL4bxGno2kvtdYuhrU67yJGHcs=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=ZhNK2PmC
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 979EF4BA2E1B
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=ZhNK2PmC
Received: from HP-Z230 by mta-snd-e07.mail.nifty.com with ESMTP
          id <20260718144755451.ETVG.17441.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Sat, 18 Jul 2026 23:47:55 +0900
Date: Sat, 18 Jul 2026 23:47:53 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v5] Cygwin: console: Fix undesired mode change at exit
 of non-cygwin apps
Message-Id: <20260718234753.7e3eab991f078479b74f5899@nifty.ne.jp>
In-Reply-To: <20260718131226.1350-1-takashi.yano@nifty.ne.jp>
References: <20260718131226.1350-1-takashi.yano@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1784386075;
 bh=yoKGiZTR14qpsuiHE3AY6+iAuNbKz/Vj+3pAe8fJRuI=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=ZhNK2PmC3OTSmTLkSXalDFllvJNd0CbEQUJ85CvZ/1m1AfJbyVaAwGKVxZGZvols0HQU7Wni
 IDk6e5j77Dh61jAUXPOek8sDRyhcXf0NVKofDluMSSBXAuKX00xYUxWjKzMsjh2tVIeX/shefW
 xOarM4zDlRLGD0U5/xKTO6KDjnwK/LQAO+y1Rw56g1DRGv1F0twSTfSGtnFTpaPU2Dz4yypePI
 OT1Ry+XKSXSVpF64793x/8dc2Vsm4Bpl57bFA9ORUi+PsU21sixpHzl91HtcsQOQvrEd2KiCgY
 j4WTG7QjhVjDXOm0WF78ELySL/IQzwl0iTdvvHpVZk6ei9kA==
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>


Sorry, v5 has serious bug. Please wait for v6.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
