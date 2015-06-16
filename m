Return-Path: <cygwin-patches-return-8172-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 93104 invoked by alias); 16 Jun 2015 09:45:06 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 93091 invoked by uid 89); 16 Jun 2015 09:45:05 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-5.4 required=5.0 tests=AWL,BAYES_00,KAM_LAZY_DOMAIN_SECURITY autolearn=no version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 16 Jun 2015 09:45:03 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id A71BDA807DA; Tue, 16 Jun 2015 11:45:01 +0200 (CEST)
Date: Tue, 16 Jun 2015 09:45:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 5/8] winsup/doc: Convert utils.xml to using refentry
Message-ID: <20150616094501.GC31537@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1434371793-3980-1-git-send-email-jon.turney@dronecode.org.uk> <1434371793-3980-6-git-send-email-jon.turney@dronecode.org.uk> <20150615171147.GE26901@calimero.vinschen.de> <557FEC25.8030303@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="R7Dyui215VKdTDYA"
Content-Disposition: inline
In-Reply-To: <557FEC25.8030303@dronecode.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2015-q2/txt/msg00073.txt.bz2


--R7Dyui215VKdTDYA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1010

On Jun 16 10:28, Jon TURNEY wrote:
> On 15/06/2015 18:11, Corinna Vinschen wrote:
> >On Jun 15 13:36, Jon TURNEY wrote:
> >>Convert utils.xml from using a sect2 to using a refentry for each utili=
ty
> >>program.
> >>
> >>Unfortunately, using refentry seems to tickle a bug in dblatex when gen=
erating
> >>pdf, which appears to not escape \ properly in the latex for refentry, =
so use
> >>fop instead.
> >
> >Uhm... wasn't Yaakov's patch from 2014-11-28 explicitely meant to drop
> >the requirement to use fop andd thus java?
> >
> >Is there really no other way to handle that, rather than reverting to
> >fop?
>=20
> Now I try again --with-dblatex, it works fine, so that part of the patch =
can
> be removed.
>=20
> I can only guess I must have had some other markup error causing me
> problems, which has since been fixed.

I'm relieved :}


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--R7Dyui215VKdTDYA
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVf/AdAAoJEPU2Bp2uRE+gQ3YP/1JuH4svCDE0UZ1ZsR+rImJd
R0S9GdYBLg2z8Y+wNzUrtwAWrJNgAvrc++ro7Joau5vdu93SQXTTeO6EhOpYHV7R
c2wFkg4FrNtKdBYovdWtiW28QZcgoscSlNa+ERyUSaSP4AL9lMF3PAmDDEkxL0dQ
50HQ/OnMiMWL6u4bOifz7YCabyAI5/o8pBw942pHUASqVOXQU2Lry9AjOWZUTI11
TUClK1vFr9UIh9t5ibzyJO2dlZLMXvLpV/M+PXscogNGqeCbITnCye0Q3dB5kans
YROwweHdyxogzEJWHC0jwleIIjUoPFX74TeTpt8442j3P4ww78Is/3CJUFLIoQK3
z4M+4bkGHnoKj7DsOwWa504bZ7vyjQcoxb43FAV1o57kje9VbgzqKXyx46sEBryy
Td830LWEvkMADI+BtTitBGSmHkctv9t4/aEq5TwGL+cHq3fJGZPQ/E6PLa+wF9P+
bsuICFgrTKUhOGMGhJvB37uTFPLaEQeD2XSGKJEPLr/VC0BmiyQZFGWQD3Xz/bk0
CAr9Sohlttk1UwBENlKe0Mct5HUMv1L9W1lX4JIef6MmuDWxBOWZfKwNZp3nOJ5n
TDW4usC1RUYKs0WRLbt/gU+2f/5fhvM/CMKGVTObN79eIW/kYu9Tld5pY3A0S2RY
w3QdiTpxSSP8IawyJlZ4
=M94E
-----END PGP SIGNATURE-----

--R7Dyui215VKdTDYA--
