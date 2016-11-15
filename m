Return-Path: <cygwin-patches-return-8645-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6419 invoked by alias); 15 Nov 2016 14:59:10 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 6359 invoked by uid 89); 15 Nov 2016 14:59:05 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-101.5 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=H*F:U*corinna-cygwin, bray, deliberate, H*Ad:U*cygwin-patches
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 15 Nov 2016 14:58:55 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id 9F1A5721E281A	for <cygwin-patches@cygwin.com>; Tue, 15 Nov 2016 15:58:50 +0100 (CET)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id E806F5E008B	for <cygwin-patches@cygwin.com>; Tue, 15 Nov 2016 15:58:49 +0100 (CET)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id DCCECA80567; Tue, 15 Nov 2016 15:58:49 +0100 (CET)
Date: Tue, 15 Nov 2016 14:59:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Return the correct value for sysconf(_SC_PAGESIZE)
Message-ID: <20161115145849.GA25086@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <CAOTD34ZMkY=Sfp6-8AFDg_Q=7NZB2oS+=QthfWauoboP6=szfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
Content-Disposition: inline
In-Reply-To: <CAOTD34ZMkY=Sfp6-8AFDg_Q=7NZB2oS+=QthfWauoboP6=szfg@mail.gmail.com>
User-Agent: Mutt/1.7.1 (2016-10-04)
X-SW-Source: 2016-q4/txt/msg00003.txt.bz2


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1007

On Nov 15 14:51, Erik Bray wrote:
> Greetings,
>=20
> Currently sysconf(_SC_PAGESIZE) returns the value of
> wincap.allocation_granularity()--a change I *think* had to have been
> made by mistake in
> https://cygwin.com/git/gitweb.cgi?p=3Dnewlib-cygwin.git;a=3Dcommit;f=3Dwi=
nsup/cygwin/sysconf.cc;h=3D177dc6c7f6d0608ef6540fd997d9b444e324cae2
>=20
> There's no obvious reason, anyways, that this value should be returned
> and not the actual page size.

That's no accident, but a deliberate decision.  Originally we used the
page size at this point, but that's long ago.  This has been discussed
on the cygwin-developers mailing list years ago.  The problem is the
POSIX assumption that the allocation granularity equals the page size.
The only working solution which does not break assumptions is to return
the allocation granularity as page size.


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYKyKpAAoJEPU2Bp2uRE+gbGkP/RRnMkIWHL6KQUTnKYhabugr
21kBQTiJQ8XIIZukGvBMQIZK4EJbcXHi0Tz85Eq1DcjbCngopXtw9gEDtlugElrh
enr8Y7ZMkQvd98Oc4x7Pp03KFZALdWRVifXKMCB0QlHNovYPRrfuWW3AzqF21TV4
e6ymf2NvstVlcpTHUeYd+tWonh3XZvBOUkMrHOXTeyMoldiiiYmNk7uvTZ60H+yQ
8ba/6Ji0wc/uPtBzgvXjpH53ffWkLUaOP0sgy1+9s5KkPR+S2w5nmNcPijVJtUkg
msgmBVun5h2+0WjGGGF9GF4GRsgYf5b+f4v7lVStSnnUl/r5/WN+SeKAKUrKNs0X
nwfzdepIfRwicJorzdmTwI/iJYP53TPDu9Q9HGs7ihUcEB1laS10Vt4HDAU3qzPn
KgQxI1L54xzD4ki/msKCpCrvqVEottg+c5buRwTy0C1DvkiLRtxyiOp7vmt1GenN
wkMO7YmKCeiv2rtrqmUTGUyPmWzXnEyDtdR6lEkDOGf+1B/tgFJBs6GN2ZDUlVAm
4eptAkOCrf1UEO2pA1PkzqJxm5zT35tbWhMnwcCIsjwsmZGxM8akHDD6ZEJmMx93
hWq4+fuhV13/w2BVfB97U3ZR+344+Bat9QxJyaQV/G9hO+dZ1mcQ9Ra5LqZtZ+o2
l4kmoxlXP9OKlHyjXE9r
=AKB+
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--
