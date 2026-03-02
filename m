Return-Path: <SRS0=kRW9=BC=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	by sourceware.org (Postfix) with ESMTPS id ADDE24BA23DB
	for <cygwin-patches@cygwin.com>; Mon,  2 Mar 2026 12:48:55 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org ADDE24BA23DB
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org ADDE24BA23DB
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=212.227.15.15
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1772455736; cv=none;
	b=lc1tlL6MnDDrwvYvcdif6RX0/KNaMssWC277bDspEpG65BoOsVS4WF1rX9Y0BP3RHtNVnGipxT9Pu66XPVJdk5fo3ZAJ2USDTAetO3h0j/OyKufcsqx7W4Q1OdE9IAMTxzooVnQ1sloSWNdj+gSJTheC1lHYMK6mN9ps1BqQaeE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1772455736; c=relaxed/simple;
	bh=I2SWQJ5hMWMXBOCmvBs45OrGMffWTmKF0AP48YGTJY4=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=JwlVNr1tUDphqUo+M2hhv2jmBsFqXZPv8K0wlegNxxFunXVUn1XlXo8dcQyIOWTi0duJQuFKxS9KRfPVv++bZ6+zBmDcQGE6bDeFTKNvbJRKbIaGpUNCZ8MilSVJblN3t9PaA9YEj8/+I45DO1dmGrL22UnwHJTrr1OuQrj+lFo=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org ADDE24BA23DB
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=dt0S+7SD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1772455734; x=1773060534;
	i=johannes.schindelin@gmx.de;
	bh=+NS91Ed+fAtrzjKqVm/rn8LfqvAx16zOKiIaH+c8/AQ=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=dt0S+7SDQUQ/uKq16bjEEQsb1mIYH0sIk3WSd3Go487i4WJ48+ggNWej3TCSRWG+
	 fO7Bxpy1/Zjkaspk50iavS/mHxEeCzoMUoCQ3lMUx+lERHxwBBLTK5Snq7EXWPu77
	 FLHHunRnUo+kqmPzDJf2O2BmOcPBIRX2wj6VgnJojfGurwyLVQzUh/8Vf+9GO6NYo
	 ujHTuOr0lorWh0o2sTe/CHIrbSna+eti92ajBMIzXzxzwCfVItJczpCE6LD57m+j5
	 OGcF9BT1zIzOrFa4IvUA5pl39aPjGjOwfG2uz2UhG/2K5znVD6EZ7q8/9aDUfiryu
	 l2imWRCM+vPUn3FBGw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MZktZ-1w9Wtt1TOx-00Ow9z; Mon, 02
 Mar 2026 13:48:54 +0100
Date: Mon, 2 Mar 2026 13:48:52 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Improve CSI6n handling in pcon_start
 state
In-Reply-To: <20260228180037.e9a86823c18aade8c3ca8e8f@nifty.ne.jp>
Message-ID: <0cb187b6-d6d9-b524-ab42-53195048b73e@gmx.de>
References: <20260223080106.330-1-takashi.yano@nifty.ne.jp> <00548c9e-dd25-40e9-737a-4113910d4c8f@gmx.de> <20260228180037.e9a86823c18aade8c3ca8e8f@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Is85+VJHmJvxf0kec1hAXeAG8HZZUtIcziyPuMGyiFJbik076Wf
 pZTnYmGw5H9utB19R8T0B2XL3zlSCJ0l99I4k1VVPHRSNzmPbwxskSVqTNUjoLHcY42d0MY
 l2XoYBLDMgWO77YcUc3lcyA9+R5gYMC+99ZC0sD3KxxVxg4YItyz/Tc6V52S7v0uHX8qM+r
 OX9oS4qCXB0VsWGPJ1kfg==
UI-OutboundReport: notjunk:1;M01:P0:W3KxyPVQO2A=;/wQsm/viwERVPXqj3kUUoIUKqUq
 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
 B6kZibL4=
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Sat, 28 Feb 2026, Takashi Yano wrote:

> On Fri, 27 Feb 2026 18:58:26 +0100 (CET)
> Johannes Schindelin wrote:
>=20
> > Regarding the commit message: beyond the typos ("Previsouly" =3D>
> > "Previously", "responce" =3D> "response" x3, "CSI&n" =3D> "CSI 6n"), t=
he
> > body describes the bug as "the sequence will not be written
> > atomically", but isn't the actual problem that bytes after the `R`
> > terminator go through per-byte `line_edit` inside the CSI 6n loop and
> > then hit `return len` without ever reaching the `nat` pipe fast path?
> > In that case, it would be a routing problem, not an atomicity problem,
> > and something like:
> >=20
> >     Cygwin: pty: Fix data after CSI 6n response bypassing normal write=
 paths
> >=20
> >     When the terminal's CSI 6n response and subsequent data (e.g.
> >     keystrokes) arrive in the same write buffer, `master::write()`
> >     processes all of it inside the pcon_start loop and returns early.
> >     Bytes after the 'R' terminator go through per-byte `line_edit()`
> >     in that loop instead of falling through to the `nat` pipe fast
> >     path or the normal bulk `line_edit()` call.
> >=20
> >     Fix this by breaking out of the loop when 'R' is found and letting
> >     the remaining data fall through to the normal write paths, which
> >     are now reachable because `pcon_start` has been cleared.
> >=20
> > would be potentially more accurate in describing what is going on.
> >=20
> > I am still quite fuzzy on the exact goings-on in the pty code,
> > essentially cobbling it all together "on the side" because I
> > unfortunately cannot afford to spend much focus on the Cygwin/MSYS2
> > runtime. Hopefully what I said above makes some sense?
>=20
> Actually, sending the data which is sent to nat pipe to line_edit()
> is not so wrong. The data buffered in the readahead buffer will be
> routed to nat pipe if necessary in `accept_input()`.
>=20
> However, in this case, the code page conversion is not apply to the
> data. Therefore, "letting the remaining data fall through to the normal
> write paths" is more appropriate than using line_edit().

Okay, that makes sense to me. Thank you for the clarification/correction!

> Anyway, could you please review the v2 patch? Thanks in advance.

On it.

Ciao,
Johannes
