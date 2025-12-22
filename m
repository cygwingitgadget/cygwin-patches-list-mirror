Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 3B6364BA2E04; Mon, 22 Dec 2025 10:58:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 3B6364BA2E04
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1766401119;
	bh=K2wglgbD3KK8R4/a72EKkxqyxinJxKvYmc84GH5MD8E=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=p/BagwactFfVfvHaXB4ak3TrQCtQMYibdvK8w7OpDXUSOYc7DPwlLYlwhYak3uwpK
	 EL+gOUoSidheamhuF7lh9C1wfXARN2ANU/8WTis9U+R943lrV4KTQETLOnVK5guxPn
	 kORe0NfMNlqe3/rwCVN8Xu4PZRPx2wv11jhxBogA=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 5FE6AA80797; Mon, 22 Dec 2025 11:58:37 +0100 (CET)
Date: Mon, 22 Dec 2025 11:58:37 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 2/4] Cygwin: uinfo: allow to override user account as
 primary group
Message-ID: <aUkkXcKDGRF3eNYz@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20251218112308.1004395-1-corinna-cygwin@cygwin.com>
 <20251218112308.1004395-3-corinna-cygwin@cygwin.com>
 <20251222150715.1a927b6963b98a34b172d7a9@nifty.ne.jp>
 <aUkb9XD6oKFaSqOr@calimero.vinschen.de>
 <20251222194312.888d00d69bc42831173eaf95@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251222194312.888d00d69bc42831173eaf95@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Dec 22 19:43, Takashi Yano wrote:
> On Mon, 22 Dec 2025 11:22:45 +0100
> Corinna Vinschen wrote:
> > On Dec 22 15:07, Takashi Yano wrote:
> > > On Thu, 18 Dec 2025 12:23:06 +0100
> > > Corinna Vinschen wrote:
> > > > From: Corinna Vinschen <corinna@vinschen.de>
> > > > 
> > > > Do not only allow to override the (localized) group "None" as primary
> > > > group, but also the user account.  The user account is used as primary
> > > > group in the user token, if the user account is a Microsoft Account or
> > > > an AzureAD account.
> > > 
> > > Is there any evidence of:
> > > "The user account is used as primary group in the user token, "
> > 
> > I don't quite understand the question.  That's what I'm trying to
> > explain with this sentence:
> > 
> >   The user account is used as primary group in the user token, if the
> >   user account is a Microsoft Account or an AzureAD account.
> > 
> > This was a known problem at the time Microsoft Accounts have been
> > introduced.  I never had a Microsoft Account myself since I'm
> > setting up my machines as AD DC or member machines, but we hit this
> > problem back in 2014.
> 
> I could not find the document that states that primary group of
> user token for Microsoft Account is the user itself. Is this some
> specification or known behaviour?

I don't think there's anything like a specification.  It just turned
out to be that way back in 2014, so it's rather a known behaviour.
Same goes for AzureAD accounts.

As a sidenote, there may be other scenarios in AzureAD, maybe for admin
accounts or whatever, but the 2016 patches were a result of discussions
on the Cygwin ML.

Unfortunately, the entry adding support for Microsoft Accounts in
release/1.7.35 and the entry adding support for AzureAD accounts in
release/2.6.0 both don't contain an "Addresses:" tag :(


Corinna
