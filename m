Return-Path: <cygwin-patches-return-8036-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2781 invoked by alias); 20 Nov 2014 08:37:07 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 2768 invoked by uid 89); 20 Nov 2014 08:37:06 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-5.9 required=5.0 tests=AWL,BAYES_00 autolearn=ham version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 20 Nov 2014 08:37:04 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 103468E0A64; Thu, 20 Nov 2014 09:37:02 +0100 (CET)
Date: Thu, 20 Nov 2014 08:37:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Fix performance on 10Gb networks
Message-ID: <20141120083701.GI3810@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <CAE3zD3WZU8ZvqwW69f4hs+vFigShstjvh9HKuHGewXTLDsx==w@mail.gmail.com> <20141118204344.GJ3151@calimero.vinschen.de> <CAE3zD3WE4ELw0eGHW=Y6Pvo+5b2ezV48UhzhdGxA+_uJXmOm=A@mail.gmail.com> <CAD97vhocMs1xoSoPsLWzJrMqahkONyx_KrVYwFJSeoupvfsvRQ@mail.gmail.com> <CAD97vhrodbPM8AgC1JLXyrMSr3v01p6ZLfPQnDooW-+NtK0fLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;	protocol="application/pgp-signature"; boundary="uJrvpPjGB3z5kYrA"
Content-Disposition: inline
In-Reply-To: <CAD97vhrodbPM8AgC1JLXyrMSr3v01p6ZLfPQnDooW-+NtK0fLg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2014-q4/txt/msg00015.txt.bz2


--uJrvpPjGB3z5kYrA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 795

Hi Lev,

On Nov 19 14:30, Lev Bishop wrote:
> Maybe my analysis from some years ago can be relevant here? Another
> issue with delayed acks and winsock. I haven't been following cygwin
> for some time, so not sure exactly what the status is:
> https://cygwin.com/ml/cygwin-patches/2006-q2/msg00031.html

The code changed quite a bit in the meantime.  Your patch was against
Cygwin 1.5.x, so there's IPv6 support, native 64 bit support, dropped
support for older OS versions prior to XP SP3, etc.

But there are certainly still good chances for optimization.  I would
very much appreciate if you would take another look into this.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--uJrvpPjGB3z5kYrA
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUbagtAAoJEPU2Bp2uRE+gJ+gQAJ02j4oPp7DpqkwU41/dzXnC
cxZyrGCMS4H9faNF2mh4vS3BjMEyRCKEZrLamGhUz4AMqXi6FzQdwfUe0LUBftbD
BWEZcea1bw20a3WvM55j8Bw7EUbkjlZV+Y9YTrTgp59Yer4uNZliLfO9/cpEAsOe
JOEak6NytjxpI/WFFLPesyhgEtLWay3vyPwyruLPNb0BL0PoiQmS/KHr4u6htqN3
wax/wLKohdAJbpwCaRMZWf+RqJlnGkARd9bs8c0cp1eQMy8AZWyCQ6+N4oJSDXIx
0R5++Onq5aY1nXbHoNz59151mlbmRmt9zfrfagnro1B8jpZwBZB7UUiVyrU4ztCG
Wur+/3MyEkGQo3esjTYSpqRXQj33ec32V2FKnB6fratM3FizOjvM3UwdeyZHWQQx
Z79CUE7u8DppM47QWiC6N/LWVtN5Zgb4tXytsIyhcZE4ibk1w9LcAZflB0WCWk7D
nQE/m/b6mpJuTL3lJdzFT2VMBRs3mFcPa6s5V+H2oKgQrYzVCoHnqZFYYtCrGJBF
kt/InLArAegBHi+8htwHRj1kYxmgo1cavEDtA8b9BuiGyB6NsVdD8s01UZNv0IWQ
8G4nvloDO6T73RmODY057d1LG38v/03VTY9SZm0HppNkK2BDw+4wmwwZ2A1a5Y75
wz7NiHnAlNhHNT9zFC86
=cNMJ
-----END PGP SIGNATURE-----

--uJrvpPjGB3z5kYrA--
