Return-Path: <SRS0=d9R/=64=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w01.mail.nifty.com (mta-snd-w01.mail.nifty.com [106.153.227.33])
	by sourceware.org (Postfix) with ESMTPS id E70F34BA2E05
	for <cygwin-patches@cygwin.com>; Mon, 22 Dec 2025 11:32:16 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E70F34BA2E05
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org E70F34BA2E05
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.33
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1766403137; cv=none;
	b=oPTnqq4+xjED+nKC1VNbSSGWw0V/IWX6I4NQBWYOPpLCw951VDFulU9Jgc6JkH8gFWI8OTDf+Jm+nmpNmq/yGVK0sGjFXAXDgRok60IaQYeJ/QjvRK/oUatVynv77cPBCACIHb7ltVSCK4GWDRSyyyxrSfmPAJ2KIGR7iTXDLto=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1766403137; c=relaxed/simple;
	bh=UaDVp+xl1UMfvpOR4hHB5ahukfmmkkM8rNYYw6Nu3A4=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=QXLi3q1352/L45kTHQIz3i6iACi8GMrYR6ngNRqoMLrwvj8Dc9e0R41SxfNZ5pX86DGzQyZRXAqGY81Amdy3OLwhjciU1Wh+kMiXxg9yOaU82mrVnnBqrp39iaJPEV5h5XzGt+jyLgdMLgWgvTbRF/Q8VNp89Qm0mjl3qAuu2J0=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org E70F34BA2E05
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=i27s/oEZ
Received: from HP-Z230 by mta-snd-w01.mail.nifty.com with ESMTP
          id <20251222113214984.BWC.69071.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Mon, 22 Dec 2025 20:32:14 +0900
Date: Mon, 22 Dec 2025 20:32:15 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 2/4] Cygwin: uinfo: allow to override user account as
 primary group
Message-Id: <20251222203215.d00798c28f01906b6f0fb430@nifty.ne.jp>
In-Reply-To: <aUkkXcKDGRF3eNYz@calimero.vinschen.de>
References: <20251218112308.1004395-1-corinna-cygwin@cygwin.com>
	<20251218112308.1004395-3-corinna-cygwin@cygwin.com>
	<20251222150715.1a927b6963b98a34b172d7a9@nifty.ne.jp>
	<aUkb9XD6oKFaSqOr@calimero.vinschen.de>
	<20251222194312.888d00d69bc42831173eaf95@nifty.ne.jp>
	<aUkkXcKDGRF3eNYz@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1766403135;
 bh=GaCLntDfaNWUS7YlXWaDFE3GF9AsBim6okP8YTsao+Y=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=i27s/oEZS3jdSE4jCqtKPcpgsAGrJ+hzokDp13XRW/n4t8zyjppfWLuDvdPeR+cGHQB2LvgB
 jtaHynbdc6QTOeH5eGwcxpeXRBkIgu7SZ67n2i8qtPD0Xjwwo6/AcE8HHqp7dOgIAWhFToa2EK
 z4s/WThy42SmxH6guZ8bCh5NX1w6NTFNBFJiVU2bxg0lnyHP/37JTj0K6mMBxhV5lSPBCxTSt8
 gKC4rQqMB2vYFIzjMMwhMHwShJrSsu8Z2BGE7Gehavbwm36Tfx7T6zdku1h4lgn9KT/LxefmDi
 YSrAW64LXD0UrHl0GmvmtMyFKlYFlqLcRZ4u/1sSWGpOOrhw==
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Mon, 22 Dec 2025 11:58:37 +0100
Corinna Vinschen wrote:
> On Dec 22 19:43, Takashi Yano wrote:
> > On Mon, 22 Dec 2025 11:22:45 +0100
> > Corinna Vinschen wrote:
> > > On Dec 22 15:07, Takashi Yano wrote:
> > > > On Thu, 18 Dec 2025 12:23:06 +0100
> > > > Corinna Vinschen wrote:
> > > > > From: Corinna Vinschen <corinna@vinschen.de>
> > > > > 
> > > > > Do not only allow to override the (localized) group "None" as primary
> > > > > group, but also the user account.  The user account is used as primary
> > > > > group in the user token, if the user account is a Microsoft Account or
> > > > > an AzureAD account.
> > > > 
> > > > Is there any evidence of:
> > > > "The user account is used as primary group in the user token, "
> > > 
> > > I don't quite understand the question.  That's what I'm trying to
> > > explain with this sentence:
> > > 
> > >   The user account is used as primary group in the user token, if the
> > >   user account is a Microsoft Account or an AzureAD account.
> > > 
> > > This was a known problem at the time Microsoft Accounts have been
> > > introduced.  I never had a Microsoft Account myself since I'm
> > > setting up my machines as AD DC or member machines, but we hit this
> > > problem back in 2014.
> > 
> > I could not find the document that states that primary group of
> > user token for Microsoft Account is the user itself. Is this some
> > specification or known behaviour?
> 
> I don't think there's anything like a specification.  It just turned
> out to be that way back in 2014, so it's rather a known behaviour.
> Same goes for AzureAD accounts.
> 
> As a sidenote, there may be other scenarios in AzureAD, maybe for admin
> accounts or whatever, but the 2016 patches were a result of discussions
> on the Cygwin ML.
> 
> Unfortunately, the entry adding support for Microsoft Accounts in
> release/1.7.35 and the entry adding support for AzureAD accounts in
> release/2.6.0 both don't contain an "Addresses:" tag :(

I see. Thanks.
Please go ahead.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
