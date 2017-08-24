Return-Path: <cygwin-patches-return-8836-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 56158 invoked by alias); 24 Aug 2017 09:33:06 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 55944 invoked by uid 89); 24 Aug 2017 09:33:01 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-101.9 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=H*R:D*cygwin.com, H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 24 Aug 2017 09:32:59 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id 7ED8071E3F8C0	for <cygwin-patches@cygwin.com>; Thu, 24 Aug 2017 11:32:56 +0200 (CEST)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id C6B785E01D4	for <cygwin-patches@cygwin.com>; Thu, 24 Aug 2017 11:32:55 +0200 (CEST)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id A615FA804A5; Thu, 24 Aug 2017 11:32:55 +0200 (CEST)
Date: Thu, 24 Aug 2017 17:11:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: winsup/cygwin/libc/strptime.cc(__strptime) strptime %F issue
Message-ID: <20170824093255.GI7469@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <BY1PR09MB0343663DE41D927E67CF0CCEA5BB0@BY1PR09MB0343.namprd09.prod.outlook.com> <acc19ec5-055b-1bd4-997d-a247755163bf@SystematicSw.ab.ca> <92da937f-f770-f29c-651e-000f92cbf358@SystematicSw.ab.ca> <f0595b42-8982-f192-9f60-f559d4de3879@SystematicSw.ab.ca>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="BQPnanjtCNWHyqYD"
Content-Disposition: inline
In-Reply-To: <f0595b42-8982-f192-9f60-f559d4de3879@SystematicSw.ab.ca>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-SW-Source: 2017-q3/txt/msg00038.txt.bz2


--BQPnanjtCNWHyqYD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2459

On Aug 23 13:25, Brian Inglis wrote:
> On 2017-08-23 12:51, Brian Inglis wrote:
> > On 2017-07-23 22:07, Brian Inglis wrote:
> >> On 2017-07-23 20:09, Lavrentiev, Anton (NIH/NLM/NCBI) [C] wrote:
> >>>> But that's just scanning a decimal integer to time_t.
> >>> It's not a question of whether I can or can't convert a string into a=
n=20
> >>> integer, rather it's a question about portability of code that uses %s
> >>> for both functions and expects it to work unchanged in the Cygwin
> >>> environment.
> >>> Also, strptime() was designed to be a reversal to strftime() (from th=
e=20
> >>> man-pages: the strptime() function is the converse function to
> >>> strftime(3)) so both are supposed to "understand" the same basic set =
of
> >>> formats. Because of Cygwin's strptime() missing "%s", the following a=
lso
> >>> does not work even from command line:
> >>> $ date +"%s" | strptime "%s"
> > Testing revealed a separate issue with %F format which I will follow up=
 on in
> > a different thread.
> Actually same thread, different subject.
>=20
> Cygwin strptime(3) (also strptime(1)) fails with default width, without an
> explicit width, because of the test in the following code:
>=20
> case 'F':	/* The date as "%Y-%m-%d". */
> 	{
> 	  LEGAL_ALT(0);
> 	  ymd |=3D SET_YMD;
> 	  char *tmp =3D __strptime ((const char *) bp, "%Y-%m-%d",
> 				  tm, era_info, alt_digits,
> 				  locale);
> 	  if (tmp && (uint) (tmp - (char *) bp) > width)
> 	    return NULL;
> 	  bp =3D (const unsigned char *) tmp;
> 	  continue;
> 	}
>=20
> as default width is zero so test fails and returns NULL.
>=20
> Simple patch for this as with the other cases supporting width is to chan=
ge the
> test to:
>=20
> 	  if (tmp && width && (uint) (tmp - (char *) bp) > width)
>=20
> but this does not properly support [+0] flags or width in the format as
> specified by glibc (latest POSIX punts on %F) for compatibility with strf=
time(),
> affecting only the %Y format, supplying %[+0]<w-6>F, to support signed an=
d zero
> filled fixed and variable length year fields in %F format.

Ok, I admit I didn't understand this fully.  What is '<w-6>'?
Can you give a real world example?

> So do you want compatible support or just the quick fix?

Quick and then right?  Fixing this in two steps is just as well.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--BQPnanjtCNWHyqYD
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZnp1HAAoJEPU2Bp2uRE+gsJcP/0289ytABu+Toezl14d6vLAu
f/sPO8ZUbILxy7sZDnuPfxOvRZycWpErh602LaCGEalpsZVKF1ID9eEyUvUwyZLd
WDzoDIBagUVxLhqSmbcZWSZ/N+udhLQ6Mi2nSk5KOorw25WNkqB6LCZN9msAjnOA
uWPE8r7rahKEdz0M60CutF9tjwm2FQVtyHTHfOck74E2IJc1dtQenWlAnOcXpKh5
nzYLhwyyzEaZBDzS8+kQGJP3DJGPbnmDuaHAG2AKqbHn1RrrESUG45WHARHnEKeK
m/ko6J6QXxpWM1BUiQzWgyxa4t2vWKBzIDeiHzWNMruA+2wdfCx5Eenp9J3kV4sa
AMnUHC6J9ojoUxjlQFLOvFgxY/dWYXSi9MqH+2r2gP2KwLpvh44uI5hzPz4ATydF
cknXQ3cxx2C5ypZ8hnmIWWDOqMBsvq6B1u1Iqz2aEcE6+8ON3WXjWPpvaKffDRIo
dsys2F//ahhvXlC6xMVCOEXEDjPyS/6Mc/fwQCMSxlBPhEtrJd2Bu22x2LPR+vms
XWD1oJSR+5hJo0tEg3IAzD3BGvNpqs+ksGB6t2oCm6xbtZp5l7nGg+RYtqAJazWs
s/HJumtsP/iZXKvtAns4jHrFG1RhRYfAgmz0zHzcSZpGVbVcCJQYKjRdvQiormgZ
Buk3E0chAJav6EYOZRnR
=MlG5
-----END PGP SIGNATURE-----

--BQPnanjtCNWHyqYD--
