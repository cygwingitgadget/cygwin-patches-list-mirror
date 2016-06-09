Return-Path: <cygwin-patches-return-8574-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21782 invoked by alias); 9 Jun 2016 12:32:50 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 21769 invoked by uid 89); 9 Jun 2016 12:32:49 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-96.3 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RCVD_IN_SORBS_DUL,RDNS_DYNAMIC autolearn=ham version=3.3.2 spammy=encrypt, eye, HTo:U*cygwin-patches, H*Ad:U*cygwin-patches
X-HELO: calimero.vinschen.de
Received: from ipbcc0227e.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.34.126) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 09 Jun 2016 12:32:48 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id DD9B7A803D5; Thu,  9 Jun 2016 14:32:45 +0200 (CEST)
Date: Thu, 09 Jun 2016 12:32:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Declaration of crypt
Message-ID: <20160609123245.GL30368@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <b1986513-81eb-39a0-959f-ba9f98521e03@cornell.edu> <20160609090004.GK30368@calimero.vinschen.de> <0479db42-e977-24ae-fc35-407c5067d256@cornell.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="zbGR4y+acU1DwHSi"
Content-Disposition: inline
In-Reply-To: <0479db42-e977-24ae-fc35-407c5067d256@cornell.edu>
User-Agent: Mutt/1.6.1 (2016-04-27)
X-SW-Source: 2016-q2/txt/msg00049.txt.bz2


--zbGR4y+acU1DwHSi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2542

On Jun  9 08:05, Ken Brown wrote:
> On 6/9/2016 5:00 AM, Corinna Vinschen wrote:
> > Hi Ken,
> >=20
> > On Jun  8 17:18, Ken Brown wrote:
> > > According to Posix, including <unistd.h> should bring in the declarat=
ion of
> > > crypt.  The glibc and FreeBSD headers are consistent with this, but C=
ygwin's
> > > aren't.
> > >=20
> > > $ cat test.c
> > > #include <unistd.h>
> > >=20
> > > int
> > > main (void)
> > > {
> > >   const char *key =3D NULL;
> > >   const char *salt =3D NULL;
> > >   crypt (key, salt);
> > > }
> > >=20
> > > $ gcc -c test.c
> > > test.c: In function =E2=80=98main=E2=80=99:
> > > test.c:8:3: warning: implicit declaration of function =E2=80=98crypt=
=E2=80=99
> > > [-Wimplicit-function-declaration]
> > >    crypt (key, salt);
> > >    ^
> > >=20
> > > The attached patch is one way to fix this.  It means that cygwin-deve=
l would
> > > have to require libcrypt-devel.
> > >=20
> > > I'm not sure if I used the right feature-test macro in the patch.  It=
's
> > > marked XSI by Posix, but using __XSI_VISIBLE didn't work.
> >=20
> > What do you mean by "didn't work"?  __XSI_VISIBLE should be the right
> > thing to use.  Your application would have to define, e.g.,
> > _XOPEN_SOURCE before including the file.
>=20
> Ah, that's what I missed.  I tried defining __XSI_VISIBLE in the test fil=
e,
> and I still got the implicit declaration warning.  I see now, reading
> /usr/include/sys/features.h, that __XSI_VISIBLE is a private macro and
> shouldn't have been used in my test.
>=20
> > Another point is the && defined(__CYGWIN__).  This should go away.
> > We're trying to make the headers more standards compatible without
> > going into too much detial what targat provides which function.
>=20
> I wasn't sure that <crypt.h> was portable to all newlib targets.

Oh, drat, no, it isn't.  I'm sorry, I didn't see the #include and just
automatically implied a prototype at this point.  My excuse is that I
have a date for an eye test at my optometrist tomorrow :}

Can you please define crypt, encrypt and setkey explicitely in unistd.h
per POSIX, rather than including crypt.h?  This would not only be target
independent, it would also be more correct.  As a side effect I will=20
have to come up with a new version of the crypt package, because our
crypt.h is using a wrong prototypes for setkey (const is missing).


Thanks a lot and sorry again,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--zbGR4y+acU1DwHSi
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXWWHtAAoJEPU2Bp2uRE+g4YgP/iuQlHug0e5yms2XA6idrPPf
5ACxwk5X1mixMe4MMJcRnywzeHv3H/KEQApW77ethJhpOj0pIH1rnqNma+TMghY0
vpuKcMa/F5pqtg5KfmHvP+rB2MilNDT4MXP/5w5VBAz1f+B0IiqKPcYrMVS2ycNH
uNVeHKOmkNRn/vIfKgk/aMonrLMH04FoEGXYMi8QEKPfo4sZY8pbmnQgtS+pnbAW
4lN15oTqaeCfrIKGvfAm9FzT0LCq6aBeah2i67/ADTiziZR9fZM8DwCI9jbabedp
YFWsP6hJfk9yKjOdXi+25suzbCa2ZCaSnVMW5f3P1Du2zuyGInY76c3BSu9KuaSg
3KM6nSLtr3uJ8j7yX3pndFeTPTUGynTNzSob0OLwiHZxH6JzUQxRKkev9rLxw0PU
gkeqT7dRDZya91iOH7F2FLYwwkN9+YMUPkjYPoFCEonkxdaBNdayx5xfNoySWqti
tmHzb7DAuZjZF3jGgNFZKsyQQd1qzblQLbC/HnGLA4cQg4zWZi2aBhW2EaMMQXr/
BpfQxpFyDg2ro6U7f4oNB0lyYGY3B6ACNA5JPpKT0p/Y0t+IDCmvjIC5wuaZSIsS
og6xa4fbYta6DgFdQbpTHIOvZV/nx23zWmAkE8+roVb1y7vgnXvR/jELrBHQdQhX
OAFEYAi3QeIpmhGs/2bW
=nQiM
-----END PGP SIGNATURE-----

--zbGR4y+acU1DwHSi--
