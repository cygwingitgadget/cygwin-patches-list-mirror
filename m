Return-Path: <SRS0=tGrx=CR=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	by sourceware.org (Postfix) with ESMTPS id B97894BA2E37
	for <cygwin-patches@cygwin.com>; Sat, 18 Apr 2026 22:01:42 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B97894BA2E37
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org B97894BA2E37
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=212.227.17.21
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1776549703; cv=none;
	b=f1XLXF3gXqiIAQEXQTxpKc4GTRWnY4mnE6vWeqs4Wwi3k8nfh6u9O70MkMcyLNYEN3Ex1ntIkez1TVzviV2VehAP8+zSahpVAXvUbA6DFq9764kX0xgmZBWIIB9k0q20BA/OL2VoORhbaBU1IFSxKlssEkyHSmZsNVtSzQG2gUk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1776549703; c=relaxed/simple;
	bh=oIaTmsAROpPYvEaRH7CLMSS8FrMTl3BEv5wRwU9+fP8=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=HNrt5dR1X+yK1jvQo9oH2Ga7wj+CZ06u4fkUA0p8AH+p0nH9KdUSRwudXkOUIWuv25GZhT6wuoMsGPeFzt0LRUtxL3ppm1EGuod9fxB+JaqAZX/J8Qgv++z0UugzCX9lL9gF17LpJawIL5bcrX75tKs1rFhJLe4MaMX6n787V/k=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org B97894BA2E37
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=cTeWYva7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1776549701; x=1777154501;
	i=johannes.schindelin@gmx.de;
	bh=dSP6jz5HD4U03yay47hsQZvSSZ1wUrSs6slavYHGkvA=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=cTeWYva75VI2d0ZLfjclhenO1flkxYm+mDbwNUPkXL3m/ZIReuKax0eTJn1iRgXq
	 +DCfMj8I+A/OYqEm2dLTZSk1hPODwKu6/vrtSB/W8c4ZBikIOe8tpNoi0WkIxlfcx
	 Y7oubjk0DjL2z/V4LM3YQcmGxSmlskGlfo1pSWtsKryJDPL7EhprWT3CvBcnEuGJw
	 1ganRattbIP+b1fFVWlJ+GKOXbdxzzWDPefd9Cu476nEuKSmgqKSm2FvJp/a0RFAz
	 KoqtIrrB/MRXBmkBtcp6H2K7/gBDy7Z8bbrSelt4nt6x97vA5lyy6XJziJO2pH9wz
	 kD7XXoDBTDltL1ZXmA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MSt8Q-1vqSC314tK-00PeZe; Sun, 19
 Apr 2026 00:01:41 +0200
Date: Sun, 19 Apr 2026 00:01:39 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v6 3/3] Cygwin: console: Fix master thread for
 OpenConsole.exe
In-Reply-To: <20260407212747.b84f2178e723c9645cd06799@nifty.ne.jp>
Message-ID: <5266689e-9b2b-3bab-6c5e-2678998e5558@gmx.de>
References: <20260312113923.1528-1-takashi.yano@nifty.ne.jp> <20260325131056.69116-1-takashi.yano@nifty.ne.jp> <20260325131056.69116-4-takashi.yano@nifty.ne.jp> <fa6ac2e9-1eec-ffde-5fe8-17bc957f3528@gmx.de>
 <20260407212747.b84f2178e723c9645cd06799@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-752222224-1776549701=:10064"
X-Provags-ID: V03:K1:bTYBv08S4+zcHWn2EfhvUq7k7+skjv4X/K81W0QVkzI+sqi1C8B
 X7sL4vvyu+VCuffarB2DbvWdWTu6cT+IeMHwHVhPIEBL5M3ssSB//uWVGHhC7cGLDEdK+G2
 WUD4hlXXgs5SSNW6iupBX1WsxYEnVtj0s7mieLPSFd4GIVROc04CPYQhhmIw7kSqiQ4tyV7
 KtWKbAc/eXgw88rWDK2cA==
UI-OutboundReport: notjunk:1;M01:P0:Byu8trz79gM=;b3LW/s4sa7KsP3KskE3tT4DDMFF
 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
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-752222224-1776549701=:10064
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Takashi,

Thank you for v7. I verified that it addresses both concerns from my v6
review: the guard is now correctly scoped to `inside_pcon && (mode &
ENABLE_VIRTUAL_TERMINAL_INPUT)`, and the commit message explicitly covers
the `UnicodeChar =3D=3D 0` case.

On Sat, 18 Apr 2026, Takashi Yano wrote:

> On Mon, 6 Apr 2026 10:14:30 +0200 (CEST)
> Johannes Schindelin wrote:
> > Hi Takashi,
> >=20
> > Thank you for the new patch. A few observations:
> >=20
> > On Mon, 6 Apr 2026, Takashi Yano wrote:
> >=20
> > > If the console is originating from a pseudo console, current master
> > > thread code does not work as expected. This is because the pseudo
> > > console does not keep all the event as is. All bKeyDown =3D=3D 0 eve=
nts
> > > will be omitted from the input record written by WriteConsoleInput()=
.
> > >
> > > [...]
> >=20
> > The commit message describes this as general pseudo console behavior, =
but
> > the code comment in `strip_inrec()` is more specific:
> >=20
> > > diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhand=
ler/console.cc
> > > index 1dd5dfa1d..1693a5be7 100644
> > > --- a/winsup/cygwin/fhandler/console.cc
> > > +++ b/winsup/cygwin/fhandler/console.cc
> > > @@ -305,6 +305,23 @@ cons_master_thread (VOID *arg)
> > >    return 0;
> > >  }
> > > =20
> > > +static inline DWORD
> > > +strip_inrec (INPUT_RECORD *r, DWORD n)
> > > +{
> > > +  /* Pseudo console with OpenConsole.exe removes the events
> > > +     whose bKeyDown is 0 as well as ones whose charcode is 0. */
> >=20
> > And the patch title itself says "Fix master thread for
> > OpenConsole.exe".
> >=20
> > Can you help me understand: does legacy conhost.exe _also_ strip these
> > events when used as a pseudo console host? If it does, the commit
> > message is fine but the code comment should drop the "with
> > OpenConsole.exe" part. If it does _not_, then guarding with
> > `inside_pcon` is too broad: when the user sets `use_legacy_pcon`
> > (introduced in patch 1/3 of this series), `strip_inrec()` would
> > discard events on the Cygwin side that conhost.exe actually preserves
> > in its input buffer. Those stripped records would then not be written
> > back at lines 579-584, and the `inrec_eq()` comparison against the
> > peeked buffer would also see a mismatch.
>=20
> You are right. Legacy conhost.exe does not drop KeyUp events and
> events without UnicodeChar for now.
>=20
> I confirmed the behaviour more precisely using the following test code.
> [...]
>=20
> So, the legacy conhost.exe behaves as same as real console.

The empirical data is thorough and convincing. In particular, the
side-by-side comparison across all three hosts (real console, legacy
pseudo console, OpenConsole pseudo console) makes it clear that
`strip_inrec()` is only needed when `ENABLE_VIRTUAL_TERMINAL_INPUT` is
active.

> However:
>=20
> > In that case, could the guard be tightened to `inside_pcon &&
> > !use_legacy_pcon` (or a dedicated flag) so that stripping only happens
> > when OpenConsole.exe is the actual host?
>=20
> I=E2=80=99m concerned that conhost.exe in Windows 11 may start behaving =
the same
> as OpenConsole.exe in the future.

That is sensible forward-looking reasoning. Guarding on the mode flag
rather than on which console host is in use means we are prepared if
legacy conhost converges toward OpenConsole behavior. I agree this is the
right approach.

> [...]
>
> This means we have to maintain UnicodeChar =3D=3D 0 and bKeyDown =3D=3D =
0
> only when ENABLE_VIRTUAL_TERMINAL_INPUT is set.
> When ENABLE_VIRTUAL_TERMINAL_INPUT is not set, all key events are
> preserved.

Correct. And since `strip_inrec()` is now gated on the mode flag, it stays
entirely out of the way in the common non-`ENABLE_VIRTUAL_TERMINAL_INPUT`
case. The logic is clean.

Two typos in the code comment at the `WAIT_OBJECT_0` case (Corinna tends
to care about these):

	s/simlified/simplified/

	s/whth/with/

One observation for posterity, not something to hold up the patch. Under
legacy conhost with `ENABLE_VIRTUAL_TERMINAL_INPUT` enabled,
`strip_inrec()` will discard key-up and `UnicodeChar =3D=3D 0` events that
conhost _does_ still deliver. Two code paths in `process_input_message()`
consume those events:

Raw Win32 keyboard mode (`CSI?2000h`), which encodes `bKeyDown` into the
escape sequence:
https://github.com/cygwin/cygwin/blob/cygwin-3.6.7/winsup/cygwin/fhandler/=
console.cc#L1306-L1317

And Alt+Numpad composed character handling, which relies on the Alt key-up
event:
https://github.com/cygwin/cygwin/blob/cygwin-3.6.7/winsup/cygwin/fhandler/=
console.cc#L1320-L1323

Since `cons_master_thread()` writes back the already-stripped records,
`process_input_message()` never sees those events. Under OpenConsole this
is moot because the events are already absent from the input buffer. For
legacy conhost with `ENABLE_VIRTUAL_TERMINAL_INPUT` it _is_ an observable
behavioral change, but both scenarios are niche (I doubt that raw Win32
keyboard mode is combined often with `ENABLE_VIRTUAL_TERMINAL_INPUT`, and
Alt+Numpad input under a pseudo console is an unusual configuration to
begin with). Just worth keeping in mind for a possible follow-up if
someone reports a regression in either path.

With the two typos fixed:

  Reviewed-by: Johannes Schindelin <johannes.schindelin@gmx.de>

Thank you!,
Johannes

--8323328-752222224-1776549701=:10064--
