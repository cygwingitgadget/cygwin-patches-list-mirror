Return-Path: <SRS0=zg0B=NA=clisp.org=bruno@sourceware.org>
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.23])
	by sourceware.org (Postfix) with ESMTPS id 1472C385E827
	for <cygwin-patches@cygwin.com>; Wed, 29 May 2024 11:17:56 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 1472C385E827
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=clisp.org
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=clisp.org
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 1472C385E827
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=85.215.255.23
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1716981478; cv=pass;
	b=TWRFGgphQy6kN/XoabBBJbRvGspvF6wqJk1OdxdQPEKtjxnnv5teZXDiObSsRd+JOccVA0mtxBmfo9/UHlyErGKrZhciG+JHT5vjeQcrQhtXXstCLvsuUlQaMk9/zhOWxukKAQctQM5jsw/LnF7UuNIqYQAI27vAbzwk2bPaHqc=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1716981478; c=relaxed/simple;
	bh=+V30XFBqYi2ka99ItEU9D4nf89vildGnizVAriFzQ0M=;
	h=DKIM-Signature:DKIM-Signature:From:To:Subject:Date:Message-ID:
	 MIME-Version; b=Xa5sReJeUQtc3rueoryM2jodQzDpyszySt2R2yPso9lC8W+jj4XKMGPlaC1+Ep4cI4E+bcQaMHAF5fE/xZqsxiukYyKlpEpwPaw8nlfhmj7/NWJvnJirhRQPpSKnWJNN/4ZbxHRzZbZsdj6wcqP1KZo7G02XdYK2wugXOwyM1EU=
ARC-Authentication-Results: i=2; server2.sourceware.org
ARC-Seal: i=1; a=rsa-sha256; t=1716981468; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=XwyPE6wl6AQwfPDXkjcWLXhSnaklLOY1v4/ACgwJ8ipkuBTPZ/5eNaD1MaBeGrjDad
    eyi6F1qniFDWsAecDFiwQG4FYwdGlapQRiI2PfGR6OKLoJoguMMnE/Rez7IwB6kIeHfr
    ZOsaKROv3P6S1oGl3JbDhEWcJ3ydxVIia5/TYDvA2eCkCf9dND7pf9S/KSQDPM/k/8Df
    03nAnliVD9p8kdmnJhFW1FC9mMGjPDntelWfiP1t64/cKcrN6/phQU9vTrAnT79vNcOw
    tHyWU44NbpO47lE9AJdOJRcTKReNn17CrZk/RaM1UaN1ExbryA8iiRA0tV+XureU/nnI
    sIYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1716981468;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:To:From:Cc:Date:From:
    Subject:Sender;
    bh=E4L5DYfHjlgZddW6OSA0VWD21LcC5VQhcpMmmeGMSvc=;
    b=tKuHrydij1O36v4Y4vOQn9KaMdre4sH9H1RE1pB5xbk69Z0FU2N6Hr+FmDhabFOFew
    cKn/x1Im3EXIuL+4oUbBSpy2P+R1aw8hCJJlzZxMBUllf3+mLPIugaDoYF6wUChbp949
    YQuSmXicU8BvjdlvScnVtJYqkUPxUSerw3haa82IrYruP+q41JFnqy4fR4//7OIxr1G6
    OZlGUrGZoMFQTM3mBZBWBxZXoXMmRUXQACYJcEO+A4PevspOrIlM9/RQElB/v6TLDMXb
    Vhb0ceSlu7YXTETyNA1cpwPgvg++z/XxUJcP3EcHZSN4QcUBtJ+q2Dp1ME07PZyf20dB
    OWHw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1716981468;
    s=strato-dkim-0002; d=clisp.org;
    h=References:In-Reply-To:Message-ID:Date:Subject:To:From:Cc:Date:From:
    Subject:Sender;
    bh=E4L5DYfHjlgZddW6OSA0VWD21LcC5VQhcpMmmeGMSvc=;
    b=ddKhN+sUGbo0qFpkxQW9EOYRGexJ/rVbU/x+DzzseUVcHDeZF4neZJiStbtyW38rQz
    jQAsBGnOtjPG/GZaGvZpbXd6VotfJT2rZQsEhGa+OEOmlFtV11O2xhUmF8xho6UK/2Ht
    8zuUD7eRGw/TDjvhrqUTG1SHKCPL4hXXqQYSh74zSQ3D49hwIohPqK2fyC/gJvipouWJ
    PHi1wjfek2AlhiaCN0iMXm2KYOTSUnJa15t5Y5faDsx03th/45+UxMVZNGaxnTsD2/z5
    UC58U9fD6lNrwPTy17uMUpPnPV5HAPNXCQ5P3oC/aRxgujRTWFPUpusoNMJlamNilEKg
    tWsg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1716981468;
    s=strato-dkim-0003; d=clisp.org;
    h=References:In-Reply-To:Message-ID:Date:Subject:To:From:Cc:Date:From:
    Subject:Sender;
    bh=E4L5DYfHjlgZddW6OSA0VWD21LcC5VQhcpMmmeGMSvc=;
    b=zh+EgLb5e+Suuk9Nh8f0xUDVN6DMyHJA77TyP501IWA7LotTFYlRJnbQTYozdWw3J4
    x4mtD5UpiMi7YWp82bBg==
X-RZG-AUTH: ":Ln4Re0+Ic/6oZXR1YgKryK8brlshOcZlIWs+iCP5vnk6shH0WWb0LN8XZoH94zq68+3cfpPAiqFt2JhGvFnRN6BsfqrAeOb8"
Received: from nimes.localnet
    by smtp.strato.de (RZmta 50.5.0 AUTH)
    with ESMTPSA id Ndd2ca04TBHmWgA
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 29 May 2024 13:17:48 +0200 (CEST)
From: Bruno Haible <bruno@clisp.org>
To: cygwin-patches@cygwin.com, Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: Re: [PATCH] Cygwin: pthread: Fix a race issue introduced by the commit 2c5433e5da82
Date: Wed, 29 May 2024 13:17:47 +0200
Message-ID: <3767625.UuxTggG6dJ@nimes>
In-Reply-To: <20240529103020.53514-1-takashi.yano@nifty.ne.jp>
References: <20240529103020.53514-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,KAM_NUMSUBJECT,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,TXREP,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Takashi Yano wrote:
> To avoid race issues, pthread::once() uses pthread_mutex. This caused
> the handle leak which was fixed by the commit 2c5433e5da82. However,
> this fix introduced another race issue, i.e., the mutex may be used
> after it is destroyed. With this patch, do not use pthread_mutex in
> pthread::once() to avoid both issues. Instead, InterlockedExchage()
> is used.

This patch is bogus as well, because it allows one thread to return
from a pthread_once call while the other thread is currently
executing the init_routine and not yet done with it.

> +  if (!InterlockedExchange (&once_control->state, 1))
> +    init_routine ();
>    return 0;
>  }

There is no code after the init_routine () call here. This means
that other threads are not notified when the init_routine () call
is complete. Therefore this implementation *cannot* be correct.

See: Assume thread1 and thread2 call pthread_once on the same
once_control.

            thread1                      thread2
            -------                      -------

         enters pthread_once       enters pthread_once

         sets state to 1

                                   sees that state == 1

                                   returns from pthread_once

                                   executes code that assumes
                                   init_routine has completed

         starts executing
         init_routine

         finished executing
         init_routine

         returns from pthread_once

Bruno



