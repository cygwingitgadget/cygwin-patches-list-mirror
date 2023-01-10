Return-Path: <SRS0=J7QP=5H=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com [210.131.2.80])
	by sourceware.org (Postfix) with ESMTPS id 0E7D03858C52
	for <cygwin-patches@cygwin.com>; Tue, 10 Jan 2023 09:53:13 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 0E7D03858C52
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from HP-Z230 (aj135041.dynamic.ppp.asahi-net.or.jp [220.150.135.41]) (authenticated)
	by conssluserg-01.nifty.com with ESMTP id 30A9qvte010612
	for <cygwin-patches@cygwin.com>; Tue, 10 Jan 2023 18:52:57 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 30A9qvte010612
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
	s=dec2015msa; t=1673344377;
	bh=tFaVr1sYY9zDegdpjzQOI1xtmgR+uTEkgQ7XLSOzUV4=;
	h=Date:From:To:Subject:In-Reply-To:References:From;
	b=ZqnhTp946/eviWIHxI/TOaz2pZtdpCPxodzE6nTmiJ/BKhx6vDe2qUBPgFgvlvNVB
	 Fz+rts3aLVUMmn/Ns7N/ldPJBfJ0fYsTPNpj3RnP1R7GAWBIJS0gUioXjrtcCHpfeB
	 5NCWQ47fXYSFrFmUbzmVbAq2FptRKn0JKVWhN97yZUxlf2ACkE5HOgcvqJXJskff7g
	 kZrzr+JgE6NQegWGdIHvM8HkFAU8uQqS3Vtdw1dBWe6pmCQ2MpXi/6UPVd0ygz1P2H
	 L19B2vhCPEXBtcfT7M8tYpUZiZ/oXFYSgs36WWW2V3Pm3TlP0FDPIfTyHIpQkFkpBs
	 ozLy2ONXwdrzQ==
X-Nifty-SrcIP: [220.150.135.41]
Date: Tue, 10 Jan 2023 18:52:57 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pinfo: Additional fix for CTTY behavior.
Message-Id: <20230110185257.8f316240e5d9f2d2fb78f21a@nifty.ne.jp>
In-Reply-To: <Y7vdjTREYWiLAJ9N@calimero.vinschen.de>
References: <20221228083516.1226-1-takashi.yano@nifty.ne.jp>
	<Y7vdjTREYWiLAJ9N@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Mon, 9 Jan 2023 10:25:33 +0100
Corinna Vinschen wrote:
> On Dec 28 17:35, Takashi Yano wrote:
> > The commit 25c4ad6ea52f did not fix the CTTY behavior enough. For
> > example, in the following test case, TTY will be associated as
> > a CTTY on the second open() call even though the TTY is already
> > CTTY of another session. This patch fixes the issue.
> 
> The patch is ok, thanks.
> 
> But while looking into this patch, I realized how confusing the old code
> is.  An unsuspecting reader will have a really hard time to figure out
> what ctty values of -1 or -2 actually mean.  The CVS log entry from 2012
> isn't enlightening either:
> 
>   On second thought, in the spirit of keeping things kludgy, set ctty to
>   -2 here as a special flag ...
> 
> Would you mind to introduce speaking symbolic values for them and add
> some comments to make them more transparent?

Ok. Do you mean, first push this CTTY patch, then,
add comment for ctty values -1 and -2 in another patch?

> Also, given this was a "kludge" from 10 years ago, is it really still
> needed?
> 
> As I said, it's confusing :}

Currently, the special values mean:
-1: CTTY is not initialized yet. Can associate with the TTY
    which is associated with the own session.
-2: CTTY has been released by setsid(). Can associate with
    a new TTY as CTTY, but cannot associate with the TTYs
    already associated with other sessions.

So, I think the two different values are necessary. 

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
