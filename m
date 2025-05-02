Return-Path: <SRS0=mLRr=XS=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [106.153.227.117])
	by sourceware.org (Postfix) with ESMTPS id CAAB33858D20
	for <cygwin-patches@cygwin.com>; Fri,  2 May 2025 12:38:47 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org CAAB33858D20
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org CAAB33858D20
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.117
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1746189528; cv=none;
	b=K/CpTmzmM2kzN68tPv/GL0Q4TPvw99W6gHyXhwFVhz2dIs183H3K8N63U3KYkCTejAw8yNYhVQFyRH46RiTiPSS2LZ4AI0hVuJhFdorIqHHPHentD3to5GN48dU2vwtcAwI60zMaEBBh6E2bjA4yZKuvTrwt3tTVFcFvgxS6syI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1746189528; c=relaxed/simple;
	bh=TXJUF4khGqW0gzCLAPksS8sbAK2wvBcvUB3kLQBFRXQ=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=C1F2GNcRUmcorAuc1yQO+Takh9HXVsJ2di0GGdZoTz9JzeQ6InBwyCAJB5TImKDsdHcM2Mrk1Fy3IBlihLzvGjU0f5ii53GWBHxfa4Ht62J3KYgEPnL+gmk0WvFUD50KCWS7zH0fQRLHBRRSkcwzekJ1EXiTxTLeyWzWfQJX60M=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org CAAB33858D20
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=n7p0Wavv
Received: from HP-Z230 by mta-snd-e05.mail.nifty.com with ESMTP
          id <20250502123845879.OXXK.36235.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Fri, 2 May 2025 21:38:45 +0900
Date: Fri, 2 May 2025 21:38:45 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: cygwin_conv_path: don't write to `to` before
 size is validated.
Message-Id: <20250502213845.09a2c59e1ec9665bdd39840c@nifty.ne.jp>
In-Reply-To: <69d84bb5-fdfd-47a2-aea7-dccdf5ac2414@dronecode.org.uk>
References: <bd0e9cdd-ba1f-423b-089c-7f84e5e8bb3f@jdrake.com>
	<69d84bb5-fdfd-47a2-aea7-dccdf5ac2414@dronecode.org.uk>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1746189525;
 bh=rVPjzGPibe7wK1A8orTCvCeyV5iPwbeFCtVvCSf7caU=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=n7p0WavvyH0ZKoKxeYZdOuZWY0OjcxpZY9osiclM3W93f/+WXtWR0HF08YoUWPBtQrFqoN5A
 /U6gmgUq0VP+yQTiebKUqCk++fVtBkRYoVVJNTCzwu99Ot4Y6Q1MUfzJFRejpXxEZ1bPRuGRmp
 ArSLd7X4NQXEQOmtw6o8vJJQqn6e0rLGs7kaJOTjkXe9Z/fSnA+QcNSLbfDaJKvoMrOD88ALV9
 S/5XsqFmiyv7U8v8xxJuWLM48WCqGQknZmHpf8dFVViqBENISYQtEdMeK0i5Uf/IN3gupdl3h+
 Gav5Epgwvu72U1uhEHVnyijUhte2ui6qZNsBraDlhHBgTdmQ==
X-Spam-Status: No, score=-10.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Thu, 1 May 2025 12:55:40 +0100
Jon Turney <wrote:
> On 29/04/2025 18:42, Jeremy Drake via Cygwin-patches wrote:
> > In the CCP_POSIX_TO_WIN_W path, when `from` is a device,
> > cygwin_conv_path would attempt to write to the `to` buffer before the
> > validation of the `size`.  This resulted in an EFAULT error in the
> > common use-case of passing `to` as NULL and `size` as 0 to get the
> > required size of `to` for the conversion (as used in
> 
> This is clearly not what's wanted! Thanks for fixing this!

Pushed.

> > cygwin_create_path).  Instead, set a boolean and write to `to`
> > after validation.
> > 
> > Fixes: 43f65cdd7dae ("* Makefile.in (DLL_OFILES): Add fhandler_procsys.o.")
> > Addresses: https://cygwin.com/pipermail/cygwin/2025-April/258068.html
> > Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
> > ---
> >   winsup/cygwin/path.cc       | 5 ++++-
> >   winsup/cygwin/release/3.6.2 | 3 +++
> >   2 files changed, 7 insertions(+), 1 deletion(-)
> > 
> > diff --git a/winsup/cygwin/path.cc b/winsup/cygwin/path.cc
> > index 7a08e978ad..d26f99ee7f 100644
> > --- a/winsup/cygwin/path.cc
> > +++ b/winsup/cygwin/path.cc
> > @@ -3911,6 +3911,7 @@ cygwin_conv_path (cygwin_conv_path_t what, const void *from, void *to,
> >     int how = what & CCP_CONVFLAGS_MASK;
> >     what &= CCP_CONVTYPE_MASK;
> >     int ret = -1;
> > +  bool prependglobalroot = false;
> > 
> >     __try
> >       {
> > @@ -4019,7 +4020,7 @@ cygwin_conv_path (cygwin_conv_path_t what, const void *from, void *to,
> >   	    {
> >   	      /* Device name points to somewhere else in the NT namespace.
> >   		 Use GLOBALROOT prefix to convert to Win32 path. */
> > -	      to = (void *) wcpcpy ((wchar_t *) to, ro_u_globalroot.Buffer);
> > +	      prependglobalroot = true;
> 
> It seems like this could all be done in-place in .Buffer here, but I'm 
> going to defer to Corinna on if that's at all clearer...
> 
> >   	      lsiz += ro_u_globalroot.Length / sizeof (WCHAR);
> >   	    }
> >   	  /* TODO: Same ".\\" band-aid as in CCP_POSIX_TO_WIN_A case. */
> > @@ -4075,6 +4076,8 @@ cygwin_conv_path (cygwin_conv_path_t what, const void *from, void *to,
> >   	  stpcpy ((char *) to, buf);
> >   	  break;
> >   	case CCP_POSIX_TO_WIN_W:
> > +	  if (prependglobalroot)
> > +	    to = (void *) wcpcpy ((PWCHAR) to, ro_u_globalroot.Buffer);
> >   	  wcpcpy ((PWCHAR) to, path);
> >   	  break;
> >   	}
> > diff --git a/winsup/cygwin/release/3.6.2 b/winsup/cygwin/release/3.6.2
> > index bceabcab34..de6eae13fc 100644
> > --- a/winsup/cygwin/release/3.6.2
> > +++ b/winsup/cygwin/release/3.6.2
> > @@ -13,3 +13,6 @@ Fixes:
> > 
> >   - Fix setting DOS attributes on devices.
> >     Addresse: https://cygwin.com/pipermail/cygwin/2025-April/257940.html
> > +
> > +- Fix cygwin_conv_path writing to 'to' pointer before size is checked.
> > +  Addresses: https://cygwin.com/pipermail/cygwin/2025-April/258068.html
> 
> 
> Seems like this should also touch:
> 
> https://cygwin.com/cygwin-api/func-cygwin-conv-path.html
> 
> (source in winsup/doc/path.xml)
> 
> 
> I'm not sure what the conventional language to use for this common 
> behaviour:
> 
> "If size is 0, (to is ignored|to can be NULL) and cygwin_conv_path just 
> returns the required buffer size in bytes" ?

Jon,
Could you please check if the patch
https://cygwin.com/pipermail/cygwin-patches/2025q2/013694.html
from Jeremy is as you intended?

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
