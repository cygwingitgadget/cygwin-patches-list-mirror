Return-Path: <cygwin-patches-return-10000-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 124461 invoked by alias); 24 Jan 2020 11:07:36 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 124446 invoked by uid 89); 24 Jan 2020 11:07:36 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-107.5 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*F:D*cygwin.com
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.133) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 24 Jan 2020 11:07:35 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id 1M4384-1iuwoG0yTA-0006yu for <cygwin-patches@cygwin.com>; Fri, 24 Jan 2020 12:07:32 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 894C8A80BB0; Fri, 24 Jan 2020 12:07:30 +0100 (CET)
Date: Fri, 24 Jan 2020 11:07:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: pty: Revise code waiting for forwarding again.
Message-ID: <20200124110730.GG263143@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200122160755.867-1-takashi.yano@nifty.ne.jp> <20200123043007.1364-1-takashi.yano@nifty.ne.jp> <20200123125154.GD263143@calimero.vinschen.de> <20200123231623.ed57b0af319d1de545f2ab7c@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="t4apE7yKrX2dGgJC"
Content-Disposition: inline
In-Reply-To: <20200123231623.ed57b0af319d1de545f2ab7c@nifty.ne.jp>
X-SW-Source: 2020-q1/txt/msg00106.txt


--t4apE7yKrX2dGgJC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1582

On Jan 23 23:16, Takashi Yano wrote:
> On Thu, 23 Jan 2020 13:51:54 +0100
> Corinna Vinschen wrote:
> > On Jan 23 13:30, Takashi Yano wrote:
> > > - After commit 6cc299f0e20e4b76f7dbab5ea8c296ffa4859b62, outputs of
> > >   cygwin programs which call both printf() and WriteConsole() are
> > >   frequently distorted. This patch reverts waiting function to dumb
> > >   Sleep().
> >=20
> > I understand the need for this change, but isn't there any other
> > way to detect if the pseudo console being ready?  E. g., something
> > in the HPCON_INTERNAL struct or so?
>=20
> As for HPCON_INTERNAL,
>=20
> typedef struct _HPCON_INTERNAL
> {
>   HANDLE hWritePipe;
>   HANDLE hConDrvReference;
>   HANDLE hConHostProcess;
> } HPCON_INTERNAL;
>=20
> hWritePipe:
> This is for sending window size change message to pseudo console
> (conhost.exe process).
>=20
> hConDrvRererence:
> I am not sure what this is for.
>=20
> hConHostProcess:
> Process handle of conhost.exe process.
>=20
> None of them seems able to be used for that purpose.

Too bad.  It's pretty strange that CreatePseudoConsole returns a
valid HPCON but then isn't ready to take input immediately.

> I do not come up with other implementation so far.
>=20
> Let me consider a while.

I wonder how others solve this problem.  I see that the native OpenSSH
is using Sleeps, too, in their start_with_pty() function, calling
AttachConsole in a loop, but I'm not sure if these are related to pseudo
console usage.  The commit message don't explain anything there :(


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--t4apE7yKrX2dGgJC
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl4qz/IACgkQ9TYGna5E
T6BqiQ/8CuAqRddgTLjPXsXMIl2SXw1kDAEreUz2YGst51X4aihEFcTosgI9sf5W
armVJKtF1kAptIH/RznW0dgWzzWokIySV9gq9lL64IJLTlVahDlDoU14F+kw0bcY
NrugXxQ7x7jj3mKtl7wfxCwbFfkGR7EPfP1MyrUzfYtwboT9mX0apnWF+RSKfPT0
kSoy5t7s1tNXDN5BXGTo1sAM2AyzOL6vphLojHNVcg/Tgdk8PvsY5L+FXCSeHSqG
2tbfFzyVHB3e2dBXgABXjq3pQArA3CKj5UgzhRfewGEQ1pW40z/RqaPRQDP7n4rt
RQyyRU4nRqEbGnemge4YrN7yLkImtkZqQgZ4hMs7rfe0MMohVZNjlP9tHrzCPp5U
qJfYE62AyfXuKaeoR4fUrq5Oj/OwCGqaaCOIL9FEkOIUwMLZCKvlf5iuXQWLOdqc
v4FvAq6jb5KWaeSwnCt/Ex3j/4eyedrh5K42NIbjdi5so4cCHeWTeNVEf+LOs5qj
Hl2IWevvZ7cFXiXmyHsVon2G3SlF4/Luk/b/6vbAWsYOYW8GuYwobOC5IDqh3DRd
O8PSHCjnb50qfZ3shXjQLd5424u6UaG5M8DRgydVbCx5HTu4Ddp/gG4+vWKzGlrU
a45QWeRUsaCWG+XaG0b1dfcuCFaWMqjVW5r1eqDLcZkXb9szogI=
=7zQJ
-----END PGP SIGNATURE-----

--t4apE7yKrX2dGgJC--
