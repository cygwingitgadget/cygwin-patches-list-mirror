Return-Path: <SRS0=IKhM=TC=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w08.mail.nifty.com (mta-snd-w08.mail.nifty.com [106.153.227.40])
	by sourceware.org (Postfix) with ESMTPS id A43B2385842C
	for <cygwin-patches@cygwin.com>; Mon,  9 Dec 2024 13:58:02 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org A43B2385842C
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org A43B2385842C
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.40
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1733752683; cv=none;
	b=x1n+ZEPVqqWqWbu9MzwJflpUvgzT4/4VMchR/F3ZCPG77nCtZoBGWbweCWb54lF8YgVSqC7FHKlsMUMZHlgGbJNVLFO56XSOZN2p0XvWb5SdVmDcBlIMRp2LcVgmUW4sI7JfNuvQYlvaN5f0FfbrXS4mfjhjzMmIEGLPvxo4KnA=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1733752683; c=relaxed/simple;
	bh=2mD0lM6JieGtJ6ozzeWvaKowy6rsthaTdXAbDpcdRBo=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=KlFeDd47f0IrrqF9n9Gao+nw3dqkSZaRfNi632Q1upHfyOY/mB+cYO7Q1g+PQ8tx5Dp8kDnMYlnuwwM1ZnxFTybkcEljpGfmG+2p1duDIdX1+hlk4uFhyfW8MUPMnlAulJqQjNzsFUKsrcKoa1APaGvqLb8IXxzk7o8Pt+no76Y=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org A43B2385842C
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=VeuivgrV
Received: from HP-Z230 by mta-snd-w08.mail.nifty.com with ESMTP
          id <20241209135800630.BXVR.4660.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Mon, 9 Dec 2024 22:58:00 +0900
Date: Mon, 9 Dec 2024 22:57:59 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: SMBFS mount's file cannot be made executable
Message-Id: <20241209225759.9c71db3a2dcbafe0b4769a7b@nifty.ne.jp>
In-Reply-To: <20241209224400.978983b35ac2b5e5ebc35ef2@nifty.ne.jp>
References: <20241113181755.02289e8e8d9af7e19e8f4387@nifty.ne.jp>
	<CANV9t=SvYedzG-LmECwdT7kjipOyhgwsZ1yucnTm8mWMnNkJVw@mail.gmail.com>
	<20241114003740.e573d7ec79d35da76225c9f1@nifty.ne.jp>
	<CANV9t=TLh8xD7KBsF-MucZWNjP-L0KE04xUv2-2e=Z5fXTjk=w@mail.gmail.com>
	<20241114010807.99f46760b2240d472440c329@nifty.ne.jp>
	<20241116002122.3f4fd325a497eb4261ad80f4@nifty.ne.jp>
	<ZztqpBESgcTXcd3d@calimero.vinschen.de>
	<20241119175806.321cdb7e65a727a2eb58c8a6@nifty.ne.jp>
	<Zzz7FJim9kIiqjyy@calimero.vinschen.de>
	<20241208081338.e097563889a03619fc467930@nifty.ne.jp>
	<Z1bQfIgv7MIDL1fB@calimero.vinschen.de>
	<20241209224400.978983b35ac2b5e5ebc35ef2@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1733752680;
 bh=7u1i4pBjGf8gdP4nxOzxyXDOsGMBVz2UwcqicUH0s6g=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=VeuivgrVOnOm/t6H7mipIZIHwh+f2JZdZzv//0cXJ6S0eMeHaHe/H3ure8HO2h5HO+ntxhGo
 RjB2gtM2FKLModIas/t/fWBEjGPNLTO4HzakLpmW+lXllIA+ZgCrFptrQhkbeuCR+8SvdeDVnN
 DvK/Kzw9JDZNTOj9bCksLdNC0XjWyKMZplvR0GWmC+nQD250WCCs1jdtd04blwcvUaWfye6P67
 6JaaYLTNDk2b13cGtMZUKqmOFJBvxWx5AggQoZpozUlZ9fmrEsULlumjeiIW7cF0dHqTPhLlsq
 phdXq7t4HQmlDm8vCGToz4CBIF23nXdfm/Sj08oYWqa4LgHQ==
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Mon, 9 Dec 2024 22:44:00 +0900
Takashi Yano wrote:
> On Mon, 9 Dec 2024 12:11:56 +0100
> Corinna Vinschen wrote:
> > On Dec  8 08:13, Takashi Yano via Cygwin wrote:
> > > On Tue, 19 Nov 2024 21:54:44 +0100
> > > Corinna Vinschen wrote:
> > > > No, we can't do that, it's too simple.
> > > > 
> > > > Just kidding.
> > > > 
> > > > This is so simple, I'm puzzled we never tried that before.  Or, if we
> > > > did, it's a loooong time ago...
> > > > 
> > > > If we really do this, we don't even need to call get_file_sd().  And it
> > > > should use NtOpenFile and reopen semantics i.e.  pc.init_reopen_attr().
> > > > Also, the sharing flags should allow all access.  And the `effective'
> > > > argument needs to be taken into account.
> > > 
> > > I have a question. What pc.init_reopen_attr() is for? I tested with
> > > pc.get_object_attr() instead, it works.
> > 
> > init_reopen_attr() uses the "open by handle" functionality as in the
> > Win32 API ReOpenFile().  It only does so if the filesystem supports it.
> > Samba usually does, so it's not clear to me why pc.init_reopen_attr()
> > fails for you.
> 
> I didn't mean pc.init_reopen_attr() failed. Just I was no idea
> for what handle to be passed.
> 
> > > What handle should I pass to pc.init_reopen_attr()?
> > 
> > You could pass pc.handle().  Is pc.handle() in this scenario NULL,
> > perhaps?
> 
> I have tried pc.handle() and suceeded. Thanks for advice!

No! pc.handle() sometimes seems to be NULL....
git send-email faild with error.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
