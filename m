Return-Path: <SRS0=y1f5=EJ=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [106.153.226.37])
	by sourceware.org (Postfix) with ESMTPS id 51EB74BA23D5
	for <cygwin-patches@cygwin.com>; Sat, 13 Jun 2026 07:33:15 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 51EB74BA23D5
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 51EB74BA23D5
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.226.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1781335996; cv=none;
	b=eP84m0/+L2JyWvNk7N2xU21pyutYWzBoNFXIB/GuqZi/X4+tdnVtf/m7qCjYyd+jgYtbdius1CHnOHgzTFJjSKh9nNag2qB8M6/1N2hKVATjH9/DkBWMJU/fLpHig+emwGSgTdPYA9nkDDh26dy4zgoj1A+hQlx8IICcVXtKEjE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1781335996; c=relaxed/simple;
	bh=YRKWNG37qNf/FqV5Xj6XFTgY6SoGaMTyquqps4sCvWo=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=tXlpT7LecoDDkNZod5dI0jEpf7bxlTKcy17MGXRdDezJartkBJtJ0YuvXGaeQUtZtnnwqBm8Atlz3kerB1x29VDrzU7LKtA+6rPHwo4dXcfBRQveVCGyGwUG0bmH4chohrXrTJVXip2nKgJdnT8MoWVM+sdUdX4s+56mO4bUPYc=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=jOo9LuMo
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 51EB74BA23D5
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=jOo9LuMo
Received: from HP-Z230 by mta-snd-e05.mail.nifty.com with ESMTP
          id <20260613073312795.RKSP.102121.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Sat, 13 Jun 2026 16:33:12 +0900
Date: Sat, 13 Jun 2026 16:33:11 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3] Cygwin: clipboard: Add workaround for
 ERROR_CLIPBOARD_NOT_OPEN
Message-Id: <20260613163311.e9e33c245bda88ebd4f1fe74@nifty.ne.jp>
In-Reply-To: <a141abf4-29f6-4259-bb10-d4f45a9996d1@maxrnd.com>
References: <20260613025412.642-1-takashi.yano@nifty.ne.jp>
	<a141abf4-29f6-4259-bb10-d4f45a9996d1@maxrnd.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1781335992;
 bh=ki4IQTSud3sGkVwHOQrbvITeLN1urhB/v3x4dL+VARw=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=jOo9LuMom9g+WCdJTjkFAaO/VvFvXMmxMTaRZE7tWeFg7X3tRJhGiUBpHhikxRCfSxq2N7G8
 B/MnuYu9cCM2B7doiE03YtBns/zUJq000S9inn/TC93ePq36+7nmFzxStu89qCtfs3K7LkDAI7
 YtH/L/KAoRGqIj/cKxWbSZYhsFbEr+dTSxK99gebJq1aqfiiM+nz3sWuaRxeYhaF4At6f2ZNwN
 NzflArWYnqDGQ/OrM3ewKDcGzVhOeykdiK69yWw/+DZHXlK4/h/pNjoxS+EbwmY59tHsM0EoEN
 T+ZukdulHL9tKkZtxBm40Zi0szqQiVAqJJHZwsUpGXYaCi5w==
X-Spam-Status: No, score=-12.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Fri, 12 Jun 2026 22:55:05 -0700
Mark Geisert wrote:
> Hi Takashi,
> 
> On 6/12/2026 7:54 PM, Takashi Yano wrote:
> > SetClipboardData() and GetClipboardData() occasionally fail with
> > ERROR_CLIPBOARD_NOT_OPEN, even though OpenClipboard() succeeded if
> > NULL HWND is used. Retry until GetClipboardData() does not return
> > ERROR_CLIPBOARD_NOT_OPEN.
> > 
> > Addresses: https://cygwin.com/pipermail/cygwin/2026-February/259438.html
> > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > Reviewed-by: Mark Geisert <mark@maxrnd.com>
> > ---
> > v2: Handle ERROR_NOT_FOUND case. Call CloseClipboard() in the loop.
> > v3: Change the timing of CloseClipboard().
> 
> Thanks for catching this ^^^ I was just about to mention it myself...
> 
> >   winsup/cygwin/fhandler/clipboard.cc | 19 +++++++++++++++++--
> >   1 file changed, 17 insertions(+), 2 deletions(-)
> > 
> > diff --git a/winsup/cygwin/fhandler/clipboard.cc b/winsup/cygwin/fhandler/clipboard.cc
> > index 12691c7c1..1273863f4 100644
> > --- a/winsup/cygwin/fhandler/clipboard.cc
> > +++ b/winsup/cygwin/fhandler/clipboard.cc
> > @@ -25,11 +25,26 @@ details. */
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
> > +	  /* SetClipboardData() and GetClipboardData() occasionally
> > +	     fail with ERROR_CLIPBOARD_NOT_OPEN, even though
> > +	     OpenClipboard() succeeded if NULL HWND is used.
> > +	     Retry until GetClipboardData() does not return
> > +	     ERROR_CLIPBOARD_NOT_OPEN. */
> > +	  if (GetClipboardData (CF_UNICODETEXT))
> > +	    return true;
> > +	  DWORD err = GetLastError ();
> 
> Given the ambiguity of "ERROR_NOT_FOUND" I would add a one-line comment 
> here saying ERROR_NOT_FOUND means GetClipboardData() couldn't find 
> CF_UNICODETEXT data, but it would return data if you ask for the correct 
> format. This latter case means the clipboard is indeed open. (Or some 
> briefer way of saying this complicated case.)
> 
> Hmm. Maybe more than one line for that comment. With that, patch is GTG.

Thanks! Pushed.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
