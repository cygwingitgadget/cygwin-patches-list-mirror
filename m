Return-Path: <SRS0=y1f5=EJ=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w07.mail.nifty.com (mta-snd-w07.mail.nifty.com [106.153.227.39])
	by sourceware.org (Postfix) with ESMTPS id 021D34BA79AC
	for <cygwin-patches@cygwin.com>; Sat, 13 Jun 2026 02:40:25 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 021D34BA79AC
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 021D34BA79AC
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.227.39
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1781318426; cv=none;
	b=ZC0mDCNbTzJ5McLtsEMXtggT0Lu1EPHb/6J0v+F8APjUjb5A/OacfhBO1gSaU22FbMjjg2vfkgcVA+AAmj3VSwj/I0wcBz9noX5imbFDTVQOoU4WioEOA5qxbLgpWJ3HjOmYMYLZ3niYXq8DpXqi7/7LhBOeOuhhnJaPDGOAcHM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1781318426; c=relaxed/simple;
	bh=4eTOSTVXPURM8pyNCbPp54pmxuMfuzWYGf2H06mejJE=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=guHr4v3REFwiomaes41coVvNf6H99LcU/harfnVFNKVK+4jD25GDSUWD8e+86/Zqy9/FZSJi/laitBf1iOWgVGr8+e2jcwKmH55Hw2U29Yrh3RT4sRdtiJVazrwWraT9bhN1Bk7EMW+f1wEKt5kW2b1HkMqs8wQw7n5UwAcAqm0=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=VMBSTvyQ
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 021D34BA79AC
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=VMBSTvyQ
Received: from HP-Z230 by mta-snd-w07.mail.nifty.com with ESMTP
          id <20260613024023280.GSHV.18412.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Sat, 13 Jun 2026 11:40:23 +0900
Date: Sat, 13 Jun 2026 11:40:22 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: clipboard: Add workaround for
 ERROR_CLIPBOARD_NOT_OPEN
Message-Id: <20260613114022.cf16af16e97614471353207d@nifty.ne.jp>
In-Reply-To: <0fcb54fd-6369-4904-ad97-26882cf151f9@maxrnd.com>
References: <20260609002100.615-1-takashi.yano@nifty.ne.jp>
	<0fcb54fd-6369-4904-ad97-26882cf151f9@maxrnd.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1781318423;
 bh=Wyw3xo7KZpQ+TsYP/wTE/J6gNYKKXFgaq741BCyXTfo=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=VMBSTvyQ0P4UFW2kh0UcEAOhje2zItKI/vpG8AiRccOvzlqmJBP9iF7PW2dXeqLq0MG1kwLF
 eEgT0ToEiNpDAQMc51go6QFcd5WCT9vLKFIHAThl3IGsJ2u0hqphHcEtiAYTVTTjNQaqKnoevG
 Z/TqODxWcuIfvGj1qtNupR1bU0wWayNYF1A44RJlCKVQNUDCR6aClVVexoR+LX7Th/qxFZdDDz
 YMCldoyCf51IpzB6gevefPQUQJm7CGTfOJ7nivqxQRwegWag3ag4gmaa51uUTkr6nesrWI2ceQ
 fkENGP6CaHKwWUyH1rcWeLUIpEb5SbzeobxczTvMoYfdD8xg==
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Mark,

Thanks for reviewing!

On Fri, 12 Jun 2026 16:08:24 -0700
Mark Geisert <mark@maxrnd.com> wrote:

> Hi Takashi,
> 
> On 6/8/2026 5:20 PM, Takashi Yano wrote:
> > SetClipboard/Data() and GetClipboardData() occasionally fail with
> > ERROR_CLIPBOARD_NOT_OPEN, even though OpenClipboard() succeeded if
> > NULL HWND is used. Retry until GetClipboardData() does not return
> > ERROR_CLIPBOARD_NOT_OPEN.
> > 
> > Addresses: https://cygwin.com/pipermail/cygwin/2026-February/259438.html
> > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > Reviewed-by: Mark Geisert <mark@maxrnd.com>
> 
> Sorry, I didn't read ^^^ as a request to review, and then forgot to ask 
> about it...

I didn't mean that. I think this was the first review.
https://cygwin.com/pipermail/cygwin/2026-February/259449.html

> 
> > ---
> >   winsup/cygwin/fhandler/clipboard.cc | 14 ++++++++++++--
> >   1 file changed, 12 insertions(+), 2 deletions(-)
> > 
> > diff --git a/winsup/cygwin/fhandler/clipboard.cc b/winsup/cygwin/fhandler/clipboard.cc
> > index 12691c7c1..db33d839f 100644
> > --- a/winsup/cygwin/fhandler/clipboard.cc
> > +++ b/winsup/cygwin/fhandler/clipboard.cc
> > @@ -25,11 +25,21 @@ details. */
> >   static inline bool
> >   open_clipboard ()
> >   {
> > -  const int max_retry = 10;
> > +  const int max_retry = 20;
> >     for (int i = 0; i < max_retry; i++)
> >       {
> > +      /* No appropriate HWND exists here. */
> >         if (OpenClipboard (NULL))
> > -	return true;
> > +	{
> > +	  /* SetClipboard/Data() and GetClipboardData() occasionally
> > +	     fail with ERROR_CLIPBOARD_NOT_OPEN, even though
> > +	     OpenClipboard() succeeded if NULL HWND is used.
> > +	     Retry until GetClipboardData() does not return
> > +	     ERROR_CLIPBOARD_NOT_OPEN. */
> > +	  if (GetClipboardData (CF_UNICODETEXT)
> > +	      || GetLastError () != ERROR_CLIPBOARD_NOT_OPEN)
> > +	    return true;
> 
> I don't think this 'if' is quite right.  If GetClipboardData(...) 
> succeeds, return true.  Otherwise, if GetLastError() returns 
> ERROR_CLIPBOARD_NOT_OPEN, continue the loop.  Otherwise either break the 
> loop or return false right there.

Do you mean:
    if (GetClipboardData (CF_UNICODETEXT))
      return true;
    if (GetLastError () == ERROR_CLIPBOARD_NOT_OPEN)
      continue;
    return false;
?

> Do you agree with my reasoning?  I'm open to corrections.

What happnes if the clipboard does not have TEXT, e.g. CF_BITMAP?
I think GetClipboardData (CF_UNICODETEXT) fails with ERROR_NOT_FOUND.
Even in this case, we can call SetClipboardData() successfully.
So we shoud return true in this case.

BTW, I forgot to call CloseClipboard(). Check for ERROR_NOT_FOUND
also will be added. Please review v2 patch.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
