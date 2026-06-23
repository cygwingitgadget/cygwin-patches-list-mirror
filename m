Return-Path: <SRS0=oHIC=ET=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w10.mail.nifty.com (mta-snd-w10.mail.nifty.com [106.153.227.42])
	by sourceware.org (Postfix) with ESMTPS id 960634BA2E07
	for <cygwin-patches@cygwin.com>; Tue, 23 Jun 2026 13:04:11 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 960634BA2E07
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 960634BA2E07
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.227.42
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1782219852; cv=none;
	b=Pa2Eh1exaKCf0kFuLCuPw7q1JMHRzPT6J+jldTAkbdagMqmGcVm9ZVmCbgToLqrjKDdBIdsM3A85GzZGgz8qpj4SaoEfh6UeioazczrFJUNYHzGScVWw602NMb/Jb4yHCnbkvbKfjThOIsDdm490ydNUPZn+/w1+niGziozEXew=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1782219852; c=relaxed/simple;
	bh=w7LTZjjd3s9tgDgw8Hm4nxa7+4+5JdlM68JtNG7bqHc=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=bERZ+5ZHDbqorSiqir5hkItf+WPH223JKYvmDfGq3Ln0n4EPvQG2Zk5vCWgetRqwb7EwjKx/hV/sGYGJNsz3UVtXKi7Z19FiKUKHLRhvvgCyqKCFeRtu27r2Bxp+Dt6DjORbxs3OsfxOC4pXgLLD87tHuiGW2TCZnVqPAJ9wG2c=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=Adg0kRZ/
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 960634BA2E07
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=Adg0kRZ/
Received: from HP-Z230 by mta-snd-w10.mail.nifty.com with ESMTP
          id <20260623130408868.VDFB.44671.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Tue, 23 Jun 2026 22:04:08 +0900
Date: Tue, 23 Jun 2026 22:04:07 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Treat CR/NL in accept_input() the same as
 in transfer_input()
Message-Id: <20260623220407.824a42b50f122e2cd31fe462@nifty.ne.jp>
In-Reply-To: <e24b66b2-4518-4fff-8b05-1fb349a1b491@maxrnd.com>
References: <20260612124728.38921-1-takashi.yano@nifty.ne.jp>
	<e24b66b2-4518-4fff-8b05-1fb349a1b491@maxrnd.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1782219848;
 bh=sqrhSy+2be5zZ57vyknqNVDoetBYseSJD4EHh31IWnA=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=Adg0kRZ/njugCvuide08aa5jbncsMb8WMlgoxgTZ51m5LOKpFk48lj68rTGijoBlkqSroa2N
 MnS2OKQpsqcECp1GlhTUxO1Cw7T3OzxxJ4WJ6fQFUHTn7JBXuHWyVQ3AOc0QpL29UOfXzlzLL4
 bY64QNdIzYDziEcWaKVZMfq4hx0B7z+1dEDDWOm866iH9SBYIDzyH8wojugRh6gHrpGmsQuQnT
 eFH3ipGnGlXRb42dLssbv/hkmBwEU66Lwtk1mloX/2EEQDyG63fE8Bd07nMuoltyeeQiowGX9b
 2w5B+JmnMyopOj8n/v6vANPi9C7F2xkBfK75NB3l5N6OaJgg==
X-Spam-Status: No, score=-12.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Mark,

Thanks for reviewing!

On Tue, 23 Jun 2026 00:41:11 -0700
Mark Geisert wrote:
> Hi Takashi,
> 
> On 6/12/2026 5:47 AM, Takashi Yano wrote:
> > In transfer_input(), CR and NL in the data transferred to nat-pipe
> > is treated as follows:
> >    1) If pseudo console is activated, convert NL to CR.
> >    2) If pseudo console is disabled, convert CR to NL.
> > This conversion is necessary to ensure non-cygwin apps can handle
> > CR/NL as expected. Therefor, CR and NL should be treated as the
> > same way in accept_input() if the data is sent to nat-pipe.
> 
> The above block is fine.
> 
> > Usually, when pseudo console is activated, the input data for non-
> > cygwin app is not treated by accept_input. However, accept_input()
> > handle the input data in pseudo console enabled mode, only in a
> > very short duration when pseudo console is about to setup, because
> > master::write() calls line_edit() in the pcon_start mode. If pseudo
> > console is disabled, accept_input() handles them, however usually
> > ICRNL flag is set, so line_edit() do this conversion. However, if
> > this flag is not set, the conversion added by this patch is needed
> > as well.
> 
> This block I'm having a bit of trouble to follow.  Can you possibly 
> reword to describe it in more orderly fashion?

What about:
  In the previous implementation, problems rarely occurred because
  accept_input() normally does not handle input for non-cygwin apps
  when the pseudo console is active. Under typical conditions, such
  input is snet to pseudo console directly by WriteFile(), so
  accept_input() is not involved and no onversion issues arise.

  There is, however, a brief period during pseudo console initialization
  in which accept_input *does* handle the input. This happens because
  master::write() invokes line_edit() while in pcons_start mode. During
  this short window, the input is processed in pseudo-console-enabled
  mode, and the usual conversion behaviour may not apply.

  When the pseudo console is disabled, accept_input() always handles
  the input, and in most cases the ICRNL flag is set by shell, so
  line_edit() performs the CR->NL conversion. But if the flag is not
  set, this conversion does not occur. Therefore, the additional
  conversion introduced by this patch is required to ensure consistent
  behaviour in both cases.
?

> > Fixes: f20641789427 ("Cygwin: pty: Reduce unecessary input transfer.")
> > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > Reviewed-by:
> > ---
> >   winsup/cygwin/fhandler/pty.cc | 8 ++++++++
> >   1 file changed, 8 insertions(+)
> > 
> > diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
> > index ef79ea679..30918c2f3 100644
> > --- a/winsup/cygwin/fhandler/pty.cc
> > +++ b/winsup/cygwin/fhandler/pty.cc
> > @@ -690,6 +690,14 @@ fhandler_pty_master::accept_input ()
> >   	  p = mbbuf;
> >   	  bytes_left = nlen;
> >   	}
> > +
> > +      char *p0 = p;
> > +      if (get_ttyp ()->pcon_activated)
> > +	while ((p0 = (char *) memchr (p0, '\n', bytes_left - (p0 - p))))
> > +	  *p0 = '\r';
> > +      else
> > +	while ((p0 = (char *) memchr (p0, '\r', bytes_left - (p0 - p))))
> > +	  *p0 = '\n';
> >       }
> >   
> >     if (!bytes_left)
> 
> The code of the patch looks LGTM.  Let me know what you think about my 
> comments when you can.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
