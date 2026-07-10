Return-Path: <SRS0=W86w=FE=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w10.mail.nifty.com (mta-snd-w10.mail.nifty.com [106.153.227.42])
	by sourceware.org (Postfix) with ESMTPS id B1D874BA2E07
	for <cygwin-patches@cygwin.com>; Fri, 10 Jul 2026 13:27:37 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B1D874BA2E07
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org B1D874BA2E07
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.227.42
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1783690058; cv=none;
	b=c2nuOkuJKH64CNoeLcfN1IaghR11CCHz0nkqnWe3I/s4Cb3VOae9cawrxXUvner/4ecZXUykhFaqUo+5Y0cGsC0rYTlI1FkupgMwWVHeIX3v55aopCxV66EpfAfuriznhM+YJgiXjIYNFOIa6xC6Jm3g0yfnCEp9aouNYk7zwzI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1783690058; c=relaxed/simple;
	bh=HntdnRFjRXFoBzAjnjeopWF/14l9PGI9q3J9R+DCLj4=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=GlSpe9050ihls+BTDnHIK2Nrxbe8ZhPw+beIWbAI60KOAZzgUO2T1y32RNelZELxqtgHGjypgodhGogr63n33QOlHDia+HSqtb6sl+gDX8QS085n0FJ9P8nS+IzkGU8/nqO/MbEUSVWb5u7Py3CSxlz0JJN/wedQUvs/8BfLnZs=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=Fic0o00d
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org B1D874BA2E07
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=Fic0o00d
Received: from HP-Z230 by mta-snd-w10.mail.nifty.com with ESMTP
          id <20260710132735672.YXX.44671.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Fri, 10 Jul 2026 22:27:35 +0900
Date: Fri, 10 Jul 2026 22:27:33 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: Fix error return for madvise()
Message-Id: <20260710222733.50882151e5f8f33933a6bd73@nifty.ne.jp>
In-Reply-To: <09ff62ce-42fd-f331-b541-c26af487a213@t-online.de>
References: <https://cygwin.com/pipermail/cygwin-patches/2026q3/015163.html>
	<20260708080349.570-1-mark@maxrnd.com>
	<dbe2155d-198f-76a8-13ae-924001cdf1b1@t-online.de>
	<77c47130-8a2f-4de0-ac6d-d80480bdbf20@maxrnd.com>
	<09ff62ce-42fd-f331-b541-c26af487a213@t-online.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1783690055;
 bh=yUOppZh0d90F9HxxyF1i+w43Qtgp5SGmzT8A4huOZxg=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=Fic0o00dU4xToYOczVAuPrSRnBTESTpbWdVahu8Peymwzpj7GPMF739Rp4qmnG0yyPAmNr/N
 R9iAMi/xHyBaH0vvqh7TFHR6uf638v53/PwZLYXtQCl5EHq5Mx2NlTGOVfhZNCx6f+0mqcdbdP
 j8Z3Pr0lEVyCLft2gp5be9WkWPpYJYj8JgEwrWg6PBzhBSniZ5+Djg1Wv3X5QFwLhgn3lqV5of
 hIW12jAhZv4HVCdsfEaXed3V4KdnxElIpRNIrdp7s2hTXHzyDTaYakPcc/G8lqoh1XRTF/uMfm
 tQnQqRkvcuwMeOqy99Bi+hGvcjWyzAYCdwVZhaElJ8vqfVJQ==
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,BODY_8BITS,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Christian,

On Fri, 10 Jul 2026 13:13:43 +0200
Christian Franke wrote:
> Hi Mark,
> 
> Mark Geisert wrote:
> > Hi Christian,
> >
> > On 7/8/2026 7:58 AM, Christian Franke wrote:
> >> Mark Geisert wrote:
> >>> Currently madvise() and posix_madvise() are wired together as one
> >>> function: the latter.  But their error returns should be different.
> >>> Make madvise a first-class export in cygwin.din.
> >>>
> >>> v2: Create madvise_worker() and have madvise() and posix_madvise()
> >>>      call it, then handling their error returns compliant to POSIX.
> >>>      Add a release note for 3.7.0.
> >>
> >> LGTM, thanks!
> >>
> >>
> >>> ...
> >>> -extern "C" int
> >>> -posix_madvise (void *addr, size_t len, int advice)
> >>> +static int
> >>> +madvise_worker (void *addr, size_t len, int advice)
> >>>   {
> >>>     int ret = 0;
> >>>     /* Check parameters. */
> >>> @@ -1514,6 +1514,26 @@ posix_madvise (void *addr, size_t len, int 
> >>> advice)
> >>>         break;
> >>>       }
> >>>   out:
> >>> +  return ret;
> >>> +}
> >>
> >> PS: The 'goto out' could now be replaced by 'return ref'.
> >
> > I prefer to keep both 'goto out' so there's just one exit from the 
> > function to aid future debugging. Perhaps that's an old-school habit.
> 
> :-)
> 
> Don't take me wrong, the patch is GTG, IMO.

I agree. Would you push the patch? 


-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
