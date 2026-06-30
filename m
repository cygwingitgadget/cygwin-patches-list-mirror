Return-Path: <SRS0=QjWS=E2=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e10.mail.nifty.com (mta-snd-e10.mail.nifty.com [106.153.226.42])
	by sourceware.org (Postfix) with ESMTPS id 76A2B4BA79B4
	for <cygwin-patches@cygwin.com>; Tue, 30 Jun 2026 05:38:36 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 76A2B4BA79B4
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 76A2B4BA79B4
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.226.42
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1782797917; cv=none;
	b=S2n+ll4X/uq/nUsGk2b43o50RaG9SzZW9DW8zFBH9J90PqgGx3c6dnpDbLO2CYQVTuLO3jTh+z6u6TZx8Bzbnomt0awaq3CKaPAeTAQx049o0re/giEioyB1FyJoPasmxqbvZSx9+b60h7VaKbikCIKZMdp0BBZVb7UZIQLD/oo=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1782797917; c=relaxed/simple;
	bh=KKH2wP4fG5u4EcXy1DGqPTrcB2Vy9RZcTaPl+tmdasI=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=xExFZ9rYqrIYo+N9Nep+8IuJ3T376BFiShG3MEpTIBazsY0UJh1e5XIkx0yWydzEZtJjVs/Stue+57I9/naYEdOF8iTDw1Vhbh6s5cgePXebhmvXOjWu2MbPmQw6SbZ901Sh2SFI64XOExPRnSEW1Kx61tDQBDP1lgw3tHp2dq8=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=Rl6Tu44E
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 76A2B4BA79B4
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=Rl6Tu44E
Received: from HP-Z230 by mta-snd-e10.mail.nifty.com with ESMTP
          id <20260630053834157.NNBQ.3198.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Tue, 30 Jun 2026 14:38:34 +0900
Date: Tue, 30 Jun 2026 14:38:32 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: detect pcon-backed pty for
 non-Cygwin-spawned children
Message-Id: <20260630143832.72e6902f3f3afe7301b52313@nifty.ne.jp>
In-Reply-To: <ecb00d76-6ac5-afd5-dea2-43b08c35818c@gmx.de>
References: <pull.7.cygwin.1777561444611.gitgitgadget@gmail.com>
	<20260505212503.fdf6b912b76c5cae97a1372c@nifty.ne.jp>
	<b11ddb3b-52c1-984d-6879-5257a2952b02@gmx.de>
	<20260529115620.1ae78cd8926d65720e97d850@nifty.ne.jp>
	<ecb00d76-6ac5-afd5-dea2-43b08c35818c@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1782797914;
 bh=ly3Uj+2DdGv4IHyhlI0VvIjPPUIrbTCYgbVO5uA5lLw=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=Rl6Tu44ECnxRM9rDOS1ANYw/SKLERhTn5c677bgKHScYoqaK06USf/Khug39Abnd7HpQlUik
 Yi8iJXEigxbwXK4ZJoZjhfDXpDN0Q6OgWc8DRzjWWCROqntjf8/2zuUNBJzP/5Q1fVHGSRAnEe
 ERNmBUn1Rl9FGnmTY4Ii4RE9wXDseqQ5BvG676rG2p3d4o/EJT3u6cW8DpatFIqOt2fP6wmn5D
 UbKOY7wpxdzmUJwmQRNPq5SYNEXIkwzLOv9WmBgl+p79tXD/JFsoMhaiIPMkgIdcyRm5eZn8yY
 rLNSbMEaFO0K4s5C4AXaMXcYSexBWtmxMV+DSoaJHY3vnwkA==
X-Spam-Status: No, score=-12.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Johannes,

On Sat, 27 Jun 2026 10:38:50 +0200 (CEST)
Johannes Schindelin wrote:
> Hi Takashi,
> 
> On Fri, 29 May 2026, Takashi Yano wrote:
> 
> > On Thu, 28 May 2026 15:48:24 +0200 (CEST)
> > Johannes Schindelin wrote:
> > > Hi Takashi,
> > > 
> > > On Tue, 5 May 2026, Takashi Yano wrote:
> > > 
> > > > On Thu, 30 Apr 2026 15:04:04 +0000
> > > > "Johannes Schindelin via GitGitGadget" wrote:
> > > > > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> > > > > 
> > > > > diff --git a/winsup/cygwin/dtable.cc b/winsup/cygwin/dtable.cc
> > > > > index 7303f7eac..ce29f4608 100644
> > > > > --- a/winsup/cygwin/dtable.cc
> > > > > +++ b/winsup/cygwin/dtable.cc
> > > > > @@ -327,7 +327,17 @@ dtable::init_std_file_from_handle (int fd, HANDLE handle)
> > > > >  	dev.parse (myself->ctty);
> > > > >        else
> > > > >  	{
> > > > > -	  dev.parse (FH_CONSOLE);
> > > > > +	  /* Check whether the inherited console is actually a pseudo
> > > > > +	     console bridging a pty.  This happens when our non-Cygwin
> > > > > +	     parent was itself spawned by a Cygwin process from a pty
> > > > > +	     (e.g. bash spawning git.exe which then spawns vim).  In
> > > > > +	     that case, connect to the pty slave instead of treating
> > > > > +	     the handle as a real console. */
> > > > > +	  int pcon_minor = cygwin_shared->tty.find_pcon_pty ();
> > > > > +	  if (pcon_minor >= 0)
> > > > > +	    dev.parse (FHDEV (DEV_PTYS_MAJOR, pcon_minor));
> > > > > +	  else
> > > > > +	    dev.parse (FH_CONSOLE);
> > > > >  	  CloseHandle (handle);
> > > > >  	  handle = INVALID_HANDLE_VALUE;
> > > > 
> > > > The lines:
> > > > CloseHandle (handle);
> > > > handle = INVALID_HANDLE_VALUE;
> > > > are dropped in master branch. Do you think that these two lines
> > > > are necessary for this patch when applying this patch to cygwin
> > > > master branch?
> > > 
> > > Those two lines are not necessary, all added code ignores the handle
> > > entirely.
> > 
> > OK. I think this patch is not a bug fix but a behavioral change,
> > so it should go only to the master branch. What do you think?
> 
> Seeing as this fixes a regression in Git for Windows, where `git commit`'s
> spawning a `vim` that will clear the screen after exiting instead of
> restoring the previous non-alternate screen, I would characterize it as a
> bug fix.
> 
> But I can make that bug fix downstream-only, in Git for Windows' fork of
> the MSYS2 runtime, if you want to keep the commit in Cygwin's `master`
> only and not backport it to `cygwin-3_6-branch`. Either solution is fine
> for me.

I still do not think this is a bug fix, but rather a significant behavioral
change. So I'd keep the patch series only in master branch.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
