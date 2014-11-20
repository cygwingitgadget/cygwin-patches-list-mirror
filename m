Return-Path: <cygwin-patches-return-8035-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 32683 invoked by alias); 20 Nov 2014 08:30:26 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 32669 invoked by uid 89); 20 Nov 2014 08:30:25 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-5.9 required=5.0 tests=AWL,BAYES_00 autolearn=ham version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 20 Nov 2014 08:30:25 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 9EF268E0A64; Thu, 20 Nov 2014 09:30:22 +0100 (CET)
Date: Thu, 20 Nov 2014 08:30:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Fix performance on 10Gb networks
Message-ID: <20141120083022.GH3810@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <CAE3zD3WZU8ZvqwW69f4hs+vFigShstjvh9HKuHGewXTLDsx==w@mail.gmail.com> <20141118204344.GJ3151@calimero.vinschen.de> <CAE3zD3WE4ELw0eGHW=Y6Pvo+5b2ezV48UhzhdGxA+_uJXmOm=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;	protocol="application/pgp-signature"; boundary="MrRUTeZlqqNo1jQ9"
Content-Disposition: inline
In-Reply-To: <CAE3zD3WE4ELw0eGHW=Y6Pvo+5b2ezV48UhzhdGxA+_uJXmOm=A@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2014-q4/txt/msg00014.txt.bz2


--MrRUTeZlqqNo1jQ9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1397

On Nov 19 18:18, Iuliu Rus wrote:
>  You are right, of course. We initially thought it has to be a
> multiple of page_size but it doesn't. I just re-tested with 63k and it
> gives good perf too.
> We get 600Mbits/second compared with 10Mb for the old default.
> Attached the modified patch.
>=20
> On Tue, Nov 18, 2014 at 8:43 PM, Corinna Vinschen
> <corinna-cygwin@cygwin.com> wrote:
> > Hi Iuliu,
> >
> > On Nov 18 19:30, Iuliu Rus wrote:
> >> Hello,
> >> Google is running Cygwin apps on its 10Gb networks and we are seeing
> >> extremely bad performance in a couple of cases. For example, iperf
> >> with the defaults results in only 10Mbits/sec.
> >> We tracked this down to a combination of non-blocking sockets with
> >> Nagle+delayed ack kicking in, since the apps eventually end up sending
> >> a very small packets (2 bytes).
> >> We have a case open against Microsoft but since everything is moving
> >> very slow we would like to work around by picking socket buffers that
> >> are multiple of 4k.
> >
> > Thanks for the patch.  One question:
> >
> >> Change log:
> >> 2014-11-18 Iuliu Rus <...>
> >>
> >> * net.cc Change default values for socket buffers to fix performance
> >> on 10Gb networks.

Patch applied.


Thanks a lot,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--MrRUTeZlqqNo1jQ9
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUbaaeAAoJEPU2Bp2uRE+gdLEP/2uO3hPBm+3mbZa5RMP+Xexq
Lo8HTuDwZGWBYPLFFpmbkVEGGOw9/yewSrht9cMjp4bLus02utX+zSFb22cyOM31
912ZdYp2dXF8pZYLle5BAe833zOS4pIgMuHQU47E4CLVf9fzSuZVaQ4CFQEeWP7M
MSfTG97P9p+Od1u8oNnq+907A2fZB7H9MSF15Y+ZLl3zxU0aceqkPJ54GiD7cwck
GS1nUp2kz2iDipW/XBjjXH9idlbA1/6pHy49BMDn2ADWeA9u4PH4v+bt6AHhwA0d
0SZuPTPh9MqH+pqAwNyvk4RqOdT3Rcjgbx0vzwu9gunxQLlGVORdfDojJAecuXf/
QjwXkTLEQ90toY9Z7sEN068YpSK6bL6bbsXP8dtimJHSr2O2zYRZdLcd9sSizWwC
SOfam0B4DCeiIfOd1zmxVDD3TbTjMTfa//dMugbieBSkZNQDKJ02wNPkPAbBvHaE
5NDOu1PEKfxwHvf/I9dTQEkLPMsz40lkes9c+u9++Hcem9s4TdgySNgJ+haooOfS
XXHcbav9Ba8VQpU2+rlPaYFnmm3mYE/xKo8F7TadNIu7LMx6JY659dgYCGiSiafo
OVTOy6PccghamTyz7tFN5ylJWFKL5Rzil0FCEnNavgLXTVLQwCqpWAMOWA7Y4wSc
6sHekGLfdUdAf1AZyvJy
=Hx3H
-----END PGP SIGNATURE-----

--MrRUTeZlqqNo1jQ9--
