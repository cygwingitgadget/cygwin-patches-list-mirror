Return-Path: <SRS0=A5WQ=G3=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w05.mail.nifty.com (mta-snd-w05.mail.nifty.com [106.153.227.37])
	by sourceware.org (Postfix) with ESMTPS id EF3774BB24C3
	for <cygwin-patches@cygwin.com>; Thu,  3 Sep 2026 23:38:23 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org EF3774BB24C3
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org EF3774BB24C3
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.227.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1788478706; cv=none;
	b=OcBbprYKdbaUUgIPsWWAeuqXOV8WbmWy7vIdfaOcr395hY5jELqr25nEVhs3/APn+SmUFiCXBAe+E/p03ZppqMJSvVfdLPXGmGJ8pRqftUIZGKQ7GicF1z+48e/y5NwmIuFX5nniy6JvOv5FRx9ZuTa1q8MoKN2f5Vy/ABUOk9k=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1788478706; c=relaxed/simple;
	bh=aKs6Q98vQPzJjrKSNHaikD2ZWEH2ilFgLs4rwCAwtKk=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=D4R+KKuNaawra4KDkKg5jFhegQ17j1kwW5y0oJaYubI71/5JMydARcRjwCkdoQuQllXHoXSbixYJIuRERJx61kN88WuId0qvi2vZTueu1d205Rz5f3rw0g2VQt9MoJUFW4BJdF8z+lyjffwmINpri+pj7nU+zd5K1X9U2Z0X6AU=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=V+fQW0kL
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org EF3774BB24C3
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=V+fQW0kL
Received: from HP-Z230 by mta-snd-w05.mail.nifty.com with ESMTP
          id <20260903233820956.HFOW.117312.HP-Z230@nifty.com>;
          Fri, 4 Sep 2026 08:38:20 +0900
Date: Fri, 4 Sep 2026 08:38:19 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: console patches
Message-Id: <20260904083819.ff0ff05bb39ac93ae6ed0086@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1788478701;
 bh=8oUr49RjZhgHP0UwLBr1z4ksU5Ext/EoRu6ZZ1bU94Y=;
 h=Date:From:To:Cc:Subject;
 b=V+fQW0kLY0kI5mXAeA9dgeQ33jSPM6KHBq2FDy5dKW/QqMszqAs3snHfSK9aWhJjyt2w4aaX
 /jq/bW1RyOndgnOFus5DQC2QqvplbJTGs60RcHKTpmSEWpa5BDJ3xSVVOD2vKj8AHCRo/GnQLO
 m+WVHNbcdazhmV8JVmArTJS4wSQlMlXU4CA1zMUYFNEqVazqBRYUVkkYFyeiNLDdBSdjgl+DEL
 u1DDetTovsbK82VehNUUIjX0H1cXCvRIkF/lLGSa55R1g1iUhI+YHLgf5/wZpdpU20W9dqBxif
 QGuGhK5pczUeVjsjeH3jJ1XOSy/wNPcow+oadZOILi5W0iCQ==
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Johannes,

I understand you’re busy, but could you please continue with the review?

[PATCH v14] Cygwin: console: Fix undesired mode change at exit of non-cygwin apps
[PATCH v2] Cygwin: console: Clear readahead buffer on tcflush()
[PATCH] Cygwin: console: Fix argument of process_input_message() in read()

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
