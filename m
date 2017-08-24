Return-Path: <cygwin-patches-return-8837-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 98047 invoked by alias); 24 Aug 2017 09:40:34 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 98022 invoked by uid 89); 24 Aug 2017 09:40:33 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-101.9 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=H*R:D*cygwin.com, H*Ad:U*cygwin-patches, HTo:U*cygwin-patches, H*c:application
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 24 Aug 2017 09:40:32 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id C417371E3F8C0	for <cygwin-patches@cygwin.com>; Thu, 24 Aug 2017 11:40:29 +0200 (CEST)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id 2BB285E01D4	for <cygwin-patches@cygwin.com>; Thu, 24 Aug 2017 11:40:29 +0200 (CEST)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 0A75EA804AF; Thu, 24 Aug 2017 11:40:29 +0200 (CEST)
Date: Thu, 24 Aug 2017 20:01:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: winsup/cygwin/libc/strptime.cc(__strptime) strptime %F issue
Message-ID: <20170824094028.GK7469@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <BY1PR09MB0343663DE41D927E67CF0CCEA5BB0@BY1PR09MB0343.namprd09.prod.outlook.com> <acc19ec5-055b-1bd4-997d-a247755163bf@SystematicSw.ab.ca> <92da937f-f770-f29c-651e-000f92cbf358@SystematicSw.ab.ca> <f0595b42-8982-f192-9f60-f559d4de3879@SystematicSw.ab.ca> <20170824093255.GI7469@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="lIrNkN/7tmsD/ALM"
Content-Disposition: inline
In-Reply-To: <20170824093255.GI7469@calimero.vinschen.de>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-SW-Source: 2017-q3/txt/msg00039.txt.bz2


--lIrNkN/7tmsD/ALM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1848

On Aug 24 11:32, Corinna Vinschen wrote:
> On Aug 23 13:25, Brian Inglis wrote:
> > Cygwin strptime(3) (also strptime(1)) fails with default width, without=
 an
> > explicit width, because of the test in the following code:
> >=20
> > case 'F':	/* The date as "%Y-%m-%d". */
> > 	{
> > 	  LEGAL_ALT(0);
> > 	  ymd |=3D SET_YMD;
> > 	  char *tmp =3D __strptime ((const char *) bp, "%Y-%m-%d",
> > 				  tm, era_info, alt_digits,
> > 				  locale);
> > 	  if (tmp && (uint) (tmp - (char *) bp) > width)
> > 	    return NULL;
> > 	  bp =3D (const unsigned char *) tmp;
> > 	  continue;
> > 	}
> >=20
> > as default width is zero so test fails and returns NULL.
> >=20
> > Simple patch for this as with the other cases supporting width is to ch=
ange the
> > test to:
> >=20
> > 	  if (tmp && width && (uint) (tmp - (char *) bp) > width)
> >=20
> > but this does not properly support [+0] flags or width in the format as
> > specified by glibc (latest POSIX punts on %F) for compatibility with st=
rftime(),
> > affecting only the %Y format, supplying %[+0]<w-6>F, to support signed =
and zero
> > filled fixed and variable length year fields in %F format.
>=20
> Ok, I admit I didn't understand this fully.  What is '<w-6>'?
> Can you give a real world example?
>=20
> > So do you want compatible support or just the quick fix?
>=20
> Quick and then right?  Fixing this in two steps is just as well.

Btw., FreeBSD's _strptime only calls _strptime recursively, without any
checks for field width:

      case 'F':
	      buf =3D _strptime(buf, "%Y-%m-%d", tm, GMTp, locale);
	      if (buf =3D=3D NULL)
		      return (NULL);
	      flags |=3D FLAG_MONTH | FLAG_MDAY | FLAG_YEAR;
	      break;


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--lIrNkN/7tmsD/ALM
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZnp8MAAoJEPU2Bp2uRE+g1JcP/0uh6RFtNOM6YKadEuAVfAlQ
EXWUtJ8gyFx19Z2B1Q05hzgDBTPEIyY+rittx7xd4S8kX4bIELQnNlDYZ1TL/rlk
cio98mNfRBCnTaZyFP6N2JLjWpIGWw6WChuwLwya5eoSwFgLgb/IQZ9Ykn66UV18
hSDmaxvJcX0DVs0x03r1yq26yO0Tc2zIAmoJriu+6nrW4NtHWxj/zAYdV+W9eqON
uYAzE4GR3EECF8HfICVu6AOX811b7yRjUsXXYuEi70JwxMWvBjpYPFQ1t/AaLzLn
p2dgV0YmREsUvgRE9v6bycRuHWOkPw0pUOUbvRKsyPa+XzuEj4gz1e/UPN/k73Bc
z9olwmFkNbTxaHd/uXupvxuqio/JiVxl3qqJXmFDB2uwjt9+3GigrC9i5hwturGp
7rLGuYPDCbS4Hlfd01pErVYa4Hmvzqs+LSM4f/qjrnX8F1xprGHGYYSownywMelm
Kpx7YeYdtq79ehhr19usHxZA3ZTIBKRmiIEf715xoiF2KvdYfynI7bohs0OPm6wE
3ts7asbeQsXu1qFVgK2ChUqkRWSiZRif/Y75e7tSckcm3F4itvGPkjJX6V6VlZ1h
Sb0xSObMkG/ze6ezU5X/EPeXfnFaw7eyHkMxim45QZ5Mt20KmoEVPL84iZ02Qd3u
KbVDYMIQrq3ZT/Gt/nl2
=9Tdl
-----END PGP SIGNATURE-----

--lIrNkN/7tmsD/ALM--
