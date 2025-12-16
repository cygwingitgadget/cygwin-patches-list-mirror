Return-Path: <SRS0=Mvmz=6W=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	by sourceware.org (Postfix) with ESMTPS id CEBC44BA2E07
	for <cygwin-patches@cygwin.com>; Tue, 16 Dec 2025 09:31:25 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org CEBC44BA2E07
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org CEBC44BA2E07
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=212.227.15.15
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1765877486; cv=none;
	b=dgvlxdYCY74Yzzpik8YjxpM4o/JAnK4byjhKdXo+C2m8/L0YXiNFAzJXAQWYOV7ZawAL/3TEOtdCC1wNdCN89S3DQ7aPjQgda+8WQhm4ACMA0+/K87OTLQOZUMYDm/i+xPvgyX1OOtD2c2o8GVB0zoVSqrvfKWDte6V3cSfu77M=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1765877486; c=relaxed/simple;
	bh=eoxXf4Mu/FwL0K9lBwvVZb+0l2g5Jt9jxNRLuklVp6w=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=KZrLawEkQKUt6VwQ9NzDj2raSMp65MH8/0UY0NxCRPlvMITzGGzkadSl3tCoZMVcNXpAKI9Pt0uZMjx9PxtJIB72n7qxiDV17+8vhbJ/8TD6Rpn6pmBz3jjr/dAuxYEVxlqNTevpICM1+imjIZyQg4Nwenjpy19Caaq01SGg5GM=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org CEBC44BA2E07
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=NHV5+Jm6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1765877480; x=1766482280;
	i=johannes.schindelin@gmx.de;
	bh=1tH2WPfzkZr08dIyCqPa22ZSk+wv1YbiZsO1DLIX+RE=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=NHV5+Jm6lRtJ9dcoVLoCkN/j5lqRleK6ahVoQVrDeopiaXCPdv/3LSBkOALPim5b
	 LhcdWzWp0JI7yEgWDifxK2RnVV3yBoYnsy/8Ta/LyOMJRYL4Vf+N3rcKIfmwZHPHT
	 IGUCK6sY/snVlDcHiHPNDx1A1VS0lD4ZFWatp8HDB7/Bjb2jHkcmlsmxbkvdPCeeT
	 g0ufv2Q9dl5aexlLgipywYPExTHmeW4XlgaNPlAEi/VZCpnBS7fXsL+eZupiWA2Ee
	 Sbpodr9YzD6dFlNcmIMqNyodyZgbalk+ECfLuN2K0iNjXYsWez6NCXTT6voj/EIMp
	 I5OJLdHyvsmW/rO2xA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.215.18]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M3UZ6-1vVzMb48jS-00CjZZ; Tue, 16
 Dec 2025 10:31:20 +0100
Date: Tue, 16 Dec 2025 10:31:17 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH 3/3] Cygwin: is_console_app(): handle app execution
 aliases
In-Reply-To: <20251216173957.fa9571466a8bced55924884f@nifty.ne.jp>
Message-ID: <4ac88404-a8c3-3d21-6460-6941fb8dff4a@gmx.de>
References: <pull.5.cygwin.1765809440.gitgitgadget@gmail.com> <6ae42c5d17102a7805ed6539b9548df437df88a1.1765809440.git.gitgitgadget@gmail.com> <aUAoxVEKMpj6xNjM@calimero.vinschen.de> <18909F97-1145-4F61-9E23-4E4B9C97CF2E@gmx.de> <aUAxwTZcfZ9qecW2@calimero.vinschen.de>
 <f8d06570-7208-755b-e747-e8d7d174b32d@gmx.de> <20251216173957.fa9571466a8bced55924884f@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:KJBnJPb5WP6h1/+mX3NF/8eh4qskZUZ7wpvyP8830g2jSf+CAl5
 ByCIVSg90QnOjajJ41JdOuFv+f2813QKAf2ban2W2uvb5lGiIWLXJLthmB1pQvfZtNCHwO8
 3FBG/rehJeM0PHZVzP0NZIHmU8QCdh3Yz+34I4ZqHw6U5gw9sMBrdlNZPeh4B5YgUbrCGUz
 939P3Nsm6/x078Ve86IMg==
UI-OutboundReport: notjunk:1;M01:P0:IKBO/ELlELk=;hXqqO57166WGhQO6cuzzs4bfIjK
 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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,MALFORMED_FREEMAIL,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Tue, 16 Dec 2025, Takashi Yano wrote:

> On Mon, 15 Dec 2025 18:15:10 +0100 (CET)
> Johannes Schindelin wrote:
> >=20
> > On Mon, 15 Dec 2025, Corinna Vinschen wrote:
> >=20
> > > On Dec 15 16:40, Johannes Schindelin wrote:
> > > > Hey Corinna,
> > > >=20
> > > > [Sorry for top-posting]
> > >=20
> > > /*rolling eyes*/
> >=20
> > I wanted to reply quickly, which precluded me from using a mailer that
> > allows inlined responses, sorry.
> >=20
> > > > Also, it looks as if that other proposed patch will always add
> > > > overhead, not only when the reparse point needs to be handled in a
> > > > special way. Given that this code path imposes already quite a bit=
 of
> > > > overhead, overhead that delays execution noticeably and makes
> > > > debugging less delightful than I'd like, I would much prefer to do=
 it
> > > > in the way that I proposed, where the extra time penalty is impose=
d
> > > > _only_ in case the special handling is actually needed.
> > >=20
> > > You may want to discuss this with Takashi.  Simplicity vs. Speed ;)
> >=20
> > With that little rationale, the patch to always follow symlinks does n=
ot
> > exactly look simple to me, but complex and requiring some
> > head-scratching...
>=20
> The overhead of path_conv with PC_SYM_FOLLOW is small, however,
> it may be a waste of process time to call it always indeed.

When I debugged this problem, I introduced debug statements that show how
often that code path is hit. In a simple rebuild of the Cygwin runtime, it
is hit _very often_, and it is vexing how slow the rebuild is.

I don't want to pile onto the damage by adding overhead that is totally
unnecessary in the common case (most times processes are _not_ spawned via
app execution aliases), even if it is small. If nothing else, it
encourages more of that undesirable code pattern to add more and more
stuff that is not even needed in the vast majority of calls.

> However, IMHO, calling CreateFileW() twice is not what we want to do.
> I've just submitted v2 patch. In v2 patch, use extra path_conv only
> when the path is a symlink. Usually, simple symlink is already followed
> in spawn.cc:
> https://cygwin.com/git/?p=3Dnewlib-cygwin.git;a=3Dblob;f=3Dwinsup/cygwin=
/spawn.cc;h=3D71add8755cabf4cc0113bf9f00924fddb8ddc5b7;hb=3DHEAD#l46

Okay. However, then I don't understand how:

1. The patch in question is even necessary, as it would appear that it
   introduces a _second time_ where the symlink is followed?

2. What purpose is the name `perhaps_suffix()` possibly trying to convey?
   I know naming is hard, but... `perhaps_suffix()`? Really?

> The code is simpler than your patch 3/3 and my previous patch
> and intent of the code is clearer.

The intent of that previous patch is a far cry from clear without a
much-improved commit message, I'd think. It talks about symlinks in
general, but then uses the app execution alias `debian.exe` as example
(when a simple test shows that regular symlinks do not need that fix at
all), and the patch treats it as an "all symlinks" problem, too. Honestly,
I am quite surprised to read this claim.

Ciao,
Johannes

>=20
> What do you think?
>=20
> --=20
> Takashi Yano <takashi.yano@nifty.ne.jp>
>=20
