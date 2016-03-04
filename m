Return-Path: <cygwin-patches-return-8373-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 96292 invoked by alias); 4 Mar 2016 08:59:55 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 96278 invoked by uid 89); 4 Mar 2016 08:59:55 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-93.9 required=5.0 tests=BAYES_50,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC,USER_IN_WHITELIST autolearn=no version=3.3.2 spammy=DOT, signing, bugfixes, Maintainers
X-HELO: calimero.vinschen.de
Received: from ipbcc0d020.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.208.32) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 04 Mar 2016 08:59:54 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id D39B7A80633; Fri,  4 Mar 2016 09:59:51 +0100 (CET)
Date: Fri, 04 Mar 2016 08:59:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Cc: =?utf-8?Q?Ir=C3=A1nyossy_Knoblauch_Art=C3=BAr?= <ikartur@gmail.com>
Subject: Re: [PATCH] Multiple timer issues
Message-ID: <20160304085951.GC8296@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com,	=?utf-8?Q?Ir=C3=A1nyossy_Knoblauch_Art=C3=BAr?= <ikartur@gmail.com>
References: <CAJCedbic4p63tyo1f1TH=h8Ds+0rVGcxrvXuEsb7iRqpM773SA@mail.gmail.com> <20160218112819.GD8575@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="QRj9sO5tAVLaXnSD"
Content-Disposition: inline
In-Reply-To: <20160218112819.GD8575@calimero.vinschen.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SW-Source: 2016-q1/txt/msg00079.txt.bz2


--QRj9sO5tAVLaXnSD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2515

Art=C3=BAr,

Ping?  Any news on your CA?  Did you get my reply to your mail to
ges-info?


Thanks,
Corinna

On Feb 18 12:28, Corinna Vinschen wrote:
> Hi Art=C3=BAr,
>=20
> On Feb 17 23:30, Ir=C3=A1nyossy Knoblauch Art=C3=BAr wrote:
> > Dear Cygwin Maintainers,
> >=20
> > First of all, thank you for your work, I really enjoy using this softwa=
re!
>=20
> Thank you :)
>=20
> > However, I have noticed that adjusting the system time can cause some
> > programs to misbehave. I have found bugs in the POSIX timer
> > implementation and a bug in the select() function's timeout handling.
> >=20
> > Please find the proposed patches attached.
>=20
> I checked your patches and they look good.  I like it that this weird
> priming can go away.
>=20
> > Regarding POSIX timers:
> >=20
> > I have also created a small test application (see timer_test.c and the
> > Makefile) to demonstrate the issue. Please try to run it on both Linux
> > and Cygwin!
> >=20
> > The test tries to set the system time back and forth to see the effect
> > on different kinds of timers. Please note, that for setting the system
> > time, the test has to be run with the necessary administrative rights
> > provided.
> >=20
> >=20
> > Regarding select():
> >=20
> > The timeout shall be immune to adjustments to the system clock in all
> > cases; so the 'gtod' clock shouldn't be used, because it is not
> > monotonic.
> >=20
> >=20
> > I have tried to keep the changes as minimal as possible.
> > I hope that signing a legal agreement is not necessary, since these
> > are just bugfixes; if you think otherwise, please let me know.
>=20
> Patches 2 can go in as trivial, patch 3 too with a little bit of a
> stretch.  Unfortunately your first patch is too big to go in as trivial.
> Would you mind terribly to send a copyright assignment per
> https://cygwin.com/contrib.html?  If you send it as PDF by mail it takes
> usually just a few days to be countersigned.
>=20
> I would apply patch 2 immediately, but as far as I can see it relies
> on patch 1.  Without patch 1, exchanging gtod with ntod will not change
> anything since it's still a non-monotonic timer.  Or am I missing
> something?
>=20
>=20
> Thanks a lot,
> Corinna
>=20
> --=20
> Corinna Vinschen                  Please, send mails regarding Cygwin to
> Cygwin Maintainer                 cygwin AT cygwin DOT com
> Red Hat



--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--QRj9sO5tAVLaXnSD
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW2U6HAAoJEPU2Bp2uRE+gf+AP+QHPVrG1fIHHVccoyn6Zpv5H
UfNf5S8gp/i6nkNpAUlqeKF6LO2Y1bfiaaXd/NmfZxjyb0EP3q88hjfWoSL4CE5G
3WIdBxtnsytxzltH9fv1M5WoRYrSpuMVKu9vu7nTLLfTnLW2URCs2Q6Ekir5M+cL
eLEeVltLkqQaLxfOPDm0t9vOw8XpxyUcD+nfL0dkQ/wAN5KG6VCYmHdLVSh4BB6j
OVmL2Bl7yKA2nmPzgMpJ3ZVqO42YQLC6oZ/NY6rIULXz+QMTjtCkOtPCj15PD6yb
PntHonUa6rdHMJi+j5JAe6B+q124AhpO3IlEz7QZESZv7DeEkeIRgWw5dYeXNj6+
SzK4GoYojdmoG55MCKgPkjkSBdjyJ3fV3vu47vUEsJsm5t+nhEHgMhFwfDivGg+L
6C3u6lq+GbTAHHlsLUO5B1K2pVlq5wapw/TlvQ3ED53eyFeuditRF9dmrtjEKx5J
9872i5d0BnnQ2yaHmx251RUX6gWJMhyz0vuLEEQhoA92SW5BFXKS15Oafp2Rsb3G
MtSnEB7num3jFc3btTAz1xGvqak/g72jp4t8ez3kuQXNsEskchJHx1QB4+oB6i7G
SEtBFxvSnbOtvtFAxe+pMv0SpuRKPZ2c+pV0knnNkPmCn9Tm6Dm6h38gNh9/sSgJ
iLNyEbaT2glizFc1NCN+
=sZuD
-----END PGP SIGNATURE-----

--QRj9sO5tAVLaXnSD--
