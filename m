Return-Path: <SRS0=qDft=7V=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e01.mail.nifty.com (mta-snd-e01.mail.nifty.com [IPv6:2001:268:fa04:731:6a:99:e2:21])
	by sourceware.org (Postfix) with ESMTPS id CA3974BA2E26
	for <cygwin-patches@cygwin.com>; Fri, 16 Jan 2026 12:06:54 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org CA3974BA2E26
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org CA3974BA2E26
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2001:268:fa04:731:6a:99:e2:21
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1768565215; cv=none;
	b=uMnwbyjlMxjSPFlAPWK7a6KV+F7nqPdcL4N89taQmAphDtiO4drqXM4nL9Xo2A8S4O4N6SMBBLdvxFdUPCQDpevtmoT+HRsaYAVNr1L6q2KU7lH0h9mR+gcKySUMD0RCMmn7xRRf1UhEqZhI1gHYch9DAztyojIu2RbunSvBysQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1768565215; c=relaxed/simple;
	bh=thy5dsCkz9VEdBd5iHdUdt1iUmCwH5zSHanzlywoyM0=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=YDeDHzbvYvCkI8GFqJyEWUitOO4oe5EGjC+/FsKFrYa65Xutd2Uu96te5xRlRfQqkwDa6gtu2wUnjm/3MxIZcYsD9sLcSHie/QRpTmuioS3rgnIg3MKYJmZPj/OwMFJBt5TcvSI6Ub1+LhEh2FNLn0yAo25y+Du0edhV8+yN0hw=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org CA3974BA2E26
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=l7EmJ9pY
Received: from HP-Z230 by mta-snd-e01.mail.nifty.com with ESMTP
          id <20260116120651802.MMBS.62593.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Fri, 16 Jan 2026 21:06:51 +0900
Date: Fri, 16 Jan 2026 21:06:48 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: c32rtomb: add missing check for invalid UNICODE
 character
Message-Id: <20260116210648.5694be02d12eec44f11ff24b@nifty.ne.jp>
In-Reply-To: <aWofIqlGYp8JitfB@calimero.vinschen.de>
References: <20260114223106.828985-1-corinna-cygwin@cygwin.com>
	<20260116200909.ebab69522f9e11445584e647@nifty.ne.jp>
	<aWofIqlGYp8JitfB@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1768565211;
 bh=PFU0O5n8SoM+cwWlqL7Wov1x7xqtqE5ra4oQWuDB7w0=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=l7EmJ9pYporQHmPrvHirqcKiytHZ9nkUqlyQ72y2sCN1p6pwVkVIhoWu8xjZYFr8lCakZwUT
 MlqhRc31y9MeYShqF88wW6vvWRBXuSG9gCjRUkVzYCoGeR+16A0zvGgx/QqbNQ9sTHpfHI1CdE
 kLfy2Le3/SXJBn3grDNauCq7CzJwTzVu5ioDnPpkq8iuExGVQPJlvgP53mGdQRbAZY89aGSgOf
 DLurOBJ78cyrCvkKX2SLUSx/o4xfYq+ekiAlsjOzSCcguA0qreKKN6/n0rIHz+YqvyqzOIWjev
 2Ph1+UH+N21W6Y3Vw6WOJUg+sE+waZAfjIN4TSCtvXTn6OLQ==
X-Spam-Status: No, score=-11.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Fri, 16 Jan 2026 12:21:06 +0100
Corinna Vinschen <corinna-cygwin@cygwin.com> wrote:

> On Jan 16 20:09, Takashi Yano wrote:
> > On Wed, 14 Jan 2026 23:31:06 +0100
> > Corinna Vinschen wrote:
> > > From: Corinna Vinschen <corinna@vinschen.de>
> > > 
> > > c32rtomb neglects to check the input character for being outside
> > > the valid UNICODE planes.  It happily converts the invalid character
> > > into a valid (but wrong) surrogate pair and carries on.
> > > 
> > > Add a check so characters beyond 0x10ffff are not converted anymore.
> > > Return -1 with errno set to EILSEQ instead.
> > > 
> > > Fixes: 4f258c55e87f ("Cygwin: Add ISO C11 functions c16rtomb, c32rtomb, mbrtoc16, mbrtoc32.")
> > > Signed-off-by: Corinna Vinschen <corinna@vinschen.de>
> > > ---
> > >  winsup/cygwin/release/3.6.7 | 5 +++++
> > >  winsup/cygwin/strfuncs.cc   | 7 +++++++
> > >  2 files changed, 12 insertions(+)
> > >  create mode 100644 winsup/cygwin/release/3.6.7
> > > 
> > > diff --git a/winsup/cygwin/release/3.6.7 b/winsup/cygwin/release/3.6.7
> > > new file mode 100644
> > > index 000000000000..defe55ffe75e
> > > --- /dev/null
> > > +++ b/winsup/cygwin/release/3.6.7
> > > @@ -0,0 +1,5 @@
> > > +Fixes:
> > > +------
> > > +
> > > +- Guard c32rtomb against invalid input characters.
> > > +  Addresses a testsuite error in current gawk git master.
> > > diff --git a/winsup/cygwin/strfuncs.cc b/winsup/cygwin/strfuncs.cc
> > > index eb6576051d90..0cf41cefc8a2 100644
> > > --- a/winsup/cygwin/strfuncs.cc
> > > +++ b/winsup/cygwin/strfuncs.cc
> > > @@ -146,6 +146,13 @@ c32rtomb (char *s, char32_t wc, mbstate_t *ps)
> > >      if (wc <= 0xffff || !s)
> > >        return wcrtomb (s, (wchar_t) wc, ps);
> > >  
> > > +    /* Check for character outside valid UNICODE planes */
> > > +    if (wc > 0x10ffff)
> > > +      {
> > > +	_REENT_ERRNO(_REENT) = EILSEQ;
> > > +	return (size_t)(-1);
> > > +      }
> > > +
> > >      wchar_t wc_arr[2];
> > >      const wchar_t *wcp = wc_arr;
> > >  
> > > -- 
> > > 2.52.0
> > 
> > LGTM.
> 
> THanks
> 
> > What does this change address for?
> 
> I mentioned it above in the release/3.6.7 entry, a testsuite error in
> gawk git master.  It checks the input functions with invalid input and
> this uncovered the missing EILSEQ handling in c32rtomb.

Oh! I overlooked that. Thanks for the explanation.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
