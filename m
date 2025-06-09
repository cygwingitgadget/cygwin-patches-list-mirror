Return-Path: <SRS0=KdRA=YY=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 2686C3858D38
	for <cygwin-patches@cygwin.com>; Mon,  9 Jun 2025 21:56:19 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 2686C3858D38
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 2686C3858D38
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1749506179; cv=none;
	b=cbsylboKuflx2w7lgiSY/9aJxvt1q//ODWSC5Yg77DUTQLD/zzzkd5o4V+RbHd+C+P58oYjYbfc2iLFLvT3po7vlVMplZFi0qTIPTJFtEXAYD6EMaju8p9NjCm+J1L+sml5mTf4jl6uBLUs3YuY2PttQDwEU0RWGyHOdRjWg740=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1749506179; c=relaxed/simple;
	bh=Llilq9xKeBeRMfD71y48D8rFjlG8bLYdj3P4DHqgiR8=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=pUhpha0eSdRobizbzUcFAUQ6nZ7JSC1arDmxRkG1oDupa0Jby1cY9Z0JTzWZ/kUyhLcP5E6zHLzAlq8CzsjGe0XFROc3SSdgGhmRNunXc+J/IX1GlhSsETsWY24rWKGmkWcLAv1xJMTxdY7TGypZIeGmftTSmomGvlonvQnYkQw=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 2686C3858D38
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=h3XGdcwk
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id D8C5F45CC9
	for <cygwin-patches@cygwin.com>; Mon, 09 Jun 2025 17:56:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=WrhTpsIAjU2FwrM3lyFgi6PIK4g=; b=h3XGd
	cwkU+Rx7c4ifcp7hNvl7l5X7qUF+vFbDkN3BXbsriDaaFM3qs4sW7QekGH+6aefP
	OayKGH7GjtNM96Q1+9Et8ZGxdFIQp+NZ1a+JYLKU49GZ6vMqmcLlJWdu/+B/9n3p
	PV+BB7+gpd+l5UwCQtp8JHbWM0J4pQMWYs958c=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id D317045CC5
	for <cygwin-patches@cygwin.com>; Mon, 09 Jun 2025 17:56:18 -0400 (EDT)
Date: Mon, 9 Jun 2025 14:56:18 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix compatibility with MinGW v13 headers
In-Reply-To: <1ef68eee-d80a-4dde-af43-c4fdea1e4c40@SystematicSW.ab.ca>
Message-ID: <2aa8fb0c-9a96-b260-2f28-aea8dab08bcc@jdrake.com>
References: <DB9PR83MB09238924363B70583AA08BA5926BA@DB9PR83MB0923.EURPRD83.prod.outlook.com> <7178d417-9d6b-14b2-95cb-b5c4fb53b463@jdrake.com> <1ef68eee-d80a-4dde-af43-c4fdea1e4c40@SystematicSW.ab.ca>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="15599321219072-1101118906-1749506178=:11368"
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--15599321219072-1101118906-1749506178=:11368
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 9 Jun 2025, Brian Inglis wrote:

> On 2025-06-09 12:54, Jeremy Drake via Cygwin-patches wrote:
> > On Mon, 9 Jun 2025, Radek Barton via Cygwin-patches wrote:
> > > Since today,
> > > https://github.com/cygwin/cygwin/actions/runs/15537033468=C2=A0work=
flow=C2=A0started
> > > to fail as it seems that `cygwin/cygwin-install-action@master` acti=
on
> > > started to use newer MinGW headers.
> > >
> > > The attached patch fixes compatibility with v13 MinGW headers while
> > > preserving compatibility with v12.
>
> Perhaps in the case of this build, but not necessarily anywhere else in=
 Cygwin
> using BSD sockets.
>
> > The change to cygwin/socket.h concerns me, that is a public header, a=
nd
> > you can't assume they are including MinGW headers, and if they are ho=
w
> > they are configuring them (ie, _WIN32_WINNT define) or which ones the=
y
> > are including.  It looks like the mingw-w64 header #defines cmsghdr, =
maybe
> > an #ifndef cmsghdr with a comment about this situation?  Or how do ot=
her
> > Cygwin headers handle potential conflicts with Windows headers?
> I appear to be missing where Mingw headers other than ntstatus.h are in=
cluded
> in these Cygwin headers so how would Mingw version be defined here?

Inside Cygwin, additional Windows headers are included, including winsock
headers to implement sockets within Cygwin.

> It looks like the changes need to be made elsewhere across the code hie=
rarchy.
>
> What are the actual Mingw header definition changes causing conflicts, =
and do
> any Cygwin headers, setup or other network apps code need to be adjuste=
d to
> take the Mingw header changes into account?

https://github.com/mingw-w64/mingw-w64/commit/c3b5e71d54aa596bba9fb8ec7c1=
f9f712e7c616a

> Such details would be required to explain why the patch would be needed=
 and
> how it fixes the issue while taking compatibility with and any impacts =
on
> Cygwin network apps into account.

> This should perhaps be referred back to the w32api-headers maintainer t=
o see
> if he did any testing before deployment?

--15599321219072-1101118906-1749506178=:11368--
