Return-Path: <SRS0=i6Vi=F7=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e09.mail.nifty.com (mta-snd-e09.mail.nifty.com [106.153.227.121])
	by sourceware.org (Postfix) with ESMTPS id 9FCE14BA23DD
	for <cygwin-patches@cygwin.com>; Thu,  6 Aug 2026 16:36:23 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 9FCE14BA23DD
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 9FCE14BA23DD
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.227.121
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1786034184; cv=none;
	b=QiaZV1+SgGanTvnCbe2uxW8nPzxe8jG6IKOJtoqHeMsr3NCvmr5r1RmtLRSZRaLXgTdZk3r4mUs5DDXGVembh7utKyI7ZktvWtelRdaFSZUP4bXxnWZtBKDMpKj6/EYSRrAaTuxslcMcxyQyLstGyl63CJKxXl+Zg92uMCkEyK8=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1786034184; c=relaxed/simple;
	bh=W2PUW3f4hX2HlNAB4Z9P/3AKUgcNri/MTg0F3qkuEyE=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=huvjocaVEFyE89+g1Y9y3YJM0589EGznVdPxL7w33IffLDo75fEdMMd88o8Je1Ct+IuRT1+RsTjdU1xAGHiTXEoWcaw+uV4Ekb+mocsA/WII4iCqRnM56bN1W6a1Gk8sm5b3vU6/aEa4Wk9tl022PQY9lcgTE29ruux5q8CuU+8=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=reXm96fB
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 9FCE14BA23DD
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=reXm96fB
Received: from HP-Z230 by mta-snd-e09.mail.nifty.com with ESMTP
          id <20260806163621577.JECA.60338.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Fri, 7 Aug 2026 01:36:21 +0900
Date: Fri, 7 Aug 2026 01:36:20 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: console: Fix regression in console input
Message-Id: <20260807013620.678c7579ce2846ec0e658d6f@nifty.ne.jp>
In-Reply-To: <20260807012551.c176e66e6288f13ad597d9a2@nifty.ne.jp>
References: <20260803025011.5289-1-takashi.yano@nifty.ne.jp>
	<9a1a2379-361e-86b4-b310-d162af82a417@gmx.de>
	<20260807012551.c176e66e6288f13ad597d9a2@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1786034181;
 bh=ddlon1L64BY3tKwfKzAPTvgxC9df+9mp/BZFTazYvu0=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=reXm96fBMr5Lo5UqSvs8ewTiZsERVpBhhzTQT4efnX/SIBuTeOOdbJKsuSObowXg2MyvFpp2
 lPZTHklBguQO5t1zmdjTdh9f9XZKiR0jDdcPdw7eLoWi2eMCrqA5WojutXq2W4Gqj+WJ48euPD
 9aUDMnSLlQALE3jRQdWs5XQLbI+SPY8hkDUI9FSLVYtdwYHueNATVRjhT7k05Y67Mf67bsHj5K
 UvcosTjENW227j6FMGBgpNy3Nx5NRryEG4x5nZoVlKgiFOx1MUTAxsVcWFpFY8uFcEVoaWad19
 QGx9A7xdAgrU3g+92IFtr6VRIdp+1I6KX/5k9oJ0gx/Ft08Q==
X-Spam-Status: No, score=-11.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Fri, 7 Aug 2026 01:25:51 +0900
Takashi Yano wrote:
> Hi Johannes,
> 
> Thanks for reviewing!
> 
> On Thu, 6 Aug 2026 16:21:49 +0200 (CEST)
> Johannes Schindelin wrote:
> > Hi Takashi,
> > 
> > On Mon, 3 Aug 2026, Takashi Yano wrote:
> > 
> > > The commit fac73911f5a0 ("Cygwin: console: Fix typeahead input for
> > > bash") introduced a bug where select() consumes some input chars in
> > > canonical mode, preventing read() from reading them. This is due to
> > > discarding input events when process_input_message() does not return
> > > `input_ok` even if it is called from select().
> > > The basic idea of that commit was making process_input_message()
> > > not to store processed chars into readahead buffer. This was not
> > > correct because the key input events ware processed twice, once by
> > > select() and again by read(). Thus even if that commit worked as
> > > intended, the side effect such as input echo would be applied twice.
> > > 
> > > With this patch, process_input_message() handles only the minimum
> > > necessary of input events in both cases, those processed by select()
> > > and those processed by read(). To achive this behaviour, the function
> > > returns without processing when `input_ready` is already satisfied,
> > > or after it has processed the specified number of chars.
> > > 
> > > Addresses: https://cygwin.com/pipermail/cygwin/2026-August/259915.html
> > > Reported-by: Steven Doerfler <sgd-cygwinlist@lugaru.com>
> > > Fixes: fac73911f5a0 ("Cygwin: console: Fix typeahead input for bash")
> > > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > > Revewed-by:
> > 
> > This explanation, as well as the diff, look sound to me.
> > 
> > You may want to fix the typos "Revewed" -> "Reviewed", "ware" -> "were"
> > and "achive" -> "achieve", but those are tiny nits.
> > 
> > You could also fix the pre-existing typo in the comment "recored" ->
> > "recorded" while at it, but again, that's just a nit.
> > 
> > > ---
> > >  winsup/cygwin/fhandler/console.cc | 14 ++++++--------
> > >  1 file changed, 6 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
> > > index 0219a37ef..3904fbd57 100644
> > > --- a/winsup/cygwin/fhandler/console.cc
> > > +++ b/winsup/cygwin/fhandler/console.cc
> > > @@ -1406,7 +1406,6 @@ fhandler_console::input_states
> > >  fhandler_console::process_input_message (size_t len)
> > >  {
> > >    char tmp[60];
> > > -  size_t num_chars = 0;
> > >  
> > >    if (!shared_console_info[unit])
> > >      return input_error;
> > > @@ -1429,6 +1428,10 @@ fhandler_console::process_input_message (size_t len)
> > >        return input_error;
> > >      }
> > >  
> > > +  /* len == 0 if called from select.cc:peek_console() */
> > > +  if (input_ready && (len == 0 || (get_ttyp ()->ti.c_lflag & ICANON)))
> > > +    return input_ok;
> > 
> > It is worth pointing out that while this `input_ready &&` part looks
> > superfluous (both callers guard the call behind `!input_ready`), it is a
> > concurrency guard: a second thread reading the same console fd can set
> > `inpuy_ready` in the window between `read()`'s lock-free `while
> > (!input_ready)` check and `acquire_input_mutex`.
> > 
> > Maybe worth an extra code comment?
> 
> I added short comment here. Thanks.
> 
> > > +
> > >    for (i = 0; i < total_read; i ++)
> > >      {
> > >        DWORD nread = 1;
> > > @@ -1794,7 +1797,6 @@ fhandler_console::process_input_message (size_t len)
> > >  	}
> > >  
> > >        num_input_events_processed = i + 1;
> > > -      num_chars += nread;
> > >        if (toadd)
> > >  	{
> > >  	  ssize_t ret;
> > > @@ -1813,21 +1815,17 @@ fhandler_console::process_input_message (size_t len)
> > >  	    }
> > >  	}
> > >        /* len == 0 if called from select.cc:peek_console() */
> > > -      if (len && num_chars >= len)
> > > +      if (input_ready && (len == 0 || con_ra.ralen >= len))
> > 
> > Something GPT 5.6 Sol stumbled over, before noticing that this is a
> > pre-existing issue: the raw multi-pass caller passes full `buflen` (not
> > `buflen - copied_chars`). That was already there before this patch (and
> > both GPT and Opus think that this is incorrect, I haven't had time to wrap
> > my head around it), and the new `ralen`-based check is actually
> > neutral-to-better; and `tcflush(TCIFLUSH)` doesn't flush `con_ra`.
> > 
> > I'm fairly certain that this is out of scope for this here bug fix, if it
> > is an issue at all (what do you think? Is this `buflen` issue real? Should
> > `tcflush()` also flush `con_ra`?).
> 
> Thanks for finding this. I rechecked here and concluded passing `buflen`
> for process_input_message() is correct. This is because, the length check
> in the process_input_message is:
> 
>       if (input_ready && (len == 0 || con_ra.ralen >= len))
>         goto out;
> 
> After the `while` loop, the chars in readahead data of length `con_ra.ralen`
> will be copied into buffer of `buflen`. So the `len` should be total buffer
> size here.

`copied_chars` is always 0 here in the first place, isn't it?

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
