Return-Path: <SRS0=oHIC=ET=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e07.mail.nifty.com (mta-snd-e07.mail.nifty.com [106.153.226.39])
	by sourceware.org (Postfix) with ESMTPS id 4BB694BA2E0F
	for <cygwin-patches@cygwin.com>; Tue, 23 Jun 2026 01:16:06 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 4BB694BA2E0F
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 4BB694BA2E0F
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.226.39
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1782177367; cv=none;
	b=NchrTTd05a+rMfsboBDFXQJ5oJ2Vlj7AQBcbwGxz9YoBm+PPs5lW6zmRWcOrX94BfHlB6IfuoFIHxiPpgjwQQWUBONplRXPD+eHuJL5eLRB7Ej0scrV90N1B6Pt7W75G0vYW+OO7mAlz0AI40fFQ+OOXBoF2oM3+iJdvHKG0Eq0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1782177367; c=relaxed/simple;
	bh=3r+55ojxUfdyjY3uZ4OlaDPOjMxeg6VxZdKPj6UZGLA=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=hEtREKLE+S46meud8Eb+hvX12eK88w0+v2ajMHJNcfToW/jZBfCgqUfQJHwBi4udPOSIcZl6u0WE01gZuytXA7C1DwozGU8TPj0xdfiA1yhGFcI0sR+IUxOoWwvEYe0jaQvoCbMs8QpPi1YP4U/654gkyg9iMsMHHWZxMdJEfuA=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=X7NwSzHG
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 4BB694BA2E0F
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=X7NwSzHG
Received: from HP-Z230 by mta-snd-e07.mail.nifty.com with ESMTP
          id <20260623011601935.SDI.17441.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Tue, 23 Jun 2026 10:16:01 +0900
Date: Tue, 23 Jun 2026 10:16:01 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Do not set input_available_event when
 applying line_edit()
Message-Id: <20260623101601.473c7ba53f07605a3577d98d@nifty.ne.jp>
In-Reply-To: <fc159923-bb9c-46cd-b633-23f56a7c2fad@maxrnd.com>
References: <20260608133414.1979-1-takashi.yano@nifty.ne.jp>
	<fc159923-bb9c-46cd-b633-23f56a7c2fad@maxrnd.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1782177362;
 bh=adaKAHccRuH40KNH50LIHu8t/+yYWQ7OQjI2YJ4tFv8=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=X7NwSzHGWQoYhT0z8ejjI+0vxLUlSA/MOQn+1EDJQqHuwQ58DvdazPhCSwk3aaaassaKFo6x
 54T/PD1KUdK2eX//o4Flt0YXfB/6UG2cC2pu8JP5yVL2DSGlgwFmkaW0W4l8HrJRMvRz32ke3l
 J8p6i1yddWRJtbWbp/eREm5YHmoH4AITB1pB7yyqNOLmWybq2p3gUPfti2pi2ck2f955iutnm1
 GtCgD147ocbSsFmfD4iS6PT2XxGjiuDyEYc9UAi+uJwGBOjhn7CkxHf4Z0nGTp2H4zzehcOD5h
 s3SYkatg2mVuqtS64lpyp7QXTeNrF/m7su/zmDc304Nls9Kg==
X-Spam-Status: No, score=-12.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Sat, 20 Jun 2026 23:45:29 -0700
Mark Geisert wrote:
> Hi Takashi,
> 
> On 6/8/2026 6:34 AM, Takashi Yano wrote:
> > The commit a0b38a81b9be sets input_available_event even if the
> > transferred input is still in the readahead buffer and is not ready
> > to read. The SetEvent() is called in accept_input() via line_edit(),
> > so setting this event here is not correct. This causes the issue
> > that read() returns 0 instead of blocking until accept_input() is
> > called. This patch removes this SetEvent() call.
> > 
> > Fixes: a0b38a81b9be ("Cygwin: pty: Apply line_edit() for transferred input to to_cyg")
> > Addresses: https://cygwin.com/pipermail/cygwin/2026-June/259776.html
> > Reported-by: Koichi Murase <myoga.murase@gmail.com>
> > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > Reviewed-by:
> > ---
> >   winsup/cygwin/fhandler/pty.cc | 1 -
> >   1 file changed, 1 deletion(-)
> > 
> > diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
> > index 80331c36d..2558fa799 100644
> > --- a/winsup/cygwin/fhandler/pty.cc
> > +++ b/winsup/cygwin/fhandler/pty.cc
> > @@ -2946,7 +2946,6 @@ fhandler_pty_master::apply_line_edit_to_transferred_input ()
> >         n -= ret;
> >         p += ret;
> >       }
> > -  SetEvent (input_available_event);
> >   }
> >   
> >   static DWORD
> 
> LGTM.  OK to push.

Thanks! Pushed.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
