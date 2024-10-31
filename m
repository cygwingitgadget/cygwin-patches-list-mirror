Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 503C53858D21; Thu, 31 Oct 2024 10:19:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 503C53858D21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1730369941;
	bh=AgqQevLebD/ZcoFhmHVJhfiE/h0lx2uDorEwRbr3a1U=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=GdGSnjXqDnezU40fQeLqdXbBBYPrkI/trOShcuRcrVYFsT/KHkj6KctDZ2hGNNY9T
	 Pa5R5DAPydsVIrHr+PID5Sp89n279yTZ2bafLME9GelYm7qm1nn2mbqDmblz4KobiF
	 KvEGU6yx3kBf0G4cpGJPcd1rzXNgH/hzEdITgJ9Q=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 37A69A80BC2; Thu, 31 Oct 2024 11:18:59 +0100 (CET)
Date: Thu, 31 Oct 2024 11:18:59 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3] Cygwin: sigfe: Fix a bug that signal handler destroys
 fpu states
Message-ID: <ZyNZk9f8W5c2O-yG@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20241014063914.6061-1-takashi.yano@nifty.ne.jp>
 <ZxfLig9716RXtWLu@calimero.vinschen.de>
 <20241024175802.a7d18a8e604ff2d18221cfcb@nifty.ne.jp>
 <Zxtbry_Qb70ouRw-@calimero.vinschen.de>
 <20241031173636.a174c2addf42ab8fde68ae81@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241031173636.a174c2addf42ab8fde68ae81@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Oct 31 17:36, Takashi Yano wrote:
> Hi Corinna,
> 
> On Fri, 25 Oct 2024 10:49:51 +0200
> Corinna Vinschen wrote:
> > On Oct 24 17:58, Takashi Yano wrote:
> > > On Tue, 22 Oct 2024 17:58:02 +0200
> > > Corinna Vinschen <corinna-cygwin@cygwin.com> wrote:
> > > > Hi Takashi,
> > > > 
> > > > big change, so, honest question: Do you think this is safe for 3.5.5?
> > > > 
> > > > This certainly also requires an entry in the release text and there
> > > > are just a few minor typos in comments, see below.
> > > 
> > > What about adopting my first idea to 3.5.5
> > > https://cygwin.com/pipermail/cygwin/2024-October/256506.html
> > > and applying this patch to 3.6.0 branch?
> > 
> > Admittedly, I'm also not deep in FPU stuff.
> > 
> > fnstenv/fldenv and dropping fninit look like a simple approach to fix
> > the worst problem.  Did you just discuss this on the mailing list or did
> > you check that it actually fixes the reported problem?
> 
> I tested locally using Christian's test case and confirmed that
> the problem has been fixed as well as that no new problem occurs.
> 
> > But either way, I wonder if it's worth the effort to have two different
> > solutions.  This isn't a regression, so we don't have to fix this ASAP
> > in 3.5.5.  It could easily wait a version.
> > 
> > So I'm thinking we should go with your sleek new code in 3.6 and let
> > this simmer for a while, so it's put to use by people running 3.6
> > versions.
> > 
> > Does that sound right?
> 
> Hmm, this is not a regression but a long-standing bug which can
> easily be fixed. Also, there is only a very small risk of regression
> with the fnstenv/fldenv patch. Moreover, the bug causes critical
> miscalculations to result in long double processing.
> 
> So, I think it is better to apply the v3_5-branch patch (I have just
> submitted) for cygwin-3_5-branch, and to apply the v3 patch (I already
> submitted) to the master branch. v3_5-branch patch is simple and small,
> so it will not be so painful to maintain.
> 
> Don't you think so?

I asked because I wasn't sure, but your solution is fine with me.


Thanks,
Corinna
