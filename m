Return-Path: <SRS0=Aef5=D2=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w05.mail.nifty.com (mta-snd-w05.mail.nifty.com [IPv6:2001:268:fa30:831:6a:99:e3:25])
	by sourceware.org (Postfix) with ESMTPS id 0BA574BA2E3C
	for <cygwin-patches@cygwin.com>; Fri, 29 May 2026 02:56:23 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 0BA574BA2E3C
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 0BA574BA2E3C
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2001:268:fa30:831:6a:99:e3:25
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1780023384; cv=none;
	b=QBzQ/NeXSWeD++iSuEP3Pn9EO9vxzJzUexKLNJ43XPOyyXdo3oiipSrxnMovEVbx8f2Cb/x1MPmRMyscDHCpQBt16XCMxWwVW++6mSg8kfHaFPjtoUoyT0ulJKUp9qL87PLbG3/+b3WrA0aD1aPNegxKg+WH6iBSsilqw7YjpR0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1780023384; c=relaxed/simple;
	bh=X3kTM5w4am+T2IWHyQ8lRHCxG3EWkF+imxNJNUKSn1s=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=hyi2XuqxdtTpROhw5ODUla+IEsm8PmfxWvIwWdsoS33tXKrVLh1/bW4B20AoeaUM9gCKtUit4ejy6td7+dkaI9xig1ZjarJjAL9gPpp5+JEXEHTVLyd8WLLPCpcxQScbZRvyzxv/A1Q5ENXOvYboYQ4bAHcST/f3jO2sq3Dt7/I=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=mZWUnnRh
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 0BA574BA2E3C
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=mZWUnnRh
Received: from HP-Z230 by mta-snd-w05.mail.nifty.com with ESMTP
          id <20260529025622116.SHUR.117312.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Fri, 29 May 2026 11:56:22 +0900
Date: Fri, 29 May 2026 11:56:20 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: detect pcon-backed pty for
 non-Cygwin-spawned children
Message-Id: <20260529115620.1ae78cd8926d65720e97d850@nifty.ne.jp>
In-Reply-To: <b11ddb3b-52c1-984d-6879-5257a2952b02@gmx.de>
References: <pull.7.cygwin.1777561444611.gitgitgadget@gmail.com>
	<20260505212503.fdf6b912b76c5cae97a1372c@nifty.ne.jp>
	<b11ddb3b-52c1-984d-6879-5257a2952b02@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1780023382;
 bh=04aYGdQlpacue8SKUB/rcRPQq5DUiprg2yC4VS3kBCQ=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=mZWUnnRhERc0kapzODrcazeOTHJwiuWex1IbRTDRcQHKDh4zSv9EsKxrh4Gfvv+dh7qhNSz1
 I5gXpGimmtoJqZEk3aWzREZHsaKhZsWEue5PFo54LEDncshSRBd0Umd16swo3lRqnakwf5P8Yz
 bipdCvGYN4adT41jgIjr4QtRgt/Lw0Y3sNFfhsubyL9SZ6D2kUL7nWJu2ujNk+I3EyXag96lrY
 fSwrrDlarOgNRIPAktAx6V4Qd3kOgrdB44YIfnNRu/uFrky0R+kaaCCiNbOD2atprfPzq+U9Ig
 p9vlH5BI8ianPfAriAeMyk4x9BwKYSB3Iz9MpKK6L8RMOz5w==
X-Spam-Status: No, score=-12.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Thu, 28 May 2026 15:48:24 +0200 (CEST)
Johannes Schindelin wrote:
> Hi Takashi,
> 
> On Tue, 5 May 2026, Takashi Yano wrote:
> 
> > On Thu, 30 Apr 2026 15:04:04 +0000
> > "Johannes Schindelin via GitGitGadget" wrote:
> > > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> > > 
> > > diff --git a/winsup/cygwin/dtable.cc b/winsup/cygwin/dtable.cc
> > > index 7303f7eac..ce29f4608 100644
> > > --- a/winsup/cygwin/dtable.cc
> > > +++ b/winsup/cygwin/dtable.cc
> > > @@ -327,7 +327,17 @@ dtable::init_std_file_from_handle (int fd, HANDLE handle)
> > >  	dev.parse (myself->ctty);
> > >        else
> > >  	{
> > > -	  dev.parse (FH_CONSOLE);
> > > +	  /* Check whether the inherited console is actually a pseudo
> > > +	     console bridging a pty.  This happens when our non-Cygwin
> > > +	     parent was itself spawned by a Cygwin process from a pty
> > > +	     (e.g. bash spawning git.exe which then spawns vim).  In
> > > +	     that case, connect to the pty slave instead of treating
> > > +	     the handle as a real console. */
> > > +	  int pcon_minor = cygwin_shared->tty.find_pcon_pty ();
> > > +	  if (pcon_minor >= 0)
> > > +	    dev.parse (FHDEV (DEV_PTYS_MAJOR, pcon_minor));
> > > +	  else
> > > +	    dev.parse (FH_CONSOLE);
> > >  	  CloseHandle (handle);
> > >  	  handle = INVALID_HANDLE_VALUE;
> > 
> > The lines:
> > CloseHandle (handle);
> > handle = INVALID_HANDLE_VALUE;
> > are dropped in master branch. Do you think that these two lines
> > are necessary for this patch when applying this patch to cygwin
> > master branch?
> 
> Those two lines are not necessary, all added code ignores the handle
> entirely.

OK. I think this patch is not a bug fix but a behavioral change,
so it should go only to the master branch. What do you think?

If so, the patch does not apply to master branch due to these
two lines. Could you please update the patch for master branch?

In addition, I would appreciate it if you could consider incorporating
the two additional patches I posted earlier.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
