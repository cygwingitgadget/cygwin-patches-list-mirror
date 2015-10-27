Return-Path: <cygwin-patches-return-8267-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5557 invoked by alias); 27 Oct 2015 08:46:46 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 5533 invoked by uid 89); 27 Oct 2015 08:46:45 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-4.5 required=5.0 tests=AWL,BAYES_40,KAM_LAZY_DOMAIN_SECURITY autolearn=no version=3.3.2
X-Spam-User: qpsmtpd, 2 recipients
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 27 Oct 2015 08:46:45 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id B2304A803FA; Tue, 27 Oct 2015 09:46:42 +0100 (CET)
Date: Tue, 27 Oct 2015 08:46:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin@cygwin.com, cygwin-patches@cygwin.com
Subject: Re: Bash unable to print epoch timestamp
Message-ID: <20151027084642.GM5319@calimero.vinschen.de>
Reply-To: cygwin@cygwin.com, cygwin-patches@cygwin.com
Mail-Followup-To: cygwin@cygwin.com, cygwin-patches@cygwin.com
References: <562A996C.9070904@SystematicSw.ab.ca> <562E643C.3090004@SystematicSw.ab.ca> <562ED064.6050100@SystematicSw.ab.ca>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="2zue9K3IhLF/3KAd"
Content-Disposition: inline
In-Reply-To: <562ED064.6050100@SystematicSw.ab.ca>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2015-q4/txt/msg00020.txt.bz2


--2zue9K3IhLF/3KAd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1342

On Oct 26 19:16, Brian Inglis wrote:
> On 2015-10-26 11:34, Brian Inglis wrote:
> >Third time lucky - pasting inline into email and resending to all previo=
us lists.
> >
> >Please note that conversion into too-small buffer size in regression tes=
t may not have expected result!
> >
> >Tried to build with below and variants:
> >gcc -D_REGRESSION_TEST -D_COMPILING_NEWLIB -Dsniprintf=3Dsnprintf -I/usr=
/src/cygwin-2.2.1-1.src/newlib-cygwin/winsup/cygwin/include -o strftime-s-t=
est strftime.c
> >gives undef refs for __cygwin_gettzname, __cygwin_gettzoffset, __get_cur=
rent_time_locale, __tz_lock, __tz_unlock,
> >_tzset_unlocked
> >
> >Build stc with std cmdline and current strftime works and does demo issu=
e.
>=20
> Sorry - redo with the file existing!

No worries, I applied your other patch since it also cleaned up some
whitespaces and, for some reason, the below patch didn't apply cleanly.

There was just one problem:

> +	  {
> +	    long offset;	/* offset < 0 =3D> W of GMT, > 0 =3D> E of GMT:
> +	    offset =3D 0;	   subtract to get UTC */

This setting the offset to 0 is necessary, but commented out.  Typo?
I fixed this before committing the patch.


Thanks again,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--2zue9K3IhLF/3KAd
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWLznyAAoJEPU2Bp2uRE+gmrEP/0beAbJhK3yOPqeDsiQy9+7E
GAYWtrJ1n3iFjIwT+Pbw40z/9QetY7KcA9j4M5OiP0iKMmjY1yUlc8xnCgVB2HxL
l6fGeXvFvirfhe3rWYxZcrBC7C3c1ViRfWvMqeim1VxjBtYcI9fjBLXclh3dc43H
UHxXaC3JgKAmW6BW2ntXD8K+Lw/p81HftlOO5nvynm+3NMLhs+gxFjo1ChxF0aWG
ywZy8piFWks+81jaQ8HdOoCUaor4Xuw4Q4k5lIS5Tp+Mp9fg+dwKC5JjTtgbq8T+
Nj1Vt+85npdxUve+dQCINWMXXhOt7qtymjJDe1aUMSkr+6VJ4R8ccB+en26C/Js6
T4PRcYse3lmv5sUYdI3cp0zby47Q1Kb5l8oo69ZW9sP0n1DYze5yBnnCMUO5F0FR
smnm9Lv2Pur2GXft7tGntRUfcWJRQTGCk/PmDtml6/gAbDhsnmZsgJUTjVeY636q
DxPtZMO4wOigHoVqkjKmvNkU5JWiBvbAvYjBogloOpRGPIttJiW/APt05fpwsFMA
sLBQWEhJlyFvLKUZD4TEjTDWqCnMqLUrEBEkNKVRh6YaqWuUppjgQUXZKNHyP5xn
mH3GwAO/J9wjAH7KtZiWR7VYTln4UaMZetdlFD4EhsTgcK/5PL2pPwKmuDd9vm3g
vpKFK2KYfYeBQM9dBru3
=jVTk
-----END PGP SIGNATURE-----

--2zue9K3IhLF/3KAd--
