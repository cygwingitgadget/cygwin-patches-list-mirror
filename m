Return-Path: <cygwin-patches-return-8330-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29423 invoked by alias); 18 Feb 2016 11:28:23 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 29400 invoked by uid 89); 18 Feb 2016 11:28:22 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-96.6 required=5.0 tests=BAYES_00,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC,USER_IN_WHITELIST autolearn=no version=3.3.2 spammy=stretch, exchanging, H*R:U*cygwin-patches, H*F:U*corinna-cygwin
X-HELO: calimero.vinschen.de
Received: from ipbcc0d020.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.208.32) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 18 Feb 2016 11:28:21 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id A318AA803FA; Thu, 18 Feb 2016 12:28:19 +0100 (CET)
Date: Thu, 18 Feb 2016 11:28:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Multiple timer issues
Message-ID: <20160218112819.GD8575@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <CAJCedbic4p63tyo1f1TH=h8Ds+0rVGcxrvXuEsb7iRqpM773SA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="W5WqUoFLvi1M7tJE"
Content-Disposition: inline
In-Reply-To: <CAJCedbic4p63tyo1f1TH=h8Ds+0rVGcxrvXuEsb7iRqpM773SA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SW-Source: 2016-q1/txt/msg00036.txt.bz2


--W5WqUoFLvi1M7tJE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2075

Hi Art=C3=BAr,

On Feb 17 23:30, Ir=C3=A1nyossy Knoblauch Art=C3=BAr wrote:
> Dear Cygwin Maintainers,
>=20
> First of all, thank you for your work, I really enjoy using this software!

Thank you :)

> However, I have noticed that adjusting the system time can cause some
> programs to misbehave. I have found bugs in the POSIX timer
> implementation and a bug in the select() function's timeout handling.
>=20
> Please find the proposed patches attached.

I checked your patches and they look good.  I like it that this weird
priming can go away.

> Regarding POSIX timers:
>=20
> I have also created a small test application (see timer_test.c and the
> Makefile) to demonstrate the issue. Please try to run it on both Linux
> and Cygwin!
>=20
> The test tries to set the system time back and forth to see the effect
> on different kinds of timers. Please note, that for setting the system
> time, the test has to be run with the necessary administrative rights
> provided.
>=20
>=20
> Regarding select():
>=20
> The timeout shall be immune to adjustments to the system clock in all
> cases; so the 'gtod' clock shouldn't be used, because it is not
> monotonic.
>=20
>=20
> I have tried to keep the changes as minimal as possible.
> I hope that signing a legal agreement is not necessary, since these
> are just bugfixes; if you think otherwise, please let me know.

Patches 2 can go in as trivial, patch 3 too with a little bit of a
stretch.  Unfortunately your first patch is too big to go in as trivial.
Would you mind terribly to send a copyright assignment per
https://cygwin.com/contrib.html?  If you send it as PDF by mail it takes
usually just a few days to be countersigned.

I would apply patch 2 immediately, but as far as I can see it relies
on patch 1.  Without patch 1, exchanging gtod with ntod will not change
anything since it's still a non-monotonic timer.  Or am I missing
something?


Thanks a lot,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--W5WqUoFLvi1M7tJE
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWxarTAAoJEPU2Bp2uRE+gmcUP/AvGb50gT6+5AClR+USGxMlK
fhD7doQCAoqyGApGL1/ANVwDs+BAmCITO8L6+9AVtSP4+FmEvtCNWORvXBYsZYoh
ok2/QLILTEspFg/w9W6gJxy3GSriGdpUmC1WdO1bXWPIDt8+CUjxf0WSAjMW0w3L
reokK1cZsKPaEWJMp9qlUL5v8y3DrKd8TceRPKBodvN4j73RZYFeFqfiTn2R0ZR3
jdV9P+I8ZwSxjmcz9w2UTuWGa6J3iTsEKyyXurxG3N8csd5Xz6xcqwVWN0/JMk+O
iK0fIZGVec08y4N2jAu1THBmPtE9Dvdy8d+k8hNTf+z+ui0RIbtya7cK6oYT6PIs
BQp0td6TLJZvgArP2WgsNTH56jOTeV3UMb0/BZsjJ68qfPgeRjMhf1CI7Q3YVFyP
nEOEle9nSkhRHgP7aMtgNjIVYw3qroDJHPzEhIwpDIA2cioQ6W9bOJSD2X0P+1py
+vbDKlmtfMr3o64fObDvTBmdYV+Y5YatVytSIikY02NbMDnZqQpoYbnkvTn1bZKW
jfdz2+X86lxV4MHGme6ko0A558CF79+nvEmidsh3vf0f4vMT+/eiVZarYwl0XfND
V1iisf2KaZcSuPx4g7379YzLtX/9njZoTTxS9evvBbr6rD+NWdumbCrjJPDX1kok
AH2ElniPR+1acPlZVieM
=Cwbw
-----END PGP SIGNATURE-----

--W5WqUoFLvi1M7tJE--
