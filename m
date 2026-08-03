Return-Path: <SRS0=g5AQ=F4=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	by sourceware.org (Postfix) with ESMTPS id 9148D4BB1C35
	for <cygwin-patches@cygwin.com>; Mon,  3 Aug 2026 19:36:04 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 9148D4BB1C35
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 9148D4BB1C35
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=212.227.15.15
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1785785764; cv=none;
	b=CqNG3rY1lwu+Tu3Sm3Ab2mGx+2YvQdWACpn6ZVreGV6Nsmi/r6VoQ0ctOnUR0onUSiDtEexcKt6gadF8gdFcZIu/E9fAxUc1Yjw+P8Ks2I+sTfjbioY8ZI4H5DnppR66rGVoz39hGrOZ9w5uffznVs7D+fNnL8Nt8v7WU7gOp4I=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1785785764; c=relaxed/simple;
	bh=gsseO0skjHyQM3qi5uDgn1DHoDCb22iKM6+DDIC2PCE=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=csirqxoFZIZdOak63QM7BFujRTHrCHF5OZVWOs+PeyK9Q+x/bTUgIkEErC981D/yhRYRJinfvvMcay5ZCBZ3TKBBa8TNpTcr6or46P7kp4Qys4tE4okUT/PeuYZXwmmB30ln4Vy83ZGlAYHrnf4/8v9ttkQtaJgcTM9u5PgMby4=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1785785756; x=1786390556;
	i=johannes.schindelin@gmx.de;
	bh=F8+OFCvhWUnoTyhfemw945vnybC81YwpZYEQkFAnsEs=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=YrRHWWTr4N6fNnuvR8x34B2emtCtM6GsCC5DpvjuYb8mCvOEWLQM8QQjimF3qDQk
	 +TuTao/ChPUkbnnd4bQBrqWVJEBK/C2+96VQl/6pc2VqlSHYHVndaUSPT6kzWrHwv
	 6a88q/rsmwclqvCH/OMaIci6o4ce1ngn+l2TVYSQT9mIYkqJjUehDEuAZMr+VVFzx
	 1ATpARbF6xvOP3Z692NEdHHJmqy4JZqAZX8qqEO7xeAjqqQ5IFlTXb9CFkgZUAbu+
	 mGdESpYTZx86Z/9o4SeTm1qK/SQmCNq6p6u87LDbBjKKpvdMj8sVCay5Qa+9wOSxL
	 DFG8TLCmenkL7LWSaw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N1OXZ-1x2YA31qwN-00rfFj; Mon, 03
 Aug 2026 21:35:56 +0200
Date: Mon, 3 Aug 2026 21:35:54 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jon Turney <jon.turney@dronecode.org.uk>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] dumper: allow compiling with binutils 2.47
In-Reply-To: <80f37fa3-a53f-4d62-8a04-34dfdb948475@dronecode.org.uk>
Message-ID: <01c28fbc-a85e-3952-ac91-49afb262156d@gmx.de>
References: <pull.9.cygwin.1785235174913.gitgitgadget@gmail.com> <80f37fa3-a53f-4d62-8a04-34dfdb948475@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:Ogkrp5+ddc9cI4dkZ/X4v/VEbsH4GeYt+vOMc8wPVWEeNq9w1rJ
 hl3gMa3Qm2BZk/O7taGzFJU3owdYFjdhgiBaTsoiQe7fbrgfTWIa/GEuUAASEEPli/jTQRN
 tH5vEWPNIS4hRemFU2j7Incxfd9aty6DGYy3OB++IMOF93G7AHim4rLfEFNVsQlkgGS6x4v
 WWA7uXTAs4ElTMssuQfow==
UI-OutboundReport: notjunk:1;M01:P0:gUvrBkZw4Ng=;ZhGFwOeW2yaJoeICFtnVnYzaxkP
 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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Jon,

On Mon, 3 Aug 2026, Jon Turney wrote:

> On 28/07/2026 11:39, Johannes Schindelin via GitGitGadget wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >=20
> > In the latest version, binutils' BFD no longer declares a `bfd_boolean=
`,
> > and the `bfd_record_phdr()` function accepts plain `bool` parameters
> > instead.
> >=20
> > Let's accommodate for that to avoid these build failures:
>=20
> The obvious question I would ask is "does it still build with older
> bfd", to which the answer seems to be "yes".
>=20
> So, applied. Thanks!

Thank you!
Johannes

>=20
> >=20
> >    .../winsup/utils/dumper.cc: In member function 'int
> >    dumper::prepare_core_dump()':
> >    .../winsup/utils/dumper.cc:830:7: error: 'bfd_boolean' was not decl=
ared
> >    in this scope; did you mean 'boolean'?
> >      830 |       bfd_boolean filehdr =3D 0;
> > |       ^~~~~~~~~~~
> > |       boolean
> >    .../winsup/utils/dumper.cc:831:18: error: expected ';' before 'phdr=
s'
> >      831 |       bfd_boolean phdrs =3D 0;
> > |                  ^~~~~~
> > |                  ;
> >    [...]
> >=20
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >      dumper: allow compiling with binutils 2.47
> >     =20
> [...]
>=20
