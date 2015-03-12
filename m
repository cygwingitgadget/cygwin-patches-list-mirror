Return-Path: <cygwin-patches-return-8066-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 71019 invoked by alias); 12 Mar 2015 17:50:43 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 71005 invoked by uid 89); 12 Mar 2015 17:50:41 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-5.9 required=5.0 tests=AWL,BAYES_00 autolearn=ham version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 12 Mar 2015 17:50:41 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id EC5B0A80A55; Thu, 12 Mar 2015 18:50:38 +0100 (CET)
Date: Thu, 12 Mar 2015 17:50:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Fix typo
Message-ID: <20150312175038.GC11522@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <CABEPuQL27_wzE=fRWAR-FqV1vXBcOcLF5-aLvAKWddLkPx=LfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;	protocol="application/pgp-signature"; boundary="ctP54qlpMx3WjD+/"
Content-Disposition: inline
In-Reply-To: <CABEPuQL27_wzE=fRWAR-FqV1vXBcOcLF5-aLvAKWddLkPx=LfQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2015-q1/txt/msg00021.txt.bz2


--ctP54qlpMx3WjD+/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 632

On Mar 12 20:30, Alexey Pavlov wrote:
> --- a/winsup/cygwin/include/cygwin/version.h
> +++ b/winsup/cygwin/include/cygwin/version.h
> @@ -467,7 +467,7 @@ details. */
>             putwc_unlocked, putwchar_unlocked.
>        284: Export sockatmark.
>        285: Export wcstold.
> -      285: Export cabsl, cimagl, creall, finitel, hypotl, sqrtl.
> +      286: Export cabsl, cimagl, creall, finitel, hypotl, sqrtl.
>        287: Export issetugid.
>       */

Applied.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--ctP54qlpMx3WjD+/
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVAdHuAAoJEPU2Bp2uRE+gZPYP/1jQZXOqFA/dcKafcp/69dJU
L67+NxJq0/xKIyhz45sByyfRnY3jXQeU12a7x9GBHAYqiJZ/Di5EKmXh6TXXoise
lobP/uzGEWugjgars3KCM5xNMZ4S5IN1fbzJs8OmURGJwxHr0kcvszzpWWQix33z
z1K+82B6hEFD0bgprOZuVOhOEebj1EHAqNzFfu5Kh9eu6mp9hlKkA6dh3bWox+nw
bipNW4xtqUGoNeOuk92EEnTEWl+O9DYCCkIh4K6JyNJA08tn54/WdfmyWtfe8FWY
gW/1dgIXy41srZ49lANmUWAf11IGoMvNfDyaubPZFL/Zikq1xQtRuhndcXKpruwC
hbO1BheP2UN4+i5SnqLMasVQcN/p84j8WbLq11vn32VsF4EZ7smAPLRkQzIcW98B
IMDj+JCcjbamtYLBGI9NmqFiZMavOz5LRNSf9VE+n5hOTA0MKZZcxOZKEvWd4XDf
AKJOCLHEXNvHSZDlqr8aYuxNYKF6NO8Ni/5VIM30x9sdFKp0AYkVaxfU1F5sn87K
MQ9vfh8+KtK/XnCVCqU7ExKVWJEMx+HONWg7Y4BK92sVfa18NbqpYqnpnb3P4WQM
EK2CUjZWgAxkyqkncnjdUbK4TInorCkd+eyMLau/Qu6+9D0RxyUoH1ghkoGXzPqv
YR9ielaf3jxEaiOr6vxh
=c7eQ
-----END PGP SIGNATURE-----

--ctP54qlpMx3WjD+/--
