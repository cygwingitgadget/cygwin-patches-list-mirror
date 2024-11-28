Return-Path: <SRS0=Se+v=SX=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e06.mail.nifty.com (mta-snd-e06.mail.nifty.com [106.153.226.38])
	by sourceware.org (Postfix) with ESMTPS id 4BAEB3858D20
	for <cygwin-patches@cygwin.com>; Thu, 28 Nov 2024 11:23:54 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 4BAEB3858D20
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 4BAEB3858D20
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.38
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1732793035; cv=none;
	b=oumeqGQATBx7dDIDa0TBeDdHYeYKhinZq02Q2v0QYBcjGjJiXmxasHCWuTZ3jk+f+TemJpJZLCy5nYySl9nqMLd/D9IQ9JqGqZ+zB1ZBTnj0aj0P9SlMS8uMwRCmpuQEkYXL2HM4v2VpMIURuXySZRz6bzORk2idjNMUNxa82KQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1732793035; c=relaxed/simple;
	bh=izfEFIspacERJ69RtQ+dEbiHMVLufjZBiylRDtefWgA=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=MVJNjjOFzofwM2Dxn4JCbDZjuybqFJfgn0z6K/iAz874RnyW5Y+ezgHjCTcKm7OHd5lsUXsmwQ9cjvoY0QHPVMKRb/2tLNxwcTTjWbXl8y+T7LbAzQRL/+gPQoU1hAkgWMaGotXA0lWd1LpKtRP9DQpI8dXtAfYzPM3acB1NYSs=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 4BAEB3858D20
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=swUZH2fo
Received: from HP-Z230 by mta-snd-e06.mail.nifty.com with ESMTP
          id <20241128112351757.EUMH.102422.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Thu, 28 Nov 2024 20:23:51 +0900
Date: Thu, 28 Nov 2024 20:23:51 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 0/7] Fix issues when too many signals arrive rapidly
Message-Id: <20241128202351.541191b8c46c752fe68dbff7@nifty.ne.jp>
In-Reply-To: <Z0dRft_uZx0Us36k@calimero.vinschen.de>
References: <20241126085521.49604-1-takashi.yano@nifty.ne.jp>
	<Z0dQaXYCFSet-Zv7@calimero.vinschen.de>
	<Z0dRft_uZx0Us36k@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1732793031;
 bh=DkwKq18d+GYXhqIGdgzM10KovAy3KU42n97jCVyZtyQ=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=swUZH2foA3mO7KUtkaqsurUAHf6/agmdGZl7WKoZ3oJkzOgolM8sFXlaNJ7fsQLqj0+heTDO
 t0e6agAdLOmUVR2dMAWvy6GfnhKMXrSpQ4plAYjl8k9Be3ZWzBX9ulKfINpgcn3R4KS4ilWUhr
 BL5ji3gW0oDTHvfRJUY7IKPHS9JbwnI2pklmp/cIz1z6ejnO1V4Rifd6h0y8sMDXTOXTy5WvmB
 eioHuOY6RLVxw4l+rWVMR+D1Idqyawb7KYYTrmqEK7lUyLm1FwrUs8i3wEyPBXhuiUrFt4S5fO
 gnJTCNMwwJkKnZt1O7TIQziapc0bKxcDKe2j9iHXCpX1CBog==
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Wed, 27 Nov 2024 18:06:06 +0100
Corinna Vinschen wrote:
> On Nov 27 18:01, Corinna Vinschen wrote:
> > On Nov 26 17:54, Takashi Yano wrote:
> > > Takashi Yano (7):
> > >   Cygwin: signal: Fix deadlock between main thread and sig thread
> > >   Cygwin: signal: Handle queued signal without explicit __SIGFLUSH
> > >   Cygwin: signal: Cleanup signal queue after processing it
> > >   Cygwin: signal: Optimize the priority of the sig thread
> > >   Cygwin: signal: Drop unnecessary queue flush
> > >   Cygwin: cygtls: Prompt system to switch tasks explicitly in lock()
> > >   Cygwin: Document several fixes for signal handling in release note
> > 
> > For the time being, patches 1, 2 and 5 are already good to go.
> 
> Please push only to the main branch for now.  Let's cherry-pick
> them to 3.5 only when finished.

Thanks! Pushed to main branch.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
