Return-Path: <SRS0=q3sT=CF=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w07.mail.nifty.com (mta-snd-w07.mail.nifty.com [106.153.227.39])
	by sourceware.org (Postfix) with ESMTPS id 65C134BA23E1
	for <cygwin-patches@cygwin.com>; Mon,  6 Apr 2026 12:19:25 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 65C134BA23E1
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 65C134BA23E1
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.39
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1775477966; cv=none;
	b=gc4XpnQxBC7D7Qq/1H5QjgJt92B7RQYFoMctwIQgSXJ6Xr+KTLTcqMXIDqib4Vi1itEow/AfPRO891WTZEehtr4wsyZctCYVLIZj5fFpqonXCsM4yjOnKYFmqfaBpKBinxtD+fpRb3r/Y4O1o3HweOvZXC6GiHxaGC/tO+OgZ8Y=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1775477966; c=relaxed/simple;
	bh=FPnTy1CiQE2+h8KXq6ImF1XgC26FCXZgTfg1vKoKJ7Q=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=BOmnhiXByysYmOsdlpEkZMm6+RWNAZSPYskLP1vrVfzVbZ0RBEMEm+2Q2/DCXF+4+5gLM+KGjsVxfn8USmZ79V46f+PxgiYaC6KzhwRQI+NDHehSsJ5F8dpRM4O5rZ/FA3Od5Kb6cf6xvLBHjxvjnBMHupX5VK2HUNW+HVLdu1k=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 65C134BA23E1
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=P+BaKqxo
Received: from HP-Z230 by mta-snd-w07.mail.nifty.com with ESMTP
          id <20260406121923112.QCZI.19957.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Mon, 6 Apr 2026 21:19:23 +0900
Date: Mon, 6 Apr 2026 21:19:21 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Fix write data handling in pcon_start
 phase
Message-Id: <20260406211921.5611f6a949819077fc5c6286@nifty.ne.jp>
In-Reply-To: <d1cd3f72-1c1a-6b43-c6a2-f442a5ac447e@gmx.de>
References: <20260325130842.67319-1-takashi.yano@nifty.ne.jp>
	<d1cd3f72-1c1a-6b43-c6a2-f442a5ac447e@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1775477963;
 bh=R1LxapVHCbWLqiJ2I/6IxqTXDYQjYSQ3N2y5RAW7XW0=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=P+BaKqxoq4ZEomHUqSdCP1IIPxOIYaeo4rw7IUuFxZFwWoMhzenRE/wojUJ6itbo7ntqqrJE
 MxVAEvhOiK/FaB+AFul4RteWVgeZks38kvaQpqY2j9VUsrzh7H/5OJuYP3i9ruBTGPltyZwalm
 5KBfrcaqdx7v4UG4jiI6GJ4DKvc+gMrqso5z1SKTvt3u5N9h9ClFtShoWmKsPkFUCsSGOQNdYc
 cSG1f0Pdq+cmIhNaxzpFEtyseCZYrkaRKV4AjDtf+a1c5nP5Fm1TKfVa20+Bi3sIdGnoGjBeft
 Bpkv5NuAD24hs50VH2rtsa5mtepUvjt5VNe42mzXGTvRZMcA==
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Johannes,

Thanks for reviewing.

On Mon, 6 Apr 2026 10:14:35 +0200 (CEST)
Johannes Schindelin wrote:
> Hi Takashi,
> 
> On Mon, 6 Apr 2026, Takashi Yano wrote:
> 
> > If the 'for' loop in pcon_start handling in master write() does not
> > break, 'ptr' and 'len' loose the chance to fixup the value. In this
> > case, all data in 'ptr' are processed, so the 'len' should be 0.
> > 1 byte is consistently consumed in each iteration in the 'for' loop,
> > so this patch fixups 'ptr' and 'len' in every iterations instead of
> > fixing-up at break.
> 
> This commit message explains the problem well, and the fix looks good to
> me.

Pushed.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
