Return-Path: <SRS0=15Wh=6Z=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e08.mail.nifty.com (mta-snd-e08.mail.nifty.com [106.153.226.40])
	by sourceware.org (Postfix) with ESMTPS id 0522A4BA2E04
	for <cygwin-patches@cygwin.com>; Fri, 19 Dec 2025 05:13:58 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 0522A4BA2E04
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 0522A4BA2E04
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.40
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1766121239; cv=none;
	b=dTTZEbhbEbK38k9WAymMb2Oold1OepXGIi48LOZJmh/8ZPPiAGl9UWjNvLcXmpckCvr2YExOlQGIsqgXswTo0FULdfxePNnlYCyofOUgHZkRsAh9WNo6LQe5ZtQpMs9+3geN+JLoQ+a4rqSgba2loCWsKiEr2XvAttd6GdKN4YI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1766121239; c=relaxed/simple;
	bh=YGotvXFLwbKnrKNJctA1RQP/NXhRi2F75ZmmjJ5okAU=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=c1aZge/zypRkU4dwnftVtG/c/eLLHfkYtKeRCsjowHyDZ0NkvzwVlDpcAy75qfcSbNuOF77vP+Q1xeVwmHqJtQlhnFIHg1YFk3A27uF24syLIlQbg5NfLJsOJjwkUIqS1LqBwZDX1gF/BNwHbfJyiD4jZ+oZQGN8Y1hEi754j9Q=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 0522A4BA2E04
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=tMUwHdo0
Received: from HP-Z230 by mta-snd-e08.mail.nifty.com with ESMTP
          id <20251219051357285.VBVB.23755.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Fri, 19 Dec 2025 14:13:57 +0900
Date: Fri, 19 Dec 2025 14:13:55 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 1/2] Cygwin: pty: Fix ESC sequence parsing in
 pty_master_fwd_thread
Message-Id: <20251219141355.c4c9016f1b07652aa1c7346b@nifty.ne.jp>
In-Reply-To: <54cf8d06-cc75-9fde-34c3-c49389e931e3@gmx.de>
References: <20251218072722.1634-1-takashi.yano@nifty.ne.jp>
	<20251218072722.1634-2-takashi.yano@nifty.ne.jp>
	<54cf8d06-cc75-9fde-34c3-c49389e931e3@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1766121237;
 bh=pzK/0Ew/fCP4XMh+aXfuvcHmVK34pKT6et5Y5BFK91w=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=tMUwHdo0MZyMXqPVmW6Q/uSISoUrcelHRnk0MoK/rxMjR+wwoYiuZmOP3T/LKjORIr2qnihB
 VGr6YbAEwzRuZQa9aP7cJitwVgl69Kkyr1ysBLQeCC5jJRj/o/ig06GHO9bi5OIILJqZrrBNjQ
 yR41z/qxVrBCTSu+N/4l0qcFXNnd5ek1B3vokWChv2H/up8BBnY7pRHxNjwMTFTt8EG/IW8w3i
 0ZsDm8FCAOXfsAL/Pyu1kTlCGXu0WUA8KdRTZgwbeacAzOaMns7Iq/n+ShZDMaJmEmAdI2g8Ac
 LuQaxYkRyk6ugA4KymuRl1XeBh0qYyMuLLdoJIA+tjQBoTSQ==
X-Spam-Status: No, score=-11.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Thu, 18 Dec 2025 09:56:34 +0100 (CET)
Johannes Schindelin wrote:
> Hi Takashi,
> 
> On Thu, 18 Dec 2025, Takashi Yano wrote:
> 
> > This patch fixes the bug in ESC sequence parser used when pseudo
> > console is enabled in pty_master_fwd_thread(). Previously, if
> > multiple ESC sequences exist in a fowarding chunk, the later one
> > might not be processed appropriately. In addition, the termination
> > ST (ESC \) was not supported, that is, only BEL was supported.
> > 
> > Fixes: 10d083c745dd ("Cygwin: pty: Inherit typeahead data between two input pipes.")
> > Reviewed-by: Corinna Vinschen <corinna@vinschen.de>
> > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > ---
> >  winsup/cygwin/fhandler/pty.cc | 13 +++++++++----
> >  1 file changed, 9 insertions(+), 4 deletions(-)
> > 
> > diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
> > index 679068ea2..3b0b4f073 100644
> > --- a/winsup/cygwin/fhandler/pty.cc
> > +++ b/winsup/cygwin/fhandler/pty.cc
> > @@ -2680,7 +2680,7 @@ fhandler_pty_master::pty_master_fwd_thread (const master_fwd_thread_param_t *p)
> >  	  int state = 0;
> >  	  int start_at = 0;
> >  	  for (DWORD i=0; i<rlen; i++)
> 
> I wonder whether the other `for ()` loops in `pty_master_fwd_thread()`
> also need changes:
> 
> - https://github.com/cygwin/cygwin/blob/cygwin-3.6.5/winsup/cygwin/fhandler/pty.cc#L2693-L2720
> 
> - https://github.com/cygwin/cygwin/blob/cygwin-3.6.5/winsup/cygwin/fhandler/pty.cc#L2722-L2750

The bug was only in the parser for title set ESC sequence, I thought.
But, wait,
> - https://github.com/cygwin/cygwin/blob/cygwin-3.6.5/winsup/cygwin/fhandler/pty.cc#L2722-L2750
This seems to be better to fix as well for broken sequence as well as
title set sequence. Thanks for pointing this out. I'll add a separate
patch.
 
> > -	    if (outbuf[i] == '\033')
> > +	    if (state == 0 && outbuf[i] == '\033')
> >  	      {
> >  		start_at = i;
> >  		state = 1;
> 
> The diff context is unfortunately not wide enough to show that there is
> only this line before the next hunk:
> 
>                 continue;
> 
> > @@ -2688,12 +2688,14 @@ fhandler_pty_master::pty_master_fwd_thread (const master_fwd_thread_param_t *p)
> >  	      }
> >  	    else if ((state == 1 && outbuf[i] == ']') ||
> >  		     (state == 2 && outbuf[i] == '0') ||
> > -		     (state == 3 && outbuf[i] == ';'))
> > +		     (state == 3 && outbuf[i] == ';') ||
> > +		     (state == 4 && outbuf[i] == '\033'))
> >  	      {
> >  		state ++;
> >  		continue;
> 
> So if we encounter an ESC when the state is 1, 2 or 3, we no longer reset
> `state = 0`... That does not sound correct.
> 
> And if we encounter an ESC _just_ after `ESC ] 0 ;`, we set `state = 5`
> which is then not handled other than by resetting `state = 0` at the next
> character?

Yes. If the next char is not '\\'. I think the pached code behaves so.

> >  	      }
> > -	    else if (state == 4 && outbuf[i] == '\a')
> > +	    else if ((state == 4 && outbuf[i] == '\a')
> > +		     || (state == 5 && outbuf[i] == '\\'))
> >  	      {
> >  		const char *helper_str = "\\bin\\cygwin-console-helper.exe";
> >  		if (memmem (&outbuf[start_at], i + 1 - start_at,
> > @@ -2701,11 +2703,14 @@ fhandler_pty_master::pty_master_fwd_thread (const master_fwd_thread_param_t *p)
> >  		  {
> >  		    memmove (&outbuf[start_at], &outbuf[i+1], rlen-i-1);
> >  		    rlen = wlen = start_at + rlen - i - 1;
> > +		    i = start_at - 1;
> 
> I have a suspicion that _this_ is the actual bug fix necessary. Could this
> be true? If you remove the remainded of this patch and only reset `i`
> appropriately, does it fix the problem?

You are right. The most important is above one line.
Maybe other fixes should be separate patches.
Please review again for v3 patch.

>  		  }
>  		state = 0;
>  		continue;
>  	      }
> -	    else if (outbuf[i] == '\a')
> +	    else if (state == 4)
> +	      continue;
> +	    else
>  	      {
>  		state = 0;
>  		continue;

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
