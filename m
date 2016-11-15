Return-Path: <cygwin-patches-return-8647-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 68881 invoked by alias); 15 Nov 2016 16:20:13 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 68827 invoked by uid 89); 15 Nov 2016 16:20:13 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-101.5 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=mass, U*corinna-cygwin, sk:corinna, corinna-cygwin@cygwin.com
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 15 Nov 2016 16:19:59 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id 3E1EB721E281A	for <cygwin-patches@cygwin.com>; Tue, 15 Nov 2016 17:19:56 +0100 (CET)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id 8DF2B5E008B	for <cygwin-patches@cygwin.com>; Tue, 15 Nov 2016 17:19:55 +0100 (CET)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 7DD4CA8056F; Tue, 15 Nov 2016 17:19:55 +0100 (CET)
Date: Tue, 15 Nov 2016 16:20:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Return the correct value for sysconf(_SC_PAGESIZE)
Message-ID: <20161115161955.GD25086@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <CAOTD34ZMkY=Sfp6-8AFDg_Q=7NZB2oS+=QthfWauoboP6=szfg@mail.gmail.com> <20161115145849.GA25086@calimero.vinschen.de> <CAOTD34ajMRiL0RMJTrVvzK8bMwAta3XJ8Pi7sk27ww1B4HLp3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="TybLhxa8M7aNoW+V"
Content-Disposition: inline
In-Reply-To: <CAOTD34ajMRiL0RMJTrVvzK8bMwAta3XJ8Pi7sk27ww1B4HLp3Q@mail.gmail.com>
User-Agent: Mutt/1.7.1 (2016-10-04)
X-SW-Source: 2016-q4/txt/msg00005.txt.bz2


--TybLhxa8M7aNoW+V
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2165

On Nov 15 16:47, Erik Bray wrote:
> On Tue, Nov 15, 2016 at 3:58 PM, Corinna Vinschen
> <corinna-cygwin@cygwin.com> wrote:
> > On Nov 15 14:51, Erik Bray wrote:
> >> Greetings,
> >>
> >> Currently sysconf(_SC_PAGESIZE) returns the value of
> >> wincap.allocation_granularity()--a change I *think* had to have been
> >> made by mistake in
> >> https://cygwin.com/git/gitweb.cgi?p=3Dnewlib-cygwin.git;a=3Dcommit;f=
=3Dwinsup/cygwin/sysconf.cc;h=3D177dc6c7f6d0608ef6540fd997d9b444e324cae2
> >>
> >> There's no obvious reason, anyways, that this value should be returned
> >> and not the actual page size.
> >
> > That's no accident, but a deliberate decision.  Originally we used the
> > page size at this point, but that's long ago.  This has been discussed
> > on the cygwin-developers mailing list years ago.  The problem is the
> > POSIX assumption that the allocation granularity equals the page size.
> > The only working solution which does not break assumptions is to return
> > the allocation granularity as page size.
>=20
> Okay, sorry for suggesting otherwise.  When I looked at that commit it
> seemed like a there was a lot of mass renaming going on, so I thought
> it might have been an accident.  I didn't see the threads where this
> was discussed.
>=20
> I see the reason for the change now, but the fact remains
> sysconf(_SC_PAGESIZE) cannot, then, be relied on to make any
> memory-related calculations from page counts.

What do you mean?  If you call sysconf(_SC_PHYS_PAGES) or
sysconf(_SC_AVPHYS_PAGES) you get the number of pages in _SC_PAGESIZE
chunks so all is good.

> Is there a different
> (posix-compliant) way to get the actual page size, or at least maybe
> it could be somewhere in /proc?

There is no good reason to use the non-POSIXy page size.  It doesn't
help you in the least for any pagesize-related functionality.  Mmap
as well as malloc and friends only work with _SC_PAGESIZE sized pages.

It sounds as if you're looking for a solution for which there's no
problem...


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--TybLhxa8M7aNoW+V
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYKzWrAAoJEPU2Bp2uRE+gU7gP/jBlUTWYvl5uVpPAtmIlpnaY
HgXHotvU7aECOb6xLE1OXoq/d9SyHKcf6A8C/C9XVAKDGx29Kp6973mWf3cJ2bgp
OfwgObQQQOxS9W02njMU+LK1qtmTlbVh6XxXSNYr/lswkTD8j6HoqBDuAFU7wWBn
g5OtRCJKLioWWiixfOhx35mEqQG/Ph0AyiAAt/VZZHHHMyjglJOHS17gxxjWdzVJ
T98DDf+QP7FldTfbx+Gb3hK0ARbeYkYN5nTpTf1pOWyhbAR0WoPiQSBi4zcoIf+b
gGtM4ep8HgfnPytxy2Zt33M+amNlRcvOihR+EwHSDpgbkDjP8Mc25CO3I4kvQhx0
n+pqqRpc2KqCRh0xss/k3hBHzOQXIkLZp/vP1j7QKNHVHQXNs2zBEzv6W0oBO8RB
oanHXaqmu0DAyiJ0qVn0RYw+g+h0rFPEElMHd9NU0pdHPGVCpk0B8Q1Qt4CuuHwK
8kJTREMTNNV7cE31j0VdN4T2vUVDjbRWZVbkG88g4MLzztAyiN5iAeyb8ugziAPL
dnBdSsXe/z9970GT2yjST3OZ2mzbo62M1FC2XLK+WN1rL8F43tjf/3J26onM5nzO
eO9A2n7IZb99LTmSNgOpoJCvWITdGtdjRoJ2ciSeqhYcGSbzP40RJtUYPV345N7I
mv0/JjXXWHn1oP8lvXrH
=5hRl
-----END PGP SIGNATURE-----

--TybLhxa8M7aNoW+V--
