Return-Path: <SRS0=vCDf=52=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w06.mail.nifty.com (mta-snd-w06.mail.nifty.com [IPv6:2001:268:fa30:831:6a:99:e3:26])
	by sourceware.org (Postfix) with ESMTPS id 50CFD3858D35
	for <cygwin-patches@cygwin.com>; Tue, 18 Nov 2025 23:49:45 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 50CFD3858D35
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 50CFD3858D35
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2001:268:fa30:831:6a:99:e3:26
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1763509785; cv=none;
	b=PAvkB4CnuHoPIGXYylr2uj1hG0TRez5quE4y6Z/SSS5yTTVBu+Q/sFgarOKD4VoJeuVhkSsDpaSittg+Y+cTPsVmNUQFrFC1DXBT0T9PD/5uMHIF1TFkC+EhzJAChfhImKYF8eHzKf61teb/duduB5hCZSFg8UBSmKjZaSDUvF4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1763509785; c=relaxed/simple;
	bh=xOEU0DSXpj/MlbJ+gq+sglQdnfQUMBYgSOk9E2WJlDU=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=vlyQo3a903kB+IU78mhJyyD1JYGlMctbdnZyAkaH88z1657qhjShFk2U4Minuqbqzfnxg3/Wq4vtBKQKdNzVtWr7NvmdPObUl8aqCs9VOVzl8/u8eWkWMfiZEZwEE22iKWPmL7wcC8JFVas+Ik2P2L/c/A0b9B4Y9vnO6YHW7KM=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 50CFD3858D35
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=PJXE2zRh
Received: from HP-Z230 by mta-snd-w06.mail.nifty.com with ESMTP
          id <20251118234943324.IJED.116286.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Wed, 19 Nov 2025 08:49:43 +0900
Date: Wed, 19 Nov 2025 08:49:41 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 1/2] Cygwin: dll_init: Call __cxa_finalize() for
 DLL_LOAD even in exit_state
Message-Id: <20251119084941.e614d027df0605b9f17e7647@nifty.ne.jp>
In-Reply-To: <aRydS7KaXPK99ppW@calimero.vinschen.de>
References: <20251118140943.7357-1-takashi.yano@nifty.ne.jp>
	<20251118140943.7357-2-takashi.yano@nifty.ne.jp>
	<aRydS7KaXPK99ppW@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1763509783;
 bh=CzVehcWSK312NxvLNoCOq6Qv18oZKA5yHvnHTIFAwn8=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=PJXE2zRh2IlUObpOyAuPvCWEmU9qTv+ZWBKL90OZFZVivDuEx6Z+IukOojWkVMGKbZBSLp/y
 u9wrkHBSz5P9HqgHWLKQN31S9sMnBHb04UWcvv2zVbiCYYkpqWpQli2/Vthg7mGI8bsw9W8Xgb
 v/zms/zlMY063TGSZzVfYgUD03vPuRFOQyqXUX+BX0+gLrwFRadpKZwmaCWG0d3g/kHiU1GHgu
 a4p2gDHatsLCfwFaS9ovcTULZIyny4kj3+TeUozWGEBpR3yRgYwm+ItYp2z8SegYofolPvaQGF
 ptU9cdsLjYLxNTdw5aocB0+zpSI2qUO+a3s/ypeQ8NM7Kjnw==
X-Spam-Status: No, score=-11.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Tue, 18 Nov 2025 17:22:35 +0100
Corinna Vinschen wrote:
> On Nov 18 23:09, Takashi Yano wrote:
> > If dlclose() for DLL A is called in the destructor of DLL B which
> > linked with the main program, __cxa_finalize() should be called even
> > in exit_state. This is because if the destructor of DLL B is called
> > in exit_state, DLL A will be unloaded by dlclose().
> 
> Sorry if I'm dense, but aren't these two sentences kind of circular?
> Shouldn't the first sentence rather explain that DLL B loaded DLL A?
> 
> Kind of like this:
> 
>   If the loadtime linked DLL B dlopen's DLL A, __cxa_finalize() should
>   always be called at dll detach time.  This is because ...
> 
> > Thereofre, if __cxa_finalize()is not called here, the destructor of
>   Therefore                   space?
> 
> > DLL A will be called in exit() even though DLL A is already unloaded.
> > This causes crash at exit(). In the case above, __cxa_finalize()
> > should be called before unloading DLL A even in exit_state.
> 
> > 
> > Addresses: https://cygwin.com/pipermail/cygwin/2025-October/258877.html
> > Fixes: c019a66c32f8 ("* dll_init.cc (dll_list::detach) ... Don't call __cxa_finalize in exiting case.")
> > Reported-by: Thomas Huth <th.huth@posteo.eu>
> > Reviewed-by: Mark Geisert <mark@maxrnd.com>, Jon Turney <jon.turney@dronecode.org.uk>
> > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > ---
> >  winsup/cygwin/dll_init.cc | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/winsup/cygwin/dll_init.cc b/winsup/cygwin/dll_init.cc
> > index 1369165c9..5ef0fa875 100644
> > --- a/winsup/cygwin/dll_init.cc
> > +++ b/winsup/cygwin/dll_init.cc
> > @@ -584,7 +584,10 @@ dll_list::detach (void *retaddr)
> >  	  /* Ensure our exception handler is enabled for destructors */
> >  	  exception protect;
> >  	  /* Call finalize function if we are not already exiting */
> > -	  if (!exit_state)
> > +	  /* We always call the finalize function for a dlopen()'ed DLL
> > +        because its destructor may crash if invoked during exit()
> > +        after dlclose(). */
> 
> I think this comment is puzzeling for the code reader.  "exit() after
> dlclose()" *seems* to imply that it crashes at exit() time even if
> dlclose() has been called explicitely.  The problem is that the
> context here is tricky, so it's quite hard to explain why a crash may
> occur if __cxa_finalize isn't called here in only a few words.  It may
> be helpful to extend the comment and explain this more thoroughly...
> 
> Code-wise, the patch LGTM.

Thanks for reviewing!
I revised patch commend and commit message. Please see v3.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
