Return-Path: <SRS0=wRab=ZN=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	by sourceware.org (Postfix) with ESMTPS id 9AE99385481D
	for <cygwin-patches@cygwin.com>; Mon, 30 Jun 2025 10:07:03 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 9AE99385481D
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 9AE99385481D
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=212.227.17.22
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1751278024; cv=none;
	b=T3X1CbjEZgNK+TEILOuvodONxNeDKLqL0r9yhiCTu0Bb6ytW0LpbS/Ds31LjTfTY9gNagPioHphkvoPLmO/8Id55mDyIUkYVv1ZT/5w+pfGm0zuTZ6uyS8nSTj8/d29nJwQSZ/u0BylVT6G16w/PDVoIvgUOE/TditT3oQJ/9IA=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1751278024; c=relaxed/simple;
	bh=EYOmUK+HnnedqNoCzYVEaPak2kA+dBTCCxYWb75K/gc=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=Ou8YHrsyLHxJhBke966dezrX2aG8wb8rItcX6paoLPiwzq3NWYqz0siI6a8ZHduT8kZaUGDKl3o1Od3qksrGQXHvNlAD61+vtERBIthwraN2etgiWpPwqnWlV854JC3hsZiGERIvrvDWnPobIeMORqMxOG6xIiloCh0TQli3hlM=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 9AE99385481D
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=BbjW4wKB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1751278016; x=1751882816;
	i=johannes.schindelin@gmx.de;
	bh=cQPVK+PqM6b8oR19Ztv2NohP0IpZJzDvnUsrwcXBnns=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=BbjW4wKBl8HLcQKUbWJGBLvBaK8ILt0CIxVwd3Wzl50u49+hzhfeJQGuL+4NZ+ai
	 vXRYg0Z0ZoaJswN3OOvH4HeDfbzEUQbAwch1VZR3W1Ippr+ACF3iZjI6ksWAZJG61
	 s7TZPgub/9nTwhrN7bla1yvEgDcrx+p5I/uuxg54ceM7VJ+uBzWVwr8v9ZZ4+XmFE
	 x0mQPNpooXkwbdRKhKglrMYLPgClJNQnu+g40BNSKNGVVLutpP7wTizpMZNIk60As
	 VsX6GnnJJVG4UkXwgw5dS46Oy9F9D1U0oxJ4URmllKLycmrTBKj04MoYb4hGaKN+3
	 /cQYgdnrxKjMQf9keg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([167.220.208.53]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N0G1n-1ut65X15Nv-014ws3; Mon, 30
 Jun 2025 12:06:56 +0200
Date: Mon, 30 Jun 2025 12:06:53 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pipe: Fix SSH hang with non-cygwin pipe reader
In-Reply-To: <20250627201504.4ce78ca9d82d87dbb1c5751d@nifty.ne.jp>
Message-ID: <bd4275ab-5366-4411-f686-3fe42ca3feee@gmx.de>
References: <20250627100607.430-1-takashi.yano@nifty.ne.jp> <1a3de144-cbdb-87c8-d6e9-4ba3ae61765e@gmx.de> <20250627201504.4ce78ca9d82d87dbb1c5751d@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:rj78D+9v0lMxCr+mX3j1R2EmJpA2iwS8W5osnk4vivv3mhIQxhc
 3wgjFyYR4K6CiYse9jcwsnM5+HZWM+vsTjI+LRNOCn2D9T2f4td8WED+lxklnQC3w+WdOD/
 wJRILh0lzBTutFhj5+aUZshyDFFspQAXh8GjA9ULnGmqiTaFNIHjalavtl7WqL47ARsmSDq
 /4NoPizAVIvr1KsDDW7vg==
UI-OutboundReport: notjunk:1;M01:P0:gT2eL/I0hks=;GYmrj30J8Fipl0mVNgGjaocXGY7
 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
 nYEpT7YGeHg==
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_HOSTKARMA_W,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Fri, 27 Jun 2025, Takashi Yano wrote:

> On Fri, 27 Jun 2025 12:25:18 +0200 (CEST)
> Johannes Schindelin wrote:
>=20
> > > Also, pipe_data_available() returns PDA_UNKNOWN rather than 1 when t=
he
> > > pipe space estimation fails so that select() and raw_write() can per=
form
> > > appropriate fallback handling.
> >=20
> > This looks unrelated? Would this not rather be in a separate patch, to
> > make it substantially easier to review for correctness?
>=20
> I'll make a separate patch.

Thank you.

> > P.S.: One thing that strikes me as immediately concerning is this part=
:
> >=20
> > > -	  if (avail < 1)	/* error or pipe closed */
> > > +	  if (avail =3D=3D PDA_UNKNOWN && real_non_blocking_mode)
> > > +	    avail =3D len1;
> >=20
> > That means that the next loop iteration will call `NtWriteFile()` with
> > `len1` bytes (`len1` now being identical to `avail`), even if `len1` c=
an
> > be substantially larger than `PIPE_BUF` (in my tests, it got stuck at
> > `len1 =3D=3D 2097152` in some instances), which is highly likely to be
> > undesirable.
>=20
> I don't think so. avail =3D len1 is performed only when real_non_blockin=
g_mode.
> In real non blocking mode, we can call NtWriteFile() with larger data th=
an
> actual pipe space without blocking.

That is a good explanation, and I see that you made it part of a commit
message in v2. Very good!

> When you observed `len1 =3D=3D 2097152`, perhaps avail was 1, I guess.

Indeed.

Thank you,
Johannes
