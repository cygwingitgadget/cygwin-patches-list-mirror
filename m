Return-Path: <SRS0=0tR4=ZI=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	by sourceware.org (Postfix) with ESMTPS id 562463857B8F
	for <cygwin-patches@cygwin.com>; Wed, 25 Jun 2025 12:10:42 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 562463857B8F
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 562463857B8F
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=212.227.17.22
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750853442; cv=none;
	b=B5g0F1Xq7nT37U7E8NI5x+/zBUxB1jw7BFjSZcM3tMJoCErdEld6ByVOCnDmn/h7pM9iYLbA3Koou8XFU+aWpk0ywRgR3/EBtsbWzyW5Q2sdbYu1tfE4U10oZ9P6Jnkn5GNQveWB0RQCiPEZrgoSqNr+HU66P/xStUXvSiu5njg=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750853442; c=relaxed/simple;
	bh=1aPL/wNIGN8Uck4i9cq20vZw0RIqYDyUxo4lNRBfcL8=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=JDXjxhYwxjof5GxhrDeYGlUE3ouXYPwbmnmww4opbR+c510Ip+sT8O9+c2xH9uR3kBrj1MsQNFGya/jqEaFGFpMGL0cVf+LJbd9M7oowJQi1Oaispl/ONvrCcHrWrlivaj7cIa8QmOQVK6fKMZeVYvRl2o2/7SaqNHpdGAtplKA=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 562463857B8F
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=nQp9PpL+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1750853441; x=1751458241;
	i=johannes.schindelin@gmx.de;
	bh=RLE0HHx3d3buF/hxh9IoDWRFFqOJmhDze8VcTi56KoI=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=nQp9PpL+QUVIx/qRUsV3VebKcGDcxoz1wl33mCwXRwv46F7/8ZwCW1rSQ/vx5HNI
	 9dxSRhPTMhCQzjCU65yZSi5JtGTR/5n9Zt8mObmQJkLo07ikSaWy9wTNFtyCC2GGH
	 lIEIzGdFLR4GB1v/8Pkvjne9sqGCk2fssPHTIz1UFKdH1T6TPAPTuWpkggSofXR6/
	 oFS70ziO49wozlyHVs7UZb/g2fZh4QaRqMN9bF1/dl+eYZKSH8n1BhsoJbZJ6+/TC
	 Khu9DaAZdcMpjNnQOwtlgSKzr0a5zTnZOdgC+AJHraDDFe/QeTcSn09c9bsT9Dy6K
	 XkZatda0sCRpZKAPdQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.215.172]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MxlzC-1uflS23pk6-016sMW; Wed, 25
 Jun 2025 14:10:40 +0200
Date: Wed, 25 Jun 2025 14:10:39 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] pipe: fix SSH hang (again)
In-Reply-To: <20250625195534.dc322b8f310c7b1c0d3abd03@nifty.ne.jp>
Message-ID: <f0406c3d-3695-7743-b7a6-45bc11e75711@gmx.de>
References: <c9b1313d5d8a690aae9788402ec5190a1f18ce75.1750679728.git.johann> <62e79c50daf4e3ae28db3ae1a3cf52460f0d8968.1750775114.git.johannes.schindelin@gmx.de> <20250625085316.35e6dda457b6dce9792c824a@nifty.ne.jp> <701dca10-214a-aa25-a58d-913dbcd258a3@gmx.de>
 <4ad377e7-a75b-d7c4-ccbf-904c18bf3713@gmx.de> <20250625195534.dc322b8f310c7b1c0d3abd03@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:MVU5APKKDYVSZVaUUQWpYqsTloDPj4N5caiWHDb8gyB9wOel4Mj
 XpaaKHCZs1mMU21I7lnBU9S5LPcB+cRPxeBgrFUWah3slXjfz59BV52Jv8A/UA+IQmxSl+V
 /hwSsYsnIJ0V2PI2jAU2x5j84T292PI5wYu0/+YduNGc8j+zlKL6XBUYRlwmwvtkW07CUpv
 YiAzVypFtbNZyzPU4SWGA==
UI-OutboundReport: notjunk:1;M01:P0:b9GreQhYAY4=;YWxg8jRYXKk4kWaY3nZ1t/z4LEv
 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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Wed, 25 Jun 2025, Takashi Yano wrote:

> On Wed, 25 Jun 2025 09:38:17 +0200 (CEST)
> Johannes Schindelin wrote:
>=20
> > On Wed, 25 Jun 2025, Johannes Schindelin wrote:
> >=20
> > > On Wed, 25 Jun 2025, Takashi Yano wrote:
> > >=20
> > > > I'd revise the patch as follows. Could you please test if the
> > > > following patch also solves the issue?
> > >=20
> > > Will do.
> >=20
> > For the record, in my tests, this fixed the hangs, too.
>=20
> Thanks for testing.
> However, I noticed that this patch changes the behavior Corinna was
> concerned about.
>=20
> After trying various things, I found yet another solution for the issue.
>=20
> diff --git a/winsup/cygwin/fhandler/pipe.cc b/winsup/cygwin/fhandler/pip=
e.cc
> index e35d523bb..e36aa57fc 100644
> --- a/winsup/cygwin/fhandler/pipe.cc
> +++ b/winsup/cygwin/fhandler/pipe.cc
> @@ -647,7 +647,7 @@ fhandler_pipe_fifo::raw_write (const void *ptr, size=
_t len)
>  	    }
>  	  if (!NT_SUCCESS (status))
>  	    break;
> -	  if (io.Information > 0 || len <=3D PIPE_BUF || short_write_once)
> +	  if (io.Information > 0 || len <=3D PIPE_BUF)
>  	    break;
>  	  /* Independent of being blocking or non-blocking, if we're here,
>  	     the pipe has less space than requested.  If the pipe is a
>=20
> Johannes, could you please test this patch as well?

Do you mean on top of v2? Or without its changes? And what is the
explanation that the commit message should carry? Sorry, this is too
terse.

Ciao,
Johannes
