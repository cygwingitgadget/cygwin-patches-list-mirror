Return-Path: <SRS0=3XPZ=UB=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [106.153.226.37])
	by sourceware.org (Postfix) with ESMTPS id 8BD603858C53
	for <cygwin-patches@cygwin.com>; Thu,  9 Jan 2025 01:58:31 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 8BD603858C53
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 8BD603858C53
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1736387913; cv=none;
	b=daVUb6MNZPmOMvZ73BCpXY0ZMHkUHq6bNaX6V0D7BGiSA6I3RwF3Ua7SCvK4Uf4jDwUTg6B/pmSCuSMOWvkotp3s+54SuTpIT8s9QglGmcaqVY7ehXT2k1WcwXcqryAcwMhLSEEL46wnwfKFEA4IqAYUf0ioB+MILcXz4XVcK5c=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1736387913; c=relaxed/simple;
	bh=ABa6w0RlOHonAz0oeqtTnrXDmhMdmFBsIyMT8fqou+c=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=JpypuSW8cCuMX6xKpC/f0Wrl+TqoY8KXu/J6hCEAcRvvuwyz+PMhjY2uTEsaEq3VceYzMpUCBMlmz9s6Ocl9rJnrZqWOhO0+o4xRzowp0d8iq/WH961npql8JWUcNw1nIliWYPTXBPAMAqM2p148j1b0mRZZp1dpP7jBQzpFtNM=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 8BD603858C53
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=TWEQPaJm
Received: from HP-Z230 by mta-snd-e05.mail.nifty.com with ESMTP
          id <20250109015829283.BXND.94949.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Thu, 9 Jan 2025 10:58:29 +0900
Date: Thu, 9 Jan 2025 10:58:27 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: signal: Do not handle signal when
 __SIGFLUSHFAST is sent
Message-Id: <20250109105827.5cef1a8c1b27b13ab73746eb@nifty.ne.jp>
In-Reply-To: <Z36eWXU8Q__9fUhr@calimero.vinschen.de>
References: <20241223013332.1269-1-takashi.yano@nifty.ne.jp>
	<Z36eWXU8Q__9fUhr@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1736387909;
 bh=TEJ//Fn3Ia8fapziOijOCBiUAWm4GNkLR9rW+Zw4Mf8=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=TWEQPaJmjPng1oYh4Ix5JbZ31LN4kN6l7lA0mZMAWmid9sTTZpGE1Yu3n+BbF7q2hA3lFGwU
 VjorFBshi2QB8O6x0WtU/uenqAtzLNtl8LJzLQOJpeNT4WCvRdSnbzuKFKbpwFo5gsG6Uxp4JZ
 kvbQT+bTWJBu6E5bbvGI80PtijTjXEaIAGSQwH4GHadAeqsahBMUW2eTDKJtyh9OHiDnmq9W8J
 Y0+gMG/Qduxamx2sPCX6zSp1tuDzmHOBeWuIX1UUqGkEu9lh7VbooqevCpt/kNDGFCP7T7EWMV
 g/evHlV16RRHEUCzjzC3PInrPIn5KFqCi/wHFiJai47wbmQQ==
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Wed, 8 Jan 2025 16:48:41 +0100
Corinna Vinschen wrote:
> On Dec 23 10:33, Takashi Yano wrote:
> > After the commit d243e51ef1d3, zsh sometimes hangs at startup. This
> > occurs because SIGCHLD, which should trigger sigsuspend(), is handled
> > in cygwait() that is used to wait for a wakeup event in sig_send(),
> > even when __SIGFLUSHFAST is sent. Despite __SIGFLUSHFAST being
> > required to return before handling the signal, this does not happen.
> > With this patch, if the signal currently being sent is __SIGFLUSHFAST,
> > do not handle the received signal and keep it asserted after the
> > cygwait() for the wakeup event.  Apply the same logic to the cygwait()
> > in the retrying loop for WriteFile() as well.
> 
> Does this patch fix Bruno's bash issue as well?

I'm not sure because it is not reproducible as he said.
I also could not reproduce that.

However, at least this fixes the issue that Jeremy encountered:
https://cygwin.com/pipermail/cygwin/2024-December/256977.html

But, even with this patch, Jeremy reported another hang issue
that also is not reproducible:
https://cygwin.com/pipermail/cygwin/2024-December/256987.html

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
