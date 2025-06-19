Return-Path: <SRS0=mUBA=ZC=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 9193A381ED8D
	for <cygwin-patches@cygwin.com>; Thu, 19 Jun 2025 17:41:03 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 9193A381ED8D
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 9193A381ED8D
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750354863; cv=none;
	b=emLpjn0wTsi/8Pb4qcAfhb64hPJYPHZbwku2O+2w+3ylyo7StmkRbDNUKZIa21IMLGCGaA23xhqcWe9XWbKNOa0gLqnL15/RphDt8FIIx1aCDV6hbicSxO1uBkvfPyw8x6s+lL4dfT9ruqYUsfJgmfbnKOt8rhtV/VhxYHRYRXk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750354863; c=relaxed/simple;
	bh=xMud46yaVcyn4/qnMt/qyKdAE53xDoahk0b64Fimlac=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=bo3/VJxJ/p7Y/+pFpelYGnhydcuQb1IHifvIUmEk4pCTKlXNoM/w5kJOJXu7uIMox+WUiFjVbG7dKlYYENakZWdKbv64m70T9m1cTuXdcIFvzwP03mOxwIGxC8xaJV7qSO0LIhuzX2ly68LAbNwy1OPgPAbPkXnj9vavcaSqxz0=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 9193A381ED8D
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=Y9dEYvae
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 6BAB145D04
	for <cygwin-patches@cygwin.com>; Thu, 19 Jun 2025 13:41:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=cy7GE1/yWrr21mPz4ESEwa1AI1g=; b=Y9dEY
	vae3zV7x96djkN5A6UmarITrv8fga/pSUweF/svM8Xbww92gpqzsZE1dp2B+QP+S
	9LuEE0P5/rHWaWw3guPzlG7LYJf6+2CrJhRj1gamFtnUwzbdyVsBYN2W4qlwIyEN
	AlkVbMuCkgtQqYYXLVve7hcS2NcYsu+xzSfl+E=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 60CA445CC3
	for <cygwin-patches@cygwin.com>; Thu, 19 Jun 2025 13:41:03 -0400 (EDT)
Date: Thu, 19 Jun 2025 10:41:03 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: obtain stack base on AArch64
In-Reply-To: <aFPrRJJYf21DpAwp@calimero.vinschen.de>
Message-ID: <27a85e62-59fe-4199-2a96-7ccd129558c4@jdrake.com>
References: <DB9PR83MB0923187D66011DE1CB903BF09272A@DB9PR83MB0923.EURPRD83.prod.outlook.com> <7b7b45f7-d126-5673-2961-7c7672f5f922@jdrake.com> <aFPrRJJYf21DpAwp@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="15599321219072-784746950-1750354863=:11368"
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--15599321219072-784746950-1750354863=:11368
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 19 Jun 2025, Corinna Vinschen wrote:

> On Jun 18 10:36, Jeremy Drake via Cygwin-patches wrote:
> > On Wed, 18 Jun 2025, Radek Barton via Cygwin-patches wrote:
> >
> > > Hello.
> > >
> > > This patch ports reading of stack base from TEB on AArch64 at cyglo=
ad.cc and __getreent.
> > >
> > > Radek
> > >
> > > ---
> > > From 08f9be50573a085fd3e5cb840455ea5fc3b1e82a Mon Sep 17 00:00:00 2=
001
> > > From: =3D?UTF-8?q?Radek=3D20Barto=3DC5=3D88?=3D <radek.barton@micro=
soft.com>
> > > Date: Wed, 4 Jun 2025 13:38:10 +0200
> > > Subject: [PATCH] Cygwin: obtain stack base on AArch64
> > > MIME-Version: 1.0
> > > Content-Type: text/plain; charset=3DUTF-8
> > > Content-Transfer-Encoding: 8bit
> > >
> > > Signed-off-by: Radek Barto=C5=88 <radek.barton@microsoft.com>
> > > ---
> > >  winsup/cygwin/include/cygwin/config.h  | 7 ++++++-
> > >  winsup/testsuite/winsup.api/cygload.cc | 7 +++++++
> > >  2 files changed, 13 insertions(+), 1 deletion(-)
> > > [...]
> >
> > LGTM.  Should I be pushing these or just reviewing them on the list?
>
> That would be great!
>

Pushed
--15599321219072-784746950-1750354863=:11368--
