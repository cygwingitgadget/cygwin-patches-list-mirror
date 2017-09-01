Return-Path: <cygwin-patches-return-8844-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 36385 invoked by alias); 29 Aug 2017 19:14:40 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 36316 invoked by uid 89); 29 Aug 2017 19:14:39 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-106.4 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=invest, Attached
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 29 Aug 2017 19:14:29 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id 71DD1721E281A	for <cygwin-patches@cygwin.com>; Tue, 29 Aug 2017 21:14:16 +0200 (CEST)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id A17425E0362	for <cygwin-patches@cygwin.com>; Tue, 29 Aug 2017 21:14:15 +0200 (CEST)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 95C6EA80458; Tue, 29 Aug 2017 21:14:15 +0200 (CEST)
Date: Fri, 01 Sep 2017 22:27:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: winsup/cygwin/libc/strptime.cc(__strptime) strptime %F issue
Message-ID: <20170829191415.GL16010@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <BY1PR09MB0343663DE41D927E67CF0CCEA5BB0@BY1PR09MB0343.namprd09.prod.outlook.com> <acc19ec5-055b-1bd4-997d-a247755163bf@SystematicSw.ab.ca> <92da937f-f770-f29c-651e-000f92cbf358@SystematicSw.ab.ca> <f0595b42-8982-f192-9f60-f559d4de3879@SystematicSw.ab.ca> <20170824093255.GI7469@calimero.vinschen.de> <20170824094028.GK7469@calimero.vinschen.de> <7d34bb5d-ecc3-4593-32ed-b3f69c680260@SystematicSw.ab.ca> <20170825094756.GN7469@calimero.vinschen.de> <20170829073520.GI16010@calimero.vinschen.de> <04edcc3e-3270-5a0b-14b8-cddaa80e006f@SystematicSw.ab.ca>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="jy6Sn24JjFx/iggw"
Content-Disposition: inline
In-Reply-To: <04edcc3e-3270-5a0b-14b8-cddaa80e006f@SystematicSw.ab.ca>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-SW-Source: 2017-q3/txt/msg00046.txt.bz2


--jy6Sn24JjFx/iggw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 3088

On Aug 29 11:56, Brian Inglis wrote:
> On 2017-08-29 01:35, Corinna Vinschen wrote:
> > On Aug 25 11:47, Corinna Vinschen wrote:
> >> On Aug 24 11:11, Brian Inglis wrote:
> >>> On 2017-08-24 03:40, Corinna Vinschen wrote:
> >>>> On Aug 24 11:32, Corinna Vinschen wrote:
> >>>>> On Aug 23 13:25, Brian Inglis wrote:
> >>>>>> Cygwin strptime(3) (also strptime(1)) fails with default width, wi=
thout an
> >>>>>> explicit width, because of the test in the following code:
> >>>>>>
> >>>>>> case 'F':	/* The date as "%Y-%m-%d". */
> >>>>>> 	{
> >>>>>> 	  LEGAL_ALT(0);
> >>>>>> 	  ymd |=3D SET_YMD;
> >>>>>> 	  char *tmp =3D __strptime ((const char *) bp, "%Y-%m-%d",
> >>>>>> 				  tm, era_info, alt_digits,
> >>>>>> 				  locale);
> >>>>>> 	  if (tmp && (uint) (tmp - (char *) bp) > width)
> >>>>>> 	    return NULL;
> >>>>>> 	  bp =3D (const unsigned char *) tmp;
> >>>>>> 	  continue;
> >>>>>> 	}
> >>>>>>
> >>>>>> as default width is zero so test fails and returns NULL.
> >>>>>>
> >>>>>> Simple patch for this as with the other cases supporting width is =
to change the
> >>>>>> test to:
> >>>>>>
> >>>>>> 	  if (tmp && width && (uint) (tmp - (char *) bp) > width)
> >>>>>>
> >>>>>> but this does not properly support [+0] flags or width in the form=
at as
> >>>>>> specified by glibc (latest POSIX punts on %F) for compatibility wi=
th strftime(),
> >>>>>> affecting only the %Y format, supplying %[+0]<w-6>F, to support si=
gned and zero
> >>>>>> filled fixed and variable length year fields in %F format.
> >>>> Btw., FreeBSD's _strptime only calls _strptime recursively, without =
any
> >>>> checks for field width:
> >>> As did Cygwin, which just did a goto recurse, before it was changed t=
o support
> >>> explicit width. Your call and option to go back and ignore it, patch =
bug, or
> >>> forward and support flags and width based on strftime documentation.
> >>
> >> Well, I guess it depends on how much time you're willing to invest her=
e.
> >> If you're inclined to fix this per POSIX, you're welcome, of course.
> >=20
> > [...]
> > Would it make sense, perhaps, if you just send the quick fix
> > so we can get 2.9.0 out?
> Attached - got diverted during strptime testing due to time functions gmt=
ime,
> localtime, mktime, strftime not properly handling struct tm->tm_year =3D=
=3D INT_MAX
> =3D> year =3D=3D INT_MAX + 1900 so year needs to be at least long in Cygw=
in 64, also
> affecting tzcalc_limits, and depending on what is required to properly ha=
ndle
> time_t in Cygwin 32.

Sounds like you're busy with time functions for a while ;)

> From 19a3c20c705a576fee0f0e71a31f0c3ac553e612 Mon Sep 17 00:00:00 2001
> From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
> Date: Tue, 29 Aug 2017 11:25:43 -0600
> Subject: [PATCH] winsup/cygwin/libc/strptime.cc(__strptime) fix %F width
>=20
> ---
>  winsup/cygwin/libc/strptime.cc | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Pushed.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--jy6Sn24JjFx/iggw
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZpb0HAAoJEPU2Bp2uRE+gr3kP/RDUYwj6X5RmGHjrB3sAJSwK
gsQOUp3lHg+uflYvyo72F64CpQ8sMIciyU5EhXdwKqVdZWH9A/97nG2VkQJPoNsK
h7a83UjkH5E0hJa+fU/KJp/dAfurS/2bni1GcoluapGSZNlA4dZpmCboQQBvfB1x
I/gP1Xis1my5wdi6K3WKwkJGGHrGlWuQ6jU/JIXLS6u2AVSwUgdQJajBo6vo9NsC
Wf8qgh7IgpKFOaY37fy68Gt2cNy6QsKXmGVWbczYWoBUOK7i2KOu0rJdE6uHHj0y
0+wPGbfYxDO4wv/btOrmpldHZYnhEsuluDGb05b+h6XEMtrxELYUufoTWycFimXo
l3TPgOBKcHN+EJe+94R80KyOSiR0BDpjp5crniV9wCoRGAy+TMgZvJ/q64EBlzps
DnIQ6XrpQjeU7RMdhj+XYEWe6oGfHpN4oDKm3rXEwrSOXTEMqr4D9Z8ArxjKdPzb
pXm7/eFtUz4F2BheMu98g5pW72vI/2XuxIcvIw7BnG2NAzeosY7ZF2aHj6FFLWGi
ni1grclX7naDKyAne3ihypNnbX9eipG2EWRQ0YQSVX6K07+dTuaAtWAYEPSCsX8S
aQOhM2z4UptCzKh3cB5REPTuEC7tpXSoV8oPHCDWCzfaj54MCmdMff/ePKMoMcWy
o44dTOkNVFbIAb4430kD
=3KyH
-----END PGP SIGNATURE-----

--jy6Sn24JjFx/iggw--
