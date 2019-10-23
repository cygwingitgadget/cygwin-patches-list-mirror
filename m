Return-Path: <cygwin-patches-return-9789-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 90589 invoked by alias); 23 Oct 2019 08:07:39 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 90549 invoked by uid 89); 23 Oct 2019 08:07:38 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-104.5 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*F:D*cygwin.com, USB, device, usb
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (217.72.192.75) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 23 Oct 2019 08:07:37 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MIMXC-1iB9063Yma-00EQQQ for <cygwin-patches@cygwin.com>; Wed, 23 Oct 2019 10:07:34 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id CC74DA80384; Wed, 23 Oct 2019 10:07:33 +0200 (CEST)
Date: Wed, 23 Oct 2019 08:07:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Provide more COM devices
Message-ID: <20191023080733.GY16240@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <87mudvwnrl.fsf@Rainer.invalid> <20191021081844.GH16240@calimero.vinschen.de> <87pniq7yvm.fsf@Rainer.invalid> <20191022071622.GM16240@calimero.vinschen.de> <87d0eo65s5.fsf@Rainer.invalid> <20191022174151.GV16240@calimero.vinschen.de> <878spc651z.fsf@Rainer.invalid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="oGy11dVowAZA6eXT"
Content-Disposition: inline
In-Reply-To: <878spc651z.fsf@Rainer.invalid>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SW-Source: 2019-q4/txt/msg00060.txt.bz2


--oGy11dVowAZA6eXT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 651

On Oct 22 19:52, Achim Gratz wrote:
>=20
> As requested:
>=20
> >From 7908d09f547e0a7a707139d0faaccc151b88024c Mon Sep 17 00:00:00 2001
> From: Achim Gratz <Stromeko@Stromeko.DE>
> Date: Tue, 22 Oct 2019 19:50:50 +0200
> Subject: [PATCH] Cygwin: provide more COM devices
>=20
> * winsup/cygwin/devices.in: Provide for 128 COM devices since Windows
>   likes to create lots of these over time (one per identifiable device
>   and USB port).

Pushed with regenerated devices.cc.  I took the liberty to tweak
the log message a bit.  We don't do CVS-style log entries for quite
some time now :)


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--oGy11dVowAZA6eXT
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl2wCkUACgkQ9TYGna5E
T6CLyw/8D7i5c5ks8zIvar516YzPz2XZMdr2fVaYKUAVj50FirZtk//RbLZ2vu7C
T0wkOvzayNGJXnDqsQ9KF7WT40e/RvArNPY8E2jGMs+KuR0xdSaLmkxSkbm/amTO
KzZCQFTbPRGOkGq47Toc5SIFcUhzWU1aT59SIownIEak8eHzMvz1kLYX+RekiAWs
k1AZ5psQPGytEwlDhVXe8ctHEPCzshlmHxrtvZPnUMwMDS5p5obPE2tiVnrcKJ0f
dt5MEqOD5OQsOw7UqNyf2K37K/jFzv3nLuPKMusmsXG7XlgxtJJo8DWvrmNIVddb
BxA4lnJV7tp9WNiAL/tmEcGd7U4qOGJJx1B+yHjnJ7+yNoUzSMmCLtpkqVFItjPR
Xeg7vwz1iwxv9MCKEMVddcUywYZOl1DXBSPbOLLGRZJeWQr3+Xl2g+tmpxNB3VwK
0FdvvBDVfXuNzLG1TvBA/yKz6kCadZIDAA6oN6RJypsoQtAHasJmkVq1j6Tt86Mh
nIEGkV9/PHpi8qgu22Rg1jQoDgK6HDpqNLtkyw57+TwMLS1KVq9Qqfgc2TAs+PsY
ZgVfHHbP2MP0v3WvjwRgLax7BX4fph9upt+ZE82QgrgOrSIPZ7RcIym/zue9M+Wx
9yKpvfa6zNEF6Nooc4VbMyZ/dFSB6T8A7TSoZUEl9yCwNBDNRyI=
=pIhp
-----END PGP SIGNATURE-----

--oGy11dVowAZA6eXT--
