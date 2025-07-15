Return-Path: <SRS0=lWTj=Z4=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e04.mail.nifty.com (mta-snd-e04.mail.nifty.com [106.153.226.36])
	by sourceware.org (Postfix) with ESMTPS id 5FFEF3857C67
	for <cygwin-patches@cygwin.com>; Tue, 15 Jul 2025 07:27:45 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 5FFEF3857C67
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 5FFEF3857C67
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.36
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1752564467; cv=none;
	b=nb1PAchRyFxPgXbyYGiEtcGOssu6t95hOqDWE3zYTKargvoyNddN7ImnaM5fOaYDdqSUmn0d/hwcBu6Uz69IzdFpqigS7T1E4Maef5CXuO2PDu84rYDg1zWINLVso52rVxtDsAHI7tQLZcBcxndQNIR1KyqTJByilaGOD14wscA=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1752564467; c=relaxed/simple;
	bh=HoJLCBXWD99ZHAYLrX2oTMfjObyHefClF/IA+xmXSpc=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=h3ty89YeWXkG5PQg9UgwgwdyAGEWPBBeBCUqYav+RFEdFOvMoskW4WF604i/iKFBNUNdL4CFJOz7zAolDz2N/DnmOJnAHLlWAgFZBWOWYEXlugy+G6HAVEKXFPoXKU013YMEV8NMuZYxRQ9X188Z9VXez98p8CeRYIEsn24QIpE=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 5FFEF3857C67
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=tzP17Jzs
Received: from HP-Z230 by mta-snd-e04.mail.nifty.com with ESMTP
          id <20250715072743589.ZKDS.38814.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Tue, 15 Jul 2025 16:27:43 +0900
Date: Tue, 15 Jul 2025 16:27:41 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: console: Set ENABLE_PROCESSED_INPUT when
 disable_master_thread
Message-Id: <20250715162741.bd33f1249f088ba6947fbd32@nifty.ne.jp>
In-Reply-To: <5be83d7c-a19f-a733-7d8f-1d41daa6b9f8@gmx.de>
References: <20250701083742.1963-1-takashi.yano@nifty.ne.jp>
	<9a404679-40b5-1d55-db07-eb0dacf53dc7@gmx.de>
	<20250703154710.f7f35d0839a09f9141c63b1c@nifty.ne.jp>
	<259d8a20-46d5-c8cb-1efb-7d60d9391214@gmx.de>
	<20250703195336.2d5900b4988a6918ad397582@nifty.ne.jp>
	<5be83d7c-a19f-a733-7d8f-1d41daa6b9f8@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1752564463;
 bh=VzXlAcMy3AWnIuTHqyyd8WV94/VPYIMWRGAfHAXQTQo=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=tzP17Jzskf+AGFQIhfGg7IhIpy7yGmmrvtJkHka9t+IBe3bdI6A7E60ZbJiAoHH7DlTJcNyx
 T6YYF8g39if3fjdJfJfTgUoiL0Ouz0+Maus5Ll0xfnhAFLlFIIS7k+CVeXoepWarJ5f/IPKQhz
 aqKT6WRCzV728AhTyKi/wY4TWWwFSrACBXuX3NjV2ISb6e8UvXbwodJRXK6o34EvAUjzu6WfeZ
 +UmJHl48UgZrBj9hMQ/Sxv6FB/J721FKZTDVOQIFpP6ZxF638lgZklRHiEWI/Z4IkwPH1kQCxO
 zY9x7cHg4wBS0QUmtRLUoukiGO3yVrnSdnPFgQhPxb/JZ/ig==
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,POISEN_SPAM_PILL,POISEN_SPAM_PILL_1,POISEN_SPAM_PILL_3,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Mon, 7 Jul 2025 12:50:24 +0200 (CEST)
Johannes Schindelin wrote:
> Hi Takashi,
> 
> On Thu, 3 Jul 2025, Takashi Yano wrote:
> 
> > On Thu, 3 Jul 2025 11:15:44 +0200 (CEST)
> > Johannes Schindelin wrote:
> > > 
> > > On Thu, 3 Jul 2025, Takashi Yano wrote:
> > > 
> > > > I noticed this patch needs additional fix. Please apply also
> > > > https://cygwin.com/pipermail/cygwin-patches/2025q3/014053.html
> > > 
> > > Thank you for the update!
> > > 
> > > I am curious, though: Under what circumstances does this patch make a
> > > difference? I tried to deduce this from the diff and the commit
> > > message but was unable to figure it out.
> > 
> > In my environment, the command cat | /cygdrive/c/windows/system32/ping
> > -t localhost in Command Prompt cannt stop with single Ctrl-C. ping is
> > stopped, but cat remains without the sencond patch, IIRC.
> 
> I have added this as an (AutoHotKey-based) integration test to
> https://github.com/git-for-windows/msys2-runtime/pull/105 and was able to
> verify that your fix is necessary to let that test pass.
> 
> Speaking of tests: Have you had any time to consider how to accompany your
> fix by a regression test in `winsup/testsuite/`?
> 
> For several days, I tried to find a way to reproduce a way to reproduce
> the SSH hang using combinations of Cygwin programs and MINGW
> programs/Node.JS scripts and did not find any. FWIW I don't think that
> MINGW programs or Node.JS scripts would be allowed in the test suite,
> anyway, but I wanted to see whether I could replicate the conditions
> necessary for the hang without resorting to SSH and `git.exe` _at all_.
> 
> I deem it crucial to start including tests with your fixes that can be run
> automatically, and that catch regressions in the CI builds.

To be honest, I already have local test suites that check the behavior
of special keys for both pty and console. However, I currently have no
clear idea how to integrate them into winsup/testsuite...


-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
