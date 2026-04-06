Return-Path: <SRS0=dvnW=CF=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	by sourceware.org (Postfix) with ESMTPS id 9F2284BA9009
	for <cygwin-patches@cygwin.com>; Mon,  6 Apr 2026 08:36:22 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 9F2284BA9009
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 9F2284BA9009
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=212.227.17.20
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1775464583; cv=none;
	b=F4eg7ibkPUtw85ZGFvaRRpbDoWJ8dK5xU1DFv5xHTuw5lOZdik19q6LUTgmk3vmO5sry8ukS9VvhFS58KRpWJgwrnlVHIOdAai7uTNKrXMWZY+O6m1rMHzAsftti/w+H2ROD7QHUagcapCwPNpth+Vjo863RnRfJOGzWkDYewks=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1775464583; c=relaxed/simple;
	bh=VNF49ID8tT09eaZYiDmpaf04Mltz3mdWsDLpo5OEHi0=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=q05swYjzzGh+r/kotuC7tvqgaotTaiCuWr770KCOM6Y+zwGS48PyCQiHse+HOPP3OE7uh3rEJPFVmcccjia7zmrOGvrqTpyWVVKUVTWer2AEQ53E3v1DG5VrwVItdWxPcgshoqNeddnoUgXGVXab27oMjRbBd8rwJPaLICRnJpU=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 9F2284BA9009
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=b7DX+tSx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1775464581; x=1776069381;
	i=johannes.schindelin@gmx.de;
	bh=5fvGL3jZll9wF58Jx6TZ/HtPg5MiPVDOsJbp8/yzcY0=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=b7DX+tSxmAcV4s/c0LrTZQ4bmo4E8/D7O/UdWnXqSypgdgKsHES+sPQbPOUGzSNr
	 GJvFiJ5365h1+sLEu9CkXSaJhm6ghubKRdlrBSvV3aXCS4gmm0i3hdQYh3VGAHQwE
	 UO2nBULdQuL0Mey1LHXz5cayAZk2XRUHZbWKovFeQNJRjTFQeahv4lpl287d1BU1j
	 Cp41JYAgs+LYwRUi7p/K02TutAfmyjZX2ry+jBcNtwT/F2JYsmXwu0n8HkM9jJJX/
	 OYo0Zw2Y9mOMplAVlaHZvG5NdCZuki1G+IX/Bw1hQpVk2Fiu2BRtWTU+GQSo5c0xK
	 WVgJ5gzbK/q+1FhrJw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mlf0U-1vip9T1DYw-00nwM0; Mon, 06
 Apr 2026 10:36:21 +0200
Date: Mon, 6 Apr 2026 10:36:19 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v5 1/3] Cygwin: pty: Use OpenConsole.exe if available
In-Reply-To: <20260325214109.eda376ea321601393aa2a13e@nifty.ne.jp>
Message-ID: <59d4e265-6cab-a701-2c58-ce03b88fd5ed@gmx.de>
References: <20260312113923.1528-1-takashi.yano@nifty.ne.jp> <20260312113923.1528-2-takashi.yano@nifty.ne.jp> <90f23c8e-cb9c-ad64-8c22-2f5cb3a535e3@gmx.de> <20260325214109.eda376ea321601393aa2a13e@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:RZdb24GyQZiZcWDm5a2hIhv1K6//IKbToMfzMbgSQI8A6Yd3FwL
 6pJGhaokiXWAgNcur+w0uWgPse7qRP83FTMMP6EWJ+l95lK+KWpluLaXrWwbr9QEEqp70al
 gD2X0fHaAgPw07pFQFFnsf7bUR124MAdlt2XRaDCve0H2VuR++ulB0/FkP4552JpQ7ooNTW
 RMryYEHPejPLFn+tk0E5A==
UI-OutboundReport: notjunk:1;M01:P0:xGrMksAB+BY=;sre/D/Ch3U9vurjE1iuMX2jUK2A
 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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

Thank you for v6. I verified that it addresses the majority of the
review comments from v5: the typo, the opt-out mechanism
(`CYGWIN=3Duse_legacy_pcon`), the CSIc separation, the `extern "C"`
export, the `h_read_pipe` leak, the thread-safety concern (which you
rightly noted also affects the existing pseudo console code), and the
`in_pcon_start` reset. I appreciate the thorough follow-up.

Two small items remain, neither of which I consider blockers:

On Mon, 6 Apr 2026, Takashi Yano wrote:

> Johannes Schindelin wrote:
> >=20
> > On Thu, 12 Mar 2026, Takashi Yano wrote:
> >=20
> > > This patch replaces legacy conhost.exe with OpenConsole.exe if
> > > it is available. This enables various new features such as mouse
> > > support in pseudo console and bug fixes. The legacy conhost has
> > > problems, e.g. character attributes are mangled or ignored, and
> > > terminal reports are not passed through. This patch resolve the
> > > issue by loading /usr/bin/OpenColnsole.exe instead of conhost.exe
> >=20
> > I know that Corinna cares about typos in commit messages, so I'd like =
to
> > point out that "OpenColnsole" has an extra "l" in it.
> >=20
> > > if it is available.
> >=20
> > My biggest issue with this patch: There is no opt-out mechanism: No
> > CYGWIN=3Ddisable_openconsole or MSYS=3Ddisable_openconsole flag. If
> > /usr/bin/OpenConsole.exe exists and is buggy, or this here patch, the =
user
> > is stuck.
>=20
> Thnaks. I'll add CYGWIN=3Duse_lagacy_pcon option.

Thank you!

> > > +
> > > +  HANDLE h_con_server, h_con_reference;
> > > +  NTSTATUS status;
> > > +  BOOL res;
> > > +  HANDLE h_read_pipe, h_write_pipe;
> > > +  BOOL inherit_cursor;
> > > +  path_conv conhost ("/usr/bin/OpenConsole.exe");
> >=20
> > Is it really a good idea to hard-code that path? That would not only
> > preclude an `OpenConsole.exe` that is in the `PATH` to be used, it als=
o
> > suggests that you plan on building a Cygwin version of that executable
> > (because that location should only contain native Cygwin applications =
and
> > DLLs).
>=20
> I imagine we would have openconsole cygwin package which install
> OpenConsole.exe into /usr/bin/.

That makes sense as a packaging plan. My remaining concern is purely about
maintainability: the path is a string literal buried in the function body.
I would suggest defining a named constant for it (near the existing
`"/bin/cygwin-console-helper.exe"` literal, or at file scope) so that the
path is easy to find and change in one place.

>=20
> > > +  InitializeProcThreadAttributeList (NULL, 1, 0, &list_size);
> >=20
> > This requires a corresponding `DeleteProcThreadAttributeList()` call.
>=20
> This call is for retrieving list_size. Nothing is allocated with this ca=
ll.

Agreed, the first call with `NULL` is purely for size discovery and needs
no cleanup. My concern was actually about the _second_ call,
`InitializeProcThreadAttributeList(si.lpAttributeList, ...)`, which does
initialize the buffer, sorry for quoting the wrong call. Per MSDN, that
requires a matching `DeleteProcThreadAttributeList()` before `HeapFree()`:

  https://learn.microsoft.com/en-us/windows/win32/api/processthreadsapi/nf=
-processthreadsapi-initializeprocthreadattributelist

The existing code in `setup_pseudoconsole()` gets this right in the
success path but actually has the same gap in its `cleanup_heap` error
path. Could you add the `DeleteProcThreadAttributeList()` call in the
error cleanup path of your new `CreatePseudoConsole_new()` as well? And if
you feel like fixing the pre-existing gap in `setup_pseudoconsole()` too,
all the better. :-)

For v6 patches 1/3 and 2/3:

  Reviewed-by: Johannes Schindelin <johannes.schindelin@gmx.de>

Ciao,
Johannes
