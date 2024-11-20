Return-Path: <SRS0=Uy4f=SP=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w09.mail.nifty.com (mta-snd-w09.mail.nifty.com [106.153.227.41])
	by sourceware.org (Postfix) with ESMTPS id C9CEB3858D20
	for <cygwin-patches@cygwin.com>; Wed, 20 Nov 2024 12:52:25 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C9CEB3858D20
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org C9CEB3858D20
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.41
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1732107147; cv=none;
	b=Pojbi3eZOofDV/zpEmbmqWY4C4zPmSik2Xlt8gtvreC6HyWzMAWwzWOJNqYf/mN91D0+51BAJI1/IX0rW97MpmRvrQcE0k795CbEOUNkddBgqMUUJXHXw6yW15PTCqnrB/ifvDVdQnn3OxDUpSYkBd53lQBWTyiBdTSaWS/U+Sg=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1732107147; c=relaxed/simple;
	bh=IZ2/NwTk0h2Vc5Wx+lgfoMzXJtIdpRJUXXJtAB5VIIE=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=US7YamCt8DhSAbyQlsafqTWMIZRJN6fW7Ji2K6xXiCCuV0yFODOrf6d/MiPiRLgX+bvX2GZ3nder10CsBVECn3xUcn1D122WIYi4LCONdo3YYgynckDYhhwcsaKeEPGVN4RNTSHNxR0spOlufTrPGG8eZb/7dv3bRN4SWjtSoho=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C9CEB3858D20
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=lSZYM2Gw
Received: from HP-Z230 by mta-snd-w09.mail.nifty.com with ESMTP
          id <20241120125223498.OEJE.107569.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Wed, 20 Nov 2024 21:52:23 +0900
Date: Wed, 20 Nov 2024 21:52:22 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/2] Cygwin: lockf: Fix access violation in
 lf_clearlock().
Message-Id: <20241120215222.8ff263bfd7c24cfbe9c64034@nifty.ne.jp>
In-Reply-To: <Zz0Ak0QKKPQdOxfJ@calimero.vinschen.de>
References: <20241115131422.2066-1-takashi.yano@nifty.ne.jp>
	<20241115131422.2066-2-takashi.yano@nifty.ne.jp>
	<ZztjYs4Cu28xZgtl@calimero.vinschen.de>
	<20241119173939.5ba0cb14459b3da22d226262@nifty.ne.jp>
	<ZzxfM9T2uy5Bdiao@calimero.vinschen.de>
	<20241119191302.9dea6a8aabb69727cdd3feb8@nifty.ne.jp>
	<Zz0Ak0QKKPQdOxfJ@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1732107143;
 bh=ty9zvRIzM6jI1EmcDepEQi2khmchr7rDj6Zm73nvcyM=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=lSZYM2GwXMXm+Lp6DJAYCP2DnjOh4Kr6EfCEKZ+2VdGBssUyijHwPChUyVUaQii273J44F7f
 VQ9d1kkSK+o6kgQzhcCuWyX9SmwWHkgtfUxoX9/MD+yA0vHlc5L2p+DOd3rqsKDd9wPZ5YDBdG
 63qMQPYFqBOh+0bgA0R3Jbv0cfNvRk6VXZ0tfFUQ0fIjAjOiuk8s9m/d2XXZchn/h0c2EYcClz
 PHN1YfXqqxhn6Sif1Fp1aRyq2hAwCGcIdE7o+/+LfdyBSBaqm4G/RHKj8DT/r6nlWqmXwK+1bp
 WjgVTtVctZ5fBkmM5LA1EjSkt7m/Sx8yweqZsgcdMgC12HDg==
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Tue, 19 Nov 2024 22:18:11 +0100
Corinna Vinschen wrote:
> On Nov 19 19:13, Takashi Yano wrote:
> > On Tue, 19 Nov 2024 10:49:39 +0100
> > Corinna Vinschen wrote:
> > > >  [PATCH v2] Cygwin: flock: Fix overlap handling in lf_setlock() and lf_clearlock()
> > > > as well?
> > > 
> > > Give me a bit of time.  While the patch might fix the problem, what
> > > bugs me is the deviation from upstream code.  We will at least need
> > > a few comments to explain why we don't follow the upstream behaviour.
> > 
> > I've got it. Does this code come from 'upstream'? From what code?
> 
> This was once ripped from FreeBSD code in 2008.  The upstream code
> has changed considerably, though, so I'm not so sure if my reluctance
> makes any sense.
> 
> > Essentially, the ovcase 1 can be a part of ovcase 3. I guess the
> > 'upstream' does not add lock entry having same lock range unlike
> > current cygwin (lf_ver related). So, ovcase 1 can break after
> > handling 1 overlap. However, we need find overlap repeatedly
> > because we have lf_ver.
> 
> Yeah, I get that.  What bugs me is that the structure of the upstream
> snippets changed, not the necessity for change.  For that reason alone,
> I would prefer that the `case 1:' expression stays where it is in
> lf_clearlock.  But that's unreasonable.
> 
> It's a puzzle of life that one thinks in 2008, that this upstream
> code will always stay what it is. A mere 16 years later...
> 
> Ok, never mind that.  Please push.  Maybe add a single-line comment
> why we deviate from the original 2008 FreeBSD code at these points.

Thanks for reviewing. Pushed.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
