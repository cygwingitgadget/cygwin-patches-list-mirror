Return-Path: <SRS0=WSQ1=NK=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w03.mail.nifty.com (mta-snd-w03.mail.nifty.com [106.153.227.35])
	by sourceware.org (Postfix) with ESMTPS id BE7823858D26
	for <cygwin-patches@cygwin.com>; Sat,  8 Jun 2024 16:43:45 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org BE7823858D26
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org BE7823858D26
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.35
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1717865029; cv=none;
	b=bzQ/ILklEQ4zOeWWlJ2rokaSGSE8gROE3R9HY6O+bdViXldLAa9cLteKfGOEfeZaLorB5+b1NM7+xu4qicHyBp6lPzba4Vl5upNuyHe+0zz+9UO986TZ/NmA8lKGfZjv1w2CZNH8/aY+g+DwhciVyV7L59U0lFh1HV793cZOdEU=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1717865029; c=relaxed/simple;
	bh=/15P7dUhKcCrLSABaNyiHnnpaq6rKw1W75KqRQuJFJE=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=Ql8dR0Z49MfSE3StJ/4uyGTCaSYOntVxV96BHiNHvntXDSVGtmQpuOev/unicHRYMcZX6Ur8P811iZxreY+ejvoU2yBHtUhyc3MTfgJQ/+VuIZb8qXTXVxBFMWB7zxFmac6HI5SwnFm8NlxUcddzmcitrSjprGBeAysmwyZQylU=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from HP-Z230 by mta-snd-w03.mail.nifty.com with ESMTP
          id <20240608164343267.OMQQ.115271.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Sun, 9 Jun 2024 01:43:43 +0900
Date: Sun, 9 Jun 2024 01:43:42 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Suppress a warning generated with w32api >=
 12.0.0
Message-Id: <20240609014342.7d72fdc0b67b0f094963bf2a@nifty.ne.jp>
In-Reply-To: <20240607163724.29390-1-jon.turney@dronecode.org.uk>
References: <20240607163724.29390-1-jon.turney@dronecode.org.uk>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1717865023;
 bh=eD2JgoXg06aw9yBlYgUgPd1fLY6gdg1LOUyXHJgKliY=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=uDL1ciPz5r9N46ylv99qS0vLAOJMOfepFKbOq1eYTPnRwidlLNqW5PKEkUkDfcfZRzjcX19k
 Z0SuFJtg3mKdLzp/RDo56yTbsjKJc/ARen/Kd5axnhz/6EZ4I4teo55NehcLv7wBJsmxtaTsgW
 +Maxd5JAW+M+wxm1JKOFiTpzJWippAMYWsDPUp/9vXTidIxVHY9Z72kzfDuGTvKJnUX2ev2Rj0
 hxT0xpBXQyi4PLWuO9HDuLPuTw0yUylNCAoQvxKmsEMKihehJ5OqwXWkg+DoOUjd/cirVVzhPO
 TUDCfCzPX5gXfhPRhm72jMnOgjpRXm2xUqZ7PnV9p3S7aS1g==
X-Spam-Status: No, score=-10.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,KAM_NUMSUBJECT,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Fri,  7 Jun 2024 17:37:24 +0100
Jon Turney wrote:
> w32api 12.0.0 adds the returns_twice attribute to RtlCaptureContext().
> There's some data-flow interaction with using it inside a while loop
> which causes a maybe-uninitialized warning.
> 
> ../../../../winsup/cygwin/exceptions.cc: In member function 'int _cygtls::call_signal_handler()':                                                                                                │
> ../../../../winsup/cygwin/exceptions.cc:1720:33: error: '<anonymous>' may be used uninitialized in this function [-Werror=maybe-uninitialized]                                                   │
> ---
>  winsup/cygwin/exceptions.cc | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/winsup/cygwin/exceptions.cc b/winsup/cygwin/exceptions.cc
> index a2a6f9d4c..28d0431d5 100644
> --- a/winsup/cygwin/exceptions.cc
> +++ b/winsup/cygwin/exceptions.cc
> @@ -1717,7 +1717,10 @@ _cygtls::call_signal_handler ()
>  		 context, unwind to the caller and in case we're called
>  		 from sigdelayed, fix the instruction pointer accordingly. */
>  	      context.uc_mcontext.ctxflags = CONTEXT_FULL;
> +#pragma GCC diagnostic push
> +#pragma GCC diagnostic ignored "-Wmaybe-uninitialized"
>  	      RtlCaptureContext ((PCONTEXT) &context.uc_mcontext);
> +#pragma GCC diagnostic pop
>  	      __unwind_single_frame ((PCONTEXT) &context.uc_mcontext);
>  	      if (stackptr > stack)
>  		{
> -- 
> 2.45.1

It seems that the commit message include non UTF-8 chars.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
