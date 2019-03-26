Return-Path: <cygwin-patches-return-9236-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 68095 invoked by alias); 26 Mar 2019 08:36:25 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 68084 invoked by uid 89); 26 Mar 2019 08:36:25 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-103.4 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*F:D*cygwin.com
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.134) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 26 Mar 2019 08:36:23 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MGxYh-1hDMXv3WeR-00E5v4 for <cygwin-patches@cygwin.com>; Tue, 26 Mar 2019 09:36:20 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 0FBDFA80856; Tue, 26 Mar 2019 09:36:20 +0100 (CET)
Date: Tue, 26 Mar 2019 08:36:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH fifo 0/2] Add support for duplex FIFOs
Message-ID: <20190326083620.GI3471@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20190325230556.2219-1-kbrown@cornell.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="fmvA4kSBHQVZhkR6"
Content-Disposition: inline
In-Reply-To: <20190325230556.2219-1-kbrown@cornell.edu>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q1/txt/msg00046.txt.bz2


--fmvA4kSBHQVZhkR6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 585

Hi Ken,

On Mar 25 23:06, Ken Brown wrote:
> The second patch in this series enables opening a FIFO with O_RDWR
> access.  The underlying Windows named pipe is creted with duplex
> access, and its handle is made the I/O handle of the first client.
>=20
> While testing this, I had some mysterious crashes, which are fixed by
> the first patch.

I rebased the topic/fifo branch on top of master and force-pushed with
your patches.  Make sure to reset your working tree to origin/topic/fifo
and add any further patches on top.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--fmvA4kSBHQVZhkR6
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlyZ5IMACgkQ9TYGna5E
T6DvMw/+MPF0p50kjjP6/f4cTcxQ+RYltfnA+JtWalgoTzZXZLnlUv417gEK0Q0M
ZUlHsrQTbO1ue8kCRaQ5uenh9hDwlCUtfriNfFDxqwy8qlm/wJxtvdoYgOIUfUgL
7ukdTndrIDawKAMkbppGaUAvV2BRYRzDd2zP+QCFuEjupfPLz5cr4d11jD/th1y5
C0vbCXGMJwYsEyFaQPTIZa++YPgnNrYEvlFx+AcjfGSskpHpiJry1iOE+wPNnCzP
WXZOKqeK9QZNAWUdMKK0cShOYQPCTYr0x3FHDfYkJFQabrJzmlwAUxY9bGBMg12A
XUnSgJn10N7Owo8T+WE09txb2JGE3Un9yXMz4XWnMq9BU3FZLSJQ5WIfA41lurtz
k/9TBUc8wx0YKo2Uvy28uKJrjrnfJnb6HA669YVIs1mlRiiMnwMTHMD0AtkkxlpQ
AcZarCG8HSHyKEdQU4VoTHGnhLUk10vPy+ZiTel0SEq6p86RhV1D74n/+V7JbW/y
c0fFiZyXAIP8a40eg0RrBzTbpy/7msCdW12BxlZKxHGj1f0AW2tw10MlfDEutgvu
LGhXfvYQvyLX0xYwhdyYF2o5JZ4fA84dsnZgN3yaOhKsDsAvx/ebSZGmiGFOPM+m
J+Ul5rn590YEzi6SPhuWqWUg7npjC033TSV3P9N5PAVRhcZ78RM=
=j05I
-----END PGP SIGNATURE-----

--fmvA4kSBHQVZhkR6--
