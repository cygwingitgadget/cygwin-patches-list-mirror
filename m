Return-Path: <SRS0=d9R/=64=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e08.mail.nifty.com (mta-snd-e08.mail.nifty.com [106.153.226.40])
	by sourceware.org (Postfix) with ESMTPS id C04774BA2E05
	for <cygwin-patches@cygwin.com>; Mon, 22 Dec 2025 10:43:13 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C04774BA2E05
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org C04774BA2E05
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.40
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1766400194; cv=none;
	b=C0MX5/urWzHuj/M8dibD6scdtVFESqMczTWDfSNZ9KK0e87BCULX638skGsMU1BZl3wU2/RulFXMDW3l9DTupXhydgklW3z3Z/k3cpjmOTE9s1c0/GuwmH/Uca2NyTNl+7rgDFXKZRDK3YmAcMJPYLrrWcf3EJapGCVwEDTkoG0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1766400194; c=relaxed/simple;
	bh=B6GT/h5S9ohwSXnyU+L0GEs60knkQBFWqO0QTacgKfc=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=eovs8EE8f1i+JG473IQQSOdujD9eu+YAn6WkI5h1KXdXLL6pkX6ccau4GUemeGVWn4SqrdjoHKIMGYtw+WalEgRc9JIQw6wLH/VccmkHuAEIYmLDkyMegUgAJblKHDrUScv8//ayVvPIXQE3CIx5Ep2koQmS//NDOUHjx8XqFoA=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C04774BA2E05
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=PTmcn4/3
Received: from HP-Z230 by mta-snd-e08.mail.nifty.com with ESMTP
          id <20251222104311970.CWIO.23755.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Mon, 22 Dec 2025 19:43:11 +0900
Date: Mon, 22 Dec 2025 19:43:12 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 2/4] Cygwin: uinfo: allow to override user account as
 primary group
Message-Id: <20251222194312.888d00d69bc42831173eaf95@nifty.ne.jp>
In-Reply-To: <aUkb9XD6oKFaSqOr@calimero.vinschen.de>
References: <20251218112308.1004395-1-corinna-cygwin@cygwin.com>
	<20251218112308.1004395-3-corinna-cygwin@cygwin.com>
	<20251222150715.1a927b6963b98a34b172d7a9@nifty.ne.jp>
	<aUkb9XD6oKFaSqOr@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1766400192;
 bh=bXELYldWewQCI+ISxrvI2iukMMxCd+HwLTZRS6dYY70=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=PTmcn4/3BP/kG7NBl4I5WeoHzk450kxex+RT69qf2dtNAlSpNg9a52gmVQ89OTvAFx2tRhNP
 aWq7+uiyqfiRLL74pUzx+GEKSgDGyMcQlz5km6+uQx+C/xBUynbVnYRwm27KSFtStV+tn0SZRz
 fMjL6tRMGUNHCYj5FFSOCPZ4x7DYhic4RC8qnMC34VzqtmYfpcdFka5asGhGzE0fyKS/6qQ4Gx
 FblDo/oFwGgfOo5U7IiE64HLwBqgjsTd5L2wblY+O2VydzmLW8BlSHek3RHkESYhRLnKSPZHDk
 NDKItjhStlJ4QGcspJvP2WzwK2GA2dUloIaRB/YO9tAa83wQ==
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Mon, 22 Dec 2025 11:22:45 +0100
Corinna Vinschen wrote:
> On Dec 22 15:07, Takashi Yano wrote:
> > On Thu, 18 Dec 2025 12:23:06 +0100
> > Corinna Vinschen wrote:
> > > From: Corinna Vinschen <corinna@vinschen.de>
> > > 
> > > Do not only allow to override the (localized) group "None" as primary
> > > group, but also the user account.  The user account is used as primary
> > > group in the user token, if the user account is a Microsoft Account or
> > > an AzureAD account.
> > 
> > Is there any evidence of:
> > "The user account is used as primary group in the user token, "
> 
> I don't quite understand the question.  That's what I'm trying to
> explain with this sentence:
> 
>   The user account is used as primary group in the user token, if the
>   user account is a Microsoft Account or an AzureAD account.
> 
> This was a known problem at the time Microsoft Accounts have been
> introduced.  I never had a Microsoft Account myself since I'm
> setting up my machines as AD DC or member machines, but we hit this
> problem back in 2014.

I could not find the document that states that primary group of
user token for Microsoft Account is the user itself. Is this some
specification or known behaviour?

> +		  || user.sid () == user.groups.pgsid)))

If it is true, the above patch loocks good to me.


-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
