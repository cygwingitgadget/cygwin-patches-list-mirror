Return-Path: <cygwin-patches-return-8197-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 69938 invoked by alias); 18 Jun 2015 20:05:20 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 69925 invoked by uid 89); 18 Jun 2015 20:05:19 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-5.4 required=5.0 tests=AWL,BAYES_00,KAM_LAZY_DOMAIN_SECURITY autolearn=no version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 18 Jun 2015 20:05:17 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 5EE98A8084C; Thu, 18 Jun 2015 22:05:14 +0200 (CEST)
Date: Thu, 18 Jun 2015 20:05:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/5] Generate cygwin-api manpages
Message-ID: <20150618200514.GR31537@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1434544626-2516-1-git-send-email-jon.turney@dronecode.org.uk> <20150617134936.GK31537@calimero.vinschen.de> <5581994C.6070107@dronecode.org.uk> <20150617162753.GN31537@calimero.vinschen.de> <5582A170.9010305@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="YYM4jLJxzFJ63wjS"
Content-Disposition: inline
In-Reply-To: <5582A170.9010305@dronecode.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2015-q2/txt/msg00098.txt.bz2


--YYM4jLJxzFJ63wjS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2398

On Jun 18 11:46, Jon TURNEY wrote:
> On 17/06/2015 17:27, Corinna Vinschen wrote:
> >On Jun 17 16:59, Jon TURNEY wrote:
> >>On 17/06/2015 14:49, Corinna Vinschen wrote:
> >>>On Jun 17 13:37, Jon TURNEY wrote:
> >>>>This patch set changes the DocBook source XML for the Cygwin API refe=
rence to
> >>>>use refentry elements, and also generates man pages from that.
> >>>>
> >>>>Again, note that after this, the chunked html now has a page for each=
 function,
> >>>>rather than one containing all functions.
> >>>
> >>>Patchset approved, basically, except...
> >>>
> >>>The next cygwin.cygport file will explicitly exclude the man pages
> >>>section 1.  But it won't exclude section 3, and I'm rather not hot
> >>>on excluding each newly generated API file explicitly.
> >>
> >>Yes, I hadn't noticed that regex.3 manpage, which makes things a bit of=
 a
> >>pain.
> >>
> >>But maybe you write in cygwin_devel_CONTENTS something like
> >>"--exclude=3Dusr/share/man/ usr/share/man/man3/regex.3.gz
> >>usr/share/man/man7/regex.7.gz" ?
> >
> >exclude?  This would require to move both files to cygwin-doc
> >as you outlined below.  It would essentially remove all man pages
> >from the cygwin core packages and then we exclude usr/share/man,
> >as you outlined below as well.
>=20
> Hmm?  I thought perhaps this would exclude everything under usr/share/man,
> then include regex.3 and regex.7

I just tried it and it works.  So that's an option for the time being,
I guess.  Btw., I added a tweak to Makefile.in to skip *.3 and *.7 files
in the release dir :)

> >>I think this just needs 'make info' adding to the .cygport, as newlib
> >>doesn't build this on 'make all'
> >
> >   libc.info and libm.info are built by default, but they are not
> >   installed with `make install'
>=20
> That seems a little odd.

Indeed, but that could be done manually in the cygport file if required.
I'm not that close to the newlib build system...

> >>If the suggestion above doesn't work, I guess possible approaches to
> >>coordination are:
> >>
> >>* Move regex.[37] from cygwin-devel to cygwin-doc, and exclude
> >>/usr/share/man
> >
> >... this sounds good to me.
>=20
> Let's do things that way, then.

Or the above, whatever is easier for the start.


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--YYM4jLJxzFJ63wjS
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVgyR6AAoJEPU2Bp2uRE+gIcAP/ApBUILWMAZFwv3iVNdzwAUx
UeGvuVugBV5xoBFEAkVYAztFuL21RcU3LU3z+YmQVq7Sek+x1OCaUTg5QbMNFn25
8PhRzOx4C2cyGc+e+IEN5YdVlwgZLMIubn7sikU/ISnuaUstzX0rtNDRPQr+2OH2
yiyn1ZIbSk7D+Ka+HlhELNaJrZvjyy4oHr3ZcZc8NkbwBDDnn6aVx2ldz2AeFYb6
AAWYh1CQ8Zukt5iomK+/nHRGDx87hhOGmGuQHO+gPl/lF/zIvLBmB3078HypihvZ
sY1pL4aTublfT28QXLsasDxQsG3riBsTUdeX8FnfWZY+vtpg4ac3hbCco0ZtnM4L
qr968MYGRswHj93vE/R8JsX/Nmts/GxZAUpFpIsUzqYOFGVCWwReM+7pkfL/iOHV
FmIcS/bY4oGrxr9MiEoVjJoCuoL5V6Jcp+gPGM4YTSUmjjnJEZwR6uYC04Ki+jJT
jJc1G3Dht6qTT6OWHt5iJe5aPckKC6MkEWh7jKyWStqjalSe2qIDm86ThY/tmWgj
jHC7bltFw/DgLwd4n6JPO7aNT5akHsuqT+KXIivY3otsxnT97s/rEMc2EXXeRZFU
zVI41rqE7eTvAEB5Uv48VkqbEacNAd9++l51vR4bBPFrJF4imUU3/Gfvi7ijHaj7
vnTA4T301W2OmsU+kNYV
=2SqD
-----END PGP SIGNATURE-----

--YYM4jLJxzFJ63wjS--
