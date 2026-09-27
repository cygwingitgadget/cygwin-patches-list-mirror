Return-Path: <SRS0=6sOE=HT=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e09.mail.nifty.com (mta-snd-e09.mail.nifty.com [106.153.227.185])
	by sourceware.org (Postfix) with ESMTPS id 2DACE4BA7988
	for <cygwin-patches@cygwin.com>; Sun, 27 Sep 2026 13:59:30 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 2DACE4BA7988
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 2DACE4BA7988
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.227.185
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1790517571; cv=none;
	b=QbjNbnvbw1B+XIDohWm3pCSLX/sjUCAc9EY4VtujzI2PG78xIt+9eeyh1ViNGMqrtJlJ/IvLKXKmDRpI0JFr/Yx6HtTwmSnVfI9fsJQoKBp14L03MVSQyYeF6XCOC2/qZX0BCEFScfaz6dutPVjt/5YYXY3+PqYghtvlsz9JHM4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1790517571; c=relaxed/simple;
	bh=YSWbvxPpLG/uTK1if73Qc05ZIW4unQ18Fw/EnLn2ya8=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=rNo50E+ThuCl4eNopMB+KHxX5WLINq6T+1e+50WNzpaI2y41lZNQdtpyePU8+b9FIoubtzWMELyagfV4KPUhtn5/pAwq6VS+mgdJ9S+OVPhZ24wCl2YfbgcA20w9O8DahQF18Pg3JFWm4gjIVNcHb4P+SoZZuIMwtpQLDVozguo=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=R4OHHpUh
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 2DACE4BA7988
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=R4OHHpUh
Received: from HP-Z230 by mta-snd-e09.mail.nifty.com with ESMTP
          id <20260927135929381.GIUW.60338.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Sun, 27 Sep 2026 22:59:29 +0900
Date: Sun, 27 Sep 2026 22:59:26 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v6] Cygwin: console: Improve the performance of
 peek_console
Message-Id: <20260927225926.f004f30c5d86c827a5a051e8@nifty.ne.jp>
In-Reply-To: <20260927224922.4e839303d240bc48ce084153@nifty.ne.jp>
References: <20260927132627.1002-1-takashi.yano@nifty.ne.jp>
	<20260927224922.4e839303d240bc48ce084153@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1790517569;
 bh=pDlPioJfUCib2+/CJX0agV0cusoJ+W3DODUX4553nII=;
 h=Date:From:To:Subject:In-Reply-To;
 b=R4OHHpUhohv80f57qI1Bbi3TeZAokeMRJq6bZfkPqmcOhQqTlhFP5ShwIVpSPA7R97F4+Vnx
 vhIL8X6BMRL1IEAjihT0E1+o5YvIRZXMM+lmPLJ4yP/eCYxyN4lTP2AqjILtOuUoxh09hwLAUp
 FJje5pgaV27rXbz6nwwCscBhnG+vhonHgaH9yDTQGSuCdC7zQIUbZmN9YCI0fSoXrCc17pOqS+
 ZnxA8XFm/yJzGMahIYHM2IW1bDspYsmzvFwCfBuacMJh52hZbsRT4BQwdIYfTogLM3znbt+DY9
 XL7t75f1SPkAZAcubI9bX/qqqk5sPTgbpuACv7RhKlQ6y43Q==
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Sun, 27 Sep 2026 22:49:22 +0900
Takashi Yano wrote:
> I've measured the performance.
> I measured the time it takes to paste 10,000 characters into bash.
> 
> Without this patch: 5.1 - 5.9 sec.
> With this patch: 3.9 - 4.3 sec.
> 
> It seems that this patch can reduce the overhead by about 20%.

In 3.6.10, the same attempt took 428 sec. (@_@;

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
