Return-Path: <cygwin-patches-return-8142-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 126116 invoked by alias); 27 May 2015 10:18:16 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 126101 invoked by uid 89); 27 May 2015 10:18:16 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-4.1 required=5.0 tests=AWL,BAYES_50,KAM_LAZY_DOMAIN_SECURITY autolearn=no version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 27 May 2015 10:18:15 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 1FEF2A807CE; Wed, 27 May 2015 12:18:13 +0200 (CEST)
Date: Wed, 27 May 2015 10:18:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Update the estimate of the size of installing everything
Message-ID: <20150527101813.GA4261@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1432226663-19744-1-git-send-email-jon.turney@dronecode.org.uk> <555E6DCB.5080005@tiscali.co.uk> <555F3157.1040808@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="AqsLC8rIMeq19msA"
Content-Disposition: inline
In-Reply-To: <555F3157.1040808@dronecode.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2015-q2/txt/msg00043.txt.bz2


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1123

On May 22 14:38, Jon TURNEY wrote:
> On 22/05/2015 00:44, David Stacey wrote:
> >On 21/05/2015 17:44, Jon TURNEY wrote:
> >>Update the estimate of the size of installing everything from
> >>"hundreds of
> >>megabytes" to "tens of gigabytes", just in case someone should think
> >>it's a
> >>good idea with contemporary hard disk sizes:)
> >
> >Slightly off topic, but I can give you some real numbers if you're
> >interested: x86_64 is the larger of the two installs, weighing in at
> >44.45 GB with just over 750,000 files - and growing all the time.
> >Obviously, that's not installed on an SSD...
>=20
> Thanks. But being precise here just means it will get out of date faster =
:)
>=20
> On reflection, I think I'd prefer just to delete that sentence.  Nearly
> always, installing everything is not a good idea, so mentioning the
> possibility before mentioning you should install what you need doesn't
> really help.

Go ahead with whatever you prefer.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVZZnlAAoJEPU2Bp2uRE+gmzUP/2UwPlpIMep3GXFS0RZRfD06
gGJvIoHeh8117mbmE/LpfjzbYzJmsp4SAdjwU+c7Lby/4RLpc5kzosX14W3UjsbJ
6PSFvLGhTvUiX9deNhzFSaHSl/EROXf9FHQndTc49QXzbF66Spx9Wbg+o4vOYGRz
mgwOh17xeT+PiOvGV/69HW/dfI+DB+6X1jlTGl610vnw9Fc9U10QKZNILkThInYA
6aALcydzMj3Kd0aYExW86lMuL8FnbGoqeJQ7prGYwM6Xb1K+7RKap0aGUROiFfGe
QKjgSp0QeqwJH6+Kv39/tlJjVURYOyj8aFXzkBjWBfKEcMk17TaWthLckevJqJhw
2RDO+e9eHXifo4VqXVQHt94xgv3kGbq8+jEWhbU2aIHSdHC1Xf6psvhP+0RqyREm
wcapYPW34/qWomuadr+ET7VM0hyVvl5VDU3qhS61RgH5qrtxSxtaijFmtTNl4gg8
wQFfSBl+y9cnIm+JQ7dtp/6JA+HFZRRAzrVDZbNoSwzuxjEHkcJQ4O4BpwFoklHH
807XsXvCRpNW5e1itBvEuaqYH9viNwTue+VwlRCixF0ukCjHYHo+mZw8bjrQUIqQ
Cp99e4zYghd3X18PrcCanlRgrhAQvzPvxvBp/MjcPDCKuTK7OGgTH5uoqkdTtA7D
q7NQr+o3SxDJnOg2aDIH
=AnTU
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--
