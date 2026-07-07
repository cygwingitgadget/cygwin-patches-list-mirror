Return-Path: <SRS0=jPxW=FB=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e07.mail.nifty.com (mta-snd-e07.mail.nifty.com [106.153.226.39])
	by sourceware.org (Postfix) with ESMTPS id 065E64BA2E1F
	for <cygwin-patches@cygwin.com>; Tue,  7 Jul 2026 08:58:40 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 065E64BA2E1F
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 065E64BA2E1F
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.226.39
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1783414728; cv=none;
	b=mbPNf7TjniX69Z+xrOKUdLGJoojupBkUuSkVEkDoiRaYDndD53erhP+Tts7GzJgb956H170T8ojXQ7P0LS4slOyeOfYynMphToi89TVo9rG66XQDG/E2FXwIGcV6exWBiP8zXg/bgPK+Ct86s+nDm+JQkCYEvC1SivlL6jqcIOs=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1783414728; c=relaxed/simple;
	bh=8kErJffFEw+2q3wC0TUMbw8viLgmOcb3Lm9Dmfk6fdA=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=ZEKXIYTU3unIIVkmkem07NNezMJrE6XG6FCPMMvzs6o7nwW27gR275MzhJdt65aEfMt/7MeNuhjE5tACoqTMEJdDMoZrbrxpE1cKNV41CyZ7N60qBXk/zF/WZt2CawN8u/M5mjFBUHml0Y5xk8Htbj1pdvwEW7EQH/FHOGVMoq4=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=R4K/SRYv
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 065E64BA2E1F
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=R4K/SRYv
Received: from HP-Z230 by mta-snd-e07.mail.nifty.com with ESMTP
          id <20260707085837739.ZKOG.17441.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Tue, 7 Jul 2026 17:58:37 +0900
Date: Tue, 7 Jul 2026 17:58:35 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Fix error return for madvise()
Message-Id: <20260707175835.8a5add90fd3b703254d09971@nifty.ne.jp>
In-Reply-To: <646b21e0-df07-46c0-95c2-854405cc1d30@maxrnd.com>
References: <20260706234758.89659-1-mark@maxrnd.com>
	<20260707094551.c89e6c61a79c534f6c385d5a@nifty.ne.jp>
	<646b21e0-df07-46c0-95c2-854405cc1d30@maxrnd.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1783414717;
 bh=a5XvhI5CXz96lwDO6kZOosbGGT8FxnxvANfYPXHg4c4=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=R4K/SRYvLQDtaK3doaTs/V3pDlbzR7rzTgIZAcKZ+QGsk8fuJQLCyxy6plfaq8YZd0PGXggG
 jzf8n18CTu7vDv+7VPf8xXjoRibCrdivVSQof2++GSIDqNM3FBj/yvoR0DbDR3/5ApqzxSGBhC
 M1ZhGa5CJ/I4JsA3TQwASMuG6eHSBRltm7lSQ9+ufEDooPT6Jm4cD/jKIRwIEBzWkhW10in0F+
 HXGF0Ly+1KZ8/3qLkRHk1F+bleB9KR4BPmxZ0pIDqsWqFgU7m5tbGgkA8zhPam23IZi/Jx4zu3
 fdS3uUT35Z+BO+tm1NSupeYi3CIS+dCUWSZgLl8hLh86cVWQ==
X-Spam-Status: No, score=-12.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Mark,

On Tue, 7 Jul 2026 00:58:48 -0700
Mark Geisert wrote:
> Hi Takashi,
> 
> On 7/6/2026 5:45 PM, Takashi Yano wrote:
> > Hi Mark,
> > 
> > On Mon,  6 Jul 2026 16:47:43 -0700
> > Mark Geisert wrote:
> >> Currently madvise() and posix_madvise() are wired together as one
> >> function: the latter.  But their error returns should be different.
> >> Make madvise a first-class export in cygwin.din; code a new madvise()
> >> that calls posix_madvise() and massages any error return.
> >>
> >> Reported-by: Christian Franke <Christian.Franke@t-online.de>
> >> Addresses: https://cygwin.com/pipermail/cygwin/2026-July/259872.html
> >> Signed-off-by: Mark Geisert <mark@maxrnd.com>
> >> Fixes: 61522196c715 (* Merge in cygwin-64bit-branch.)
> >>
> >> ---
> >>   winsup/cygwin/cygwin.din               |  2 +-
> >>   winsup/cygwin/include/cygwin/version.h |  3 ++-
> >>   winsup/cygwin/mm/mmap.cc               | 12 ++++++++++++
> >>   3 files changed, 15 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/winsup/cygwin/cygwin.din b/winsup/cygwin/cygwin.din
> >> index 2e53bc819..937eacdaf 100644
> >> --- a/winsup/cygwin/cygwin.din
> >> +++ b/winsup/cygwin/cygwin.din
> >> @@ -951,7 +951,7 @@ lseek SIGFE
> >>   lsetxattr SIGFE
> >>   lstat SIGFE
> >>   lutimes SIGFE
> >> -madvise = posix_madvise SIGFE
> >> +madvise SIGFE
> >>   makecontext NOSIGFE
> >>   mallinfo SIGFE
> >>   malloc SIGFE
> >> diff --git a/winsup/cygwin/include/cygwin/version.h b/winsup/cygwin/include/cygwin/version.h
> >> index 71ac5282b..fc838e23e 100644
> >> --- a/winsup/cygwin/include/cygwin/version.h
> >> +++ b/winsup/cygwin/include/cygwin/version.h
> >> @@ -502,12 +502,13 @@ details. */
> >>     360: Add RLIMIT_NPROC.
> >>     361: Export _Fork.
> >>     362: Export C23 stdbit functions.
> >> +  363: Export madvise separately from posix_madvise.
> >>   
> >>     Note that we forgot to bump the api for ualarm, strtoll, strtoull,
> >>     sigaltstack, sethostname. */
> >>   
> >>   #define CYGWIN_VERSION_API_MAJOR 0
> >> -#define CYGWIN_VERSION_API_MINOR 362
> >> +#define CYGWIN_VERSION_API_MINOR 363
> >>   
> >>   /* There is also a compatibity version number associated with the shared memory
> >>      regions.  It is incremented when incompatible changes are made to the shared
> > 
> > I don't think we should change CYGWIN_VERSION_API_MINOR value
> > because the API itself is not changed. This patch fixes a bug
> > in madvice() implementation.
> 
> I went back and forth internally on whether the minor version should be 
> bumped.  One point was whether divorcing madvise() from posix_madvise() 
> in cygwin.din warranted an API bump: without a bump won't existing 
> programs be unable to access the new error return behavior?  Another 
> point was that the error return behavior of madvise() is being changed; 
> isn't that behavior part of the API?  I agree this is a bug fix but such 
> fixes could cause API changes.

I could not found the case that API version bump for behavioral change
in the past.

The adding MACROs such as:
  148: Add open(2) flags O_SYNC, O_RSYNC, O_DSYNC and O_DIRECT.
  149: Add open(2) flag O_NOFOLLOW.
could be a 'behavioral change', but header files for user were also
changed in these cases.

> This is a case where I'd like to get input from other folks who might've 
> made similar changes to Cygwin over its long history.  I am totally OK 
> with removing the API bump in a v2 patch if that's the consensus opinion.

What do others think about this?

> Thank you for the review!
> 
> ..mark
> 


-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
