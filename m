Return-Path: <SRS0=R8AU=6X=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e02.mail.nifty.com (mta-snd-e02.mail.nifty.com [106.153.227.178])
	by sourceware.org (Postfix) with ESMTPS id C5C094BA2E1E
	for <cygwin-patches@cygwin.com>; Wed, 17 Dec 2025 09:47:30 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C5C094BA2E1E
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org C5C094BA2E1E
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.178
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1765964851; cv=none;
	b=ERzxV69hX17xiVWj7poLRpn0p0Aa2pb9m1fBqdIExdshwPd97qscNkIRB437N65GHQpysWFpWOZckbE2eiontbq79cQl6RkMZtskZ4PY3uzsNGZ2M/+IoJdt4082OHuSysd4Kea/Q74sIabuREHv4Z+67h4qljXz88HTttKydw0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1765964851; c=relaxed/simple;
	bh=+hRnWfyyr4a2ww3GWJTnpytvsr8t3WKTHdbvLioPZYY=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=liU5vAUU4u36CFwDYw7m2KxCDOPLQw6pihd+7+6lXxVJxdjT+1G1CTdwJLfrhhF5vEwVha0m23lorUCYoMHkOAHZVXNV00cxEAdn9/Ams23L8ERh+JhBJxOxXbO+tk+FAeO302PJfm6P6Cy9KJ8W4J2cMFx1CS90HrIz+bDlH1U=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C5C094BA2E1E
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=bphoIAbW
Received: from HP-Z230 by mta-snd-e02.mail.nifty.com with ESMTP
          id <20251217094729000.NKUM.120311.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Wed, 17 Dec 2025 18:47:29 +0900
Date: Wed, 17 Dec 2025 18:47:27 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/2] Cygwin: pty: Fix ESC sequence parsing in
 pty_master_fwd_thread
Message-Id: <20251217184727.b8da244be75cd237d7980d39@nifty.ne.jp>
In-Reply-To: <aUFM7SdTYNVAAeN6@calimero.vinschen.de>
References: <20251210015233.1368-1-takashi.yano@nifty.ne.jp>
	<20251210015233.1368-2-takashi.yano@nifty.ne.jp>
	<aUFM7SdTYNVAAeN6@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1765964849;
 bh=nEylcqKI+T3t8Rp+CQ0NgpBprQzQuTmq77/ztwn3FAc=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=bphoIAbWvS4AGCid19tlKbfsO09sxmmk55LqDYbeKQFsIDXCF1pSrfaRftA36Eja0/Z35Nwl
 e3pkeBbI8DVANZFYnLsbLtYMhXmbjNhr6PXyE8twiLYgjPlF8i1veYqAmSLc9xdGbojBzbLWTU
 6UM/4k0V/TA4Z8rdblBzHkPYraGd2U1PzihxlnIfUgXueEiPjguyl5A7XfJGrxyCeC4o7cyCT0
 AdedRJdqYByOzBSGXJKbcktjyEhCREqG8z1sT/GvO4ffpuXXx/KpV+IUUYAd34xRjMPmDE4y3C
 b41CfMKmceXh/QxhQSGULamcTcdzLai0pVQ3o1dpymElNhBQ==
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Tue, 16 Dec 2025 13:13:33 +0100
Corinna Vinschen wrote:
> On Dec 10 10:52, Takashi Yano wrote:
> > This patch fixes the bug in ESC sequence parser used when pseudo
> > console is enabled in pty_master_fwd_thread(). Previously, if
> > multiple ESC sequences exist in a fowarding chunk, the later one
> > might not be processed appropriately. In addition, the termination
> > ST was not supported, that is, only BEL was supported.
> 
> What's ST?  I only know STX, 0x02 in the C0 codeblock.  There's an ST in
> the C1 codeblock, 0x9c, "String Terminator", but I don't see this in the
> code, nor are the other C1 controls even recognized here.

As Brian replied, ST is ESC '\\'.
Both ST and BEL can be termination of set title ESC sequence.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
