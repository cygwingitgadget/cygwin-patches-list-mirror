Return-Path: <SRS0=diAQ=HK=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w05.mail.nifty.com (mta-snd-w05.mail.nifty.com [IPv6:2001:268:fa30:831:6a:99:e3:25])
	by sourceware.org (Postfix) with ESMTPS id D6E284BA23E6
	for <cygwin-patches@cygwin.com>; Fri, 18 Sep 2026 11:27:48 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D6E284BA23E6
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org D6E284BA23E6
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2001:268:fa30:831:6a:99:e3:25
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1789730870; cv=none;
	b=L0xFFCb3nkINcCj8z6vt9oiJYbcat2m3nn01ZohEqzG1y1bLr17lpd4FnkTYWRdCr0ZlEqdPdbQRAm9gvuaCQeLLIfxGN6cJQBxgYvae1Ke7jptLmqrpyaGMQ5h9uLWTpJUCU30XSp4AB6s68+2P8nZwmF21tDYQR4m65qcVkjc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1789730870; c=relaxed/simple;
	bh=oHJq3lRLrJPwyBcBgTkpDLeJf1XULC6q/GO8lNQCH+g=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=onoMJcWp/Y4yPBx/tC1wk/L84Y0Lc6T3dfa9OfutPx//zXxyNt7QGQJbvMutkZ3uaKQOozW/04av4RikGr070qKm70RhZXwGQNKKxq2A/EvCWO/2bD4tpoMsU65Wm545nHAETgoBv1ba1Pbt/Pvdrkt5BHeU8wgc1Ky1svzxxWQ=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=j/459U47
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D6E284BA23E6
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=j/459U47
Received: from HP-Z230 by mta-snd-w05.mail.nifty.com with ESMTP
          id <20260918112745760.YTQJ.117312.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Fri, 18 Sep 2026 20:27:45 +0900
Date: Fri, 18 Sep 2026 20:27:43 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: clipboard: Handle ERROR_SYS_KEY_NOT_FOUND and
 NO_ERROR
Message-Id: <20260918202743.c52b1bb3ce7317cd56a25657@nifty.ne.jp>
In-Reply-To: <222ce10a-2691-47b0-8fc3-ed915267b7fd@maxrnd.com>
References: <20260918013226.1205-1-takashi.yano@nifty.ne.jp>
	<222ce10a-2691-47b0-8fc3-ed915267b7fd@maxrnd.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1789730865;
 bh=Lj95sCOCuoOteiqfeUMkeCNAyt7yxA36nn6MH3VMwTw=;
 h=Date:From:To:Subject:In-Reply-To;
 b=j/459U47+HrYCXD/MAIoXafhPpxXWWCJ+SEoU1XI4chNDdlgA7vCjacT52XvR9S+54n4Qgyv
 7s33KGzch9+fEBKPBnPiAM6PwVOJYKiP1F66Lf7pAUN4JP0PKmGwnkoUyu4h/Y+UmPwYAjVQOA
 KxAJ7+DDUEwWplaDgrhUVU5AE7fI8h+Oh/rGbJ0FGfolbV575dUMzF5wxO+EaAhNJsxxO4IRdE
 Zzgsf+o94svaOlM/AzC10RsWZP5cTnyr6dRms/au40gDA80jz0Y7Vw1P8TXXnQZDwzaz+xoe5P
 1aRIaKYoJR2FV21hxEleluQdBm49Tv++C8x28UxK/ECmFSyQ==
X-Spam-Status: No, score=-10.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Mark,

Thansk for reviewing!

On Fri, 18 Sep 2026 02:13:10 -0700
Mark Geisert wrote:
> Hi Takashi,
> 
> On 9/17/2026 6:32 PM, Takashi Yano wrote:
> > Windows 10 seems to return ERROR_SYS_KEY_NOT_FOUND instead of
> > ERROR_NOT_FOUND. In addition, it returns NO_ERROR even though
> > GetClipboardData() returns NULL. This patch handles these cases.
> > 
> > Addresses: https://cygwin.com/pipermail/cygwin/2026-September/260058.html
> > Fixes: 7fd670a36b9a ("Cygwin: clipboard: Add workaround for ERROR_CLIPBOARD_NOT_OPEN")
> > Reported-by: Shun <shun1048576@gmail.com>
> > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > Reviewed-by:
> > ---
> >   winsup/cygwin/fhandler/clipboard.cc | 5 ++++-
> >   1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/winsup/cygwin/fhandler/clipboard.cc b/winsup/cygwin/fhandler/clipboard.cc
> > index 116feb599..391f21051 100644
> > --- a/winsup/cygwin/fhandler/clipboard.cc
> > +++ b/winsup/cygwin/fhandler/clipboard.cc
> > @@ -41,7 +41,10 @@ open_clipboard ()
> >   	  DWORD err = GetLastError ();
> >   	  /* Here, ERROR_NOT_FOUND means the clipboard does not contains
> >   	     valid CF_UNICODETEXT. OpenClipboard() must have succeeded. */
> > -	  if (err == ERROR_NOT_FOUND)
> > +	  /* In Windows 10, ERROR_SYS_KEY_NOT_FOUND or NO_ERROR seem
> > +	     to be returned instead of ERROR_NOT_FOUND. */
> > +	  if (err == ERROR_NOT_FOUND || err == ERROR_SXS_KEY_NOT_FOUND
> > +	      || err == NO_ERROR)
> >   	    return true;
> >   	  CloseClipboard ();
> >   	  if (err != ERROR_CLIPBOARD_NOT_OPEN)
> 
> The patch LGTM as long as you fix spelling of ERROR_SYS_KEY_NOT_FOUND.
> 
> It belatedly occurs to me it might be nice to report the error somewhere 
> if it's not one of the ones we check for.  Use debug_printf() for that 
> if you decide to do this.  I understand the OP is running an LTSC 
> version of Windows 10 which will likely diverge from EOL'd Windows 10 as 
> time goes on (since the latter may be getting updates).

According to Gemini, returning NO_ERROR when no matching data
is not found, is a historical (traditional?) behaviour of Windows.
I confirmed it also happen in Windows 7.

I'll push the patch with typo fix (SYS->SXS).
Thanks!

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
