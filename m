Return-Path: <SRS0=XNg2=6W=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [106.153.227.117])
	by sourceware.org (Postfix) with ESMTPS id D462E4BA2E07
	for <cygwin-patches@cygwin.com>; Tue, 16 Dec 2025 08:40:01 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D462E4BA2E07
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org D462E4BA2E07
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.117
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1765874402; cv=none;
	b=wITngmY+wAkJDtMdFWXIufzziUEGUEjqPF7U2fCdplLt/vQs65K+X2XGBXygDwXB3zGe7jwCehryvYmA2BaQ29lvmpjmJikAahJNHzT20Cks4jPEdwEZJtvKIZMgdjK0s1BRCtaTJmxxU9l1WvWHoAvQKeBN6O8H+R5wYQg/Q6A=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1765874402; c=relaxed/simple;
	bh=IfuPHwcZUlrK7QoLtQDbYImI1jhbx5/WEevbl1jpFzQ=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=LLAX6ZPcGD19HzGbacykCDp2nVvqa0yfxwceUNhwYdDPMqc8eXhPZIZTb87zqMD+KXVTwbnK3t9y5uCTzkh56HrT3fsE950LZxRGj3jxfWNNFvJnPXCtZx+G9yB7TBViqPVKw1Uc+uCah5eLPNDpcd52C/v/sqj6+Oc1gJQGWh4=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D462E4BA2E07
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=UK2tnuYu
Received: from HP-Z230 by mta-snd-e05.mail.nifty.com with ESMTP
          id <20251216083959659.WHON.50988.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Tue, 16 Dec 2025 17:39:59 +0900
Date: Tue, 16 Dec 2025 17:39:57 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 3/3] Cygwin: is_console_app(): handle app execution
 aliases
Message-Id: <20251216173957.fa9571466a8bced55924884f@nifty.ne.jp>
In-Reply-To: <f8d06570-7208-755b-e747-e8d7d174b32d@gmx.de>
References: <pull.5.cygwin.1765809440.gitgitgadget@gmail.com>
	<6ae42c5d17102a7805ed6539b9548df437df88a1.1765809440.git.gitgitgadget@gmail.com>
	<aUAoxVEKMpj6xNjM@calimero.vinschen.de>
	<18909F97-1145-4F61-9E23-4E4B9C97CF2E@gmx.de>
	<aUAxwTZcfZ9qecW2@calimero.vinschen.de>
	<f8d06570-7208-755b-e747-e8d7d174b32d@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1765874399;
 bh=fNuhaaBqWFRl/hoHbltHkUCJ9SOtIz/sCwgJC5ei+kk=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=UK2tnuYuBBMPplQSEyKR5Ukmmz7dlScv8LeBe0k829NZVHTGaUw+J0ToG1Yrsl6pCuzhJV/E
 dZQqW36TxMs4oI6ggjZBwYZzNklk/6URK8KQiCtkvueoIvImVolhcXtTkVXrzuGUPFhFl/6kYG
 fZPA1oAyiVkn1AkAQ+EnRX/+KPCEzUCcVDZ3c+sCbkIrmCEn2sSnqqSt9PJAOvj6w9mtQp9PHG
 efSW74LxNdAKm+cvL/rFqRsOD4npfe0ZvIKbSByy45OH3jRxyCPxJ2bxU8iPSHt+0R8OhAx8mI
 IcbsRLtLsT8g+aj+CV2rpcnQwmWGg4fq+Lq0oc8iEAns5t3w==
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Mon, 15 Dec 2025 18:15:10 +0100 (CET)
Johannes Schindelin wrote:
> Hi Corinna,
> 
> On Mon, 15 Dec 2025, Corinna Vinschen wrote:
> 
> > On Dec 15 16:40, Johannes Schindelin wrote:
> > > Hey Corinna,
> > > 
> > > [Sorry for top-posting]
> > 
> > /*rolling eyes*/
> 
> I wanted to reply quickly, which precluded me from using a mailer that
> allows inlined responses, sorry.
> 
> > > Also, it looks as if that other proposed patch will always add
> > > overhead, not only when the reparse point needs to be handled in a
> > > special way. Given that this code path imposes already quite a bit of
> > > overhead, overhead that delays execution noticeably and makes
> > > debugging less delightful than I'd like, I would much prefer to do it
> > > in the way that I proposed, where the extra time penalty is imposed
> > > _only_ in case the special handling is actually needed.
> > 
> > You may want to discuss this with Takashi.  Simplicity vs. Speed ;)
> 
> With that little rationale, the patch to always follow symlinks does not
> exactly look simple to me, but complex and requiring some
> head-scratching...

The overhead of path_conv with PC_SYM_FOLLOW is small, however,
it may be a waste of process time to call it always indeed.

However, IMHO, calling CreateFileW() twice is not what we want to do.
I've just submitted v2 patch. In v2 patch, use extra path_conv only
when the path is a symlink. Usually, simple symlink is already followed
in spawn.cc:
https://cygwin.com/git/?p=newlib-cygwin.git;a=blob;f=winsup/cygwin/spawn.cc;h=71add8755cabf4cc0113bf9f00924fddb8ddc5b7;hb=HEAD#l46

The code is simpler than your patch 3/3 and my previous patch
and intent of the code is clearer.

What do you think?

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
