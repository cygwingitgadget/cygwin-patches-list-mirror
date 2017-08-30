Return-Path: <cygwin-patches-return-8842-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8791 invoked by alias); 25 Aug 2017 09:48:25 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 8263 invoked by uid 89); 25 Aug 2017 09:48:03 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-101.9 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=invest, H*R:D*cygwin.com, H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 25 Aug 2017 09:48:01 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id 79E23721E281A	for <cygwin-patches@cygwin.com>; Fri, 25 Aug 2017 11:47:57 +0200 (CEST)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id D394D5E0359	for <cygwin-patches@cygwin.com>; Fri, 25 Aug 2017 11:47:56 +0200 (CEST)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id B05DCA80522; Fri, 25 Aug 2017 11:47:56 +0200 (CEST)
Date: Wed, 30 Aug 2017 00:09:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: winsup/cygwin/libc/strptime.cc(__strptime) strptime %F issue
Message-ID: <20170825094756.GN7469@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <BY1PR09MB0343663DE41D927E67CF0CCEA5BB0@BY1PR09MB0343.namprd09.prod.outlook.com> <acc19ec5-055b-1bd4-997d-a247755163bf@SystematicSw.ab.ca> <92da937f-f770-f29c-651e-000f92cbf358@SystematicSw.ab.ca> <f0595b42-8982-f192-9f60-f559d4de3879@SystematicSw.ab.ca> <20170824093255.GI7469@calimero.vinschen.de> <20170824094028.GK7469@calimero.vinschen.de> <7d34bb5d-ecc3-4593-32ed-b3f69c680260@SystematicSw.ab.ca>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="xGGVyNQdqA79rdfn"
Content-Disposition: inline
In-Reply-To: <7d34bb5d-ecc3-4593-32ed-b3f69c680260@SystematicSw.ab.ca>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-SW-Source: 2017-q3/txt/msg00044.txt.bz2


--xGGVyNQdqA79rdfn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2737

On Aug 24 11:11, Brian Inglis wrote:
> On 2017-08-24 03:40, Corinna Vinschen wrote:
> > On Aug 24 11:32, Corinna Vinschen wrote:
> >> On Aug 23 13:25, Brian Inglis wrote:
> >>> Cygwin strptime(3) (also strptime(1)) fails with default width, witho=
ut an
> >>> explicit width, because of the test in the following code:
> >>>
> >>> case 'F':	/* The date as "%Y-%m-%d". */
> >>> 	{
> >>> 	  LEGAL_ALT(0);
> >>> 	  ymd |=3D SET_YMD;
> >>> 	  char *tmp =3D __strptime ((const char *) bp, "%Y-%m-%d",
> >>> 				  tm, era_info, alt_digits,
> >>> 				  locale);
> >>> 	  if (tmp && (uint) (tmp - (char *) bp) > width)
> >>> 	    return NULL;
> >>> 	  bp =3D (const unsigned char *) tmp;
> >>> 	  continue;
> >>> 	}
> >>>
> >>> as default width is zero so test fails and returns NULL.
> >>>
> >>> Simple patch for this as with the other cases supporting width is to =
change the
> >>> test to:
> >>>
> >>> 	  if (tmp && width && (uint) (tmp - (char *) bp) > width)
> >>>
> >>> but this does not properly support [+0] flags or width in the format =
as
> >>> specified by glibc (latest POSIX punts on %F) for compatibility with =
strftime(),
> >>> affecting only the %Y format, supplying %[+0]<w-6>F, to support signe=
d and zero
> >>> filled fixed and variable length year fields in %F format.
> >>
> >> Ok, I admit I didn't understand this fully.  What is '<w-6>'?
> >> Can you give a real world example?
>=20
> Width prefix for %F minus six for "-mm-dd" to get the width for %Y.
> Look at POSIX strftime %F handling
> 	http://pubs.opengroup.org/onlinepubs/9699919799/functions/strftime.html
> or
> 	man 3p strftime | less +/\ F\
> for what strftime allows and strptime should handle for symmetry and cons=
istency.
>=20
> >>> So do you want compatible support or just the quick fix?
> >>
> >> Quick and then right?  Fixing this in two steps is just as well.
> >=20
> > Btw., FreeBSD's _strptime only calls _strptime recursively, without any
> > checks for field width:
> >=20
> >       case 'F':
> > 	      buf =3D _strptime(buf, "%Y-%m-%d", tm, GMTp, locale);
> > 	      if (buf =3D=3D NULL)
> > 		      return (NULL);
> > 	      flags |=3D FLAG_MONTH | FLAG_MDAY | FLAG_YEAR;
> > 	      break;
>=20
> As did Cygwin, which just did a goto recurse, before it was changed to su=
pport
> explicit width. Your call and option to go back and ignore it, patch bug,=
 or
> forward and support flags and width based on strftime documentation.

Well, I guess it depends on how much time you're willing to invest here.
If you're inclined to fix this per POSIX, you're welcome, of course.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--xGGVyNQdqA79rdfn
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZn/JMAAoJEPU2Bp2uRE+gpB4P/3W96A2Unc9ktlQIo9/nXPHF
3eIlbCjmIB2a/mWj+D176GAA+4Fs1TurJ3qFzZscxnBydniIqcvFtiTyYUjZBLwt
oZDCfo+Jgx08VSLw3hX40noShKybZlD3xC2Jv/+2L/JqDlxrUF0rEgmpr4KPzVpf
uaHqF8C5p6LqyJcd0WqoYBsulyzrg1DMzMPIP0PjN2mlI0QSgWrjPPfsl1JTEJrn
p3ZJmqZFBu7Pv+R2Cfv0XZ37MX2bS7avzz06ltZ987U26IB5aDzOjr09hZC06lEw
QKlRBoyt2y8EMPgTSVcS3pEpIgKgHQP2nvV+7/TE7Y5vPBDWFVEjgl/Qi9lw+VBA
/mpldXw1VQ9Z8krgzDfHJxCF2BS4DwV8DG8dSBk8Lw0KOHhjB3z+HoHdMXjiyFq/
YZ6IVHyofDFENpCYI6yPn9FgEGb7csK+V6mpM5E+IlYKX14Fc/4Wd47jwgTUlmkN
WEx6EPiw8BXATkoz5oGX2SdlY38XKHQS7GPEYNuq6lOPxl9VVmhu4W3pMsWcyPrO
K+bdEs7GgSfyvfTH86Q4inWEzyKra4xmeydFNc85QQO8cAGPegd1i8bKd8/Pmbsk
+2hQp8TH/jN3OUMpRcRh/tyPk7gR9CVk0kGlhvmBHIvyjtqZC16aTyor7cLugsv/
5gtwG5QqTTP6PpNdqxQC
=1mAi
-----END PGP SIGNATURE-----

--xGGVyNQdqA79rdfn--
