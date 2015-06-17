Return-Path: <cygwin-patches-return-8191-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 97352 invoked by alias); 17 Jun 2015 16:28:00 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 97340 invoked by uid 89); 17 Jun 2015 16:28:00 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-5.4 required=5.0 tests=AWL,BAYES_00,KAM_LAZY_DOMAIN_SECURITY autolearn=no version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 17 Jun 2015 16:27:55 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 48CD8A807BF; Wed, 17 Jun 2015 18:27:53 +0200 (CEST)
Date: Wed, 17 Jun 2015 16:28:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/5] Generate cygwin-api manpages
Message-ID: <20150617162753.GN31537@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1434544626-2516-1-git-send-email-jon.turney@dronecode.org.uk> <20150617134936.GK31537@calimero.vinschen.de> <5581994C.6070107@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="lBPdJKrYqo3eKYSb"
Content-Disposition: inline
In-Reply-To: <5581994C.6070107@dronecode.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2015-q2/txt/msg00092.txt.bz2


--lBPdJKrYqo3eKYSb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2984

On Jun 17 16:59, Jon TURNEY wrote:
> On 17/06/2015 14:49, Corinna Vinschen wrote:
> >On Jun 17 13:37, Jon TURNEY wrote:
> >>This patch set changes the DocBook source XML for the Cygwin API refere=
nce to
> >>use refentry elements, and also generates man pages from that.
> >>
> >>Again, note that after this, the chunked html now has a page for each f=
unction,
> >>rather than one containing all functions.
> >
> >Patchset approved, basically, except...
> >
> >The next cygwin.cygport file will explicitly exclude the man pages
> >section 1.  But it won't exclude section 3, and I'm rather not hot
> >on excluding each newly generated API file explicitly.
>=20
> Yes, I hadn't noticed that regex.3 manpage, which makes things a bit of a
> pain.
>=20
> But maybe you write in cygwin_devel_CONTENTS something like
> "--exclude=3Dusr/share/man/ usr/share/man/man3/regex.3.gz
> usr/share/man/man7/regex.7.gz" ?

exclude?  This would require to move both files to cygwin-doc
as you outlined below.  It would essentially remove all man pages
from the cygwin core packages and then we exclude usr/share/man,
as you outlined below as well.

So...

> >Do you have an idea how far away we are from including the cygwin-doc
> >package into the cygwin package set?  I'm not planning a new release
> >very soon, so we can coordinate that without pressure.
>=20
> After this patch set, the remaining things are:
>=20
> * newlib libc and libm .info documentation
>=20
> I think this just needs 'make info' adding to the .cygport, as newlib
> doesn't build this on 'make all'

  libc.info and libm.info are built by default, but they are not
  installed with `make install'

> * intro.1 and intro.3 man pages for Cygwin, handwritten
>=20
> If these are worth keeping, this is straightforward
>=20
> * Cygwin User's Guide and API reference texinfo, generated from the DocBo=
ok
> XML
>=20
> as is this

  Isn't the HTML documentation sufficient?  I'm not opposed to
  keeping the texinfo's, just wondering.
>=20
> * man pages for newlib functions
>=20
> But this is a substantial piece of work.  Currently, I'm not even sure how
> this can be done in an upstreamable way.
>=20
> I am experimenting with building an alternative to the makedoc tool, which
> generates DocBook XML rather than .texinfo, which can then be processed i=
nto
> manpages and other formats, but this is far from complete.
>=20
>=20
> If the suggestion above doesn't work, I guess possible approaches to
> coordination are:
>=20
> * Move regex.[37] from cygwin-devel to cygwin-doc, and exclude
> /usr/share/man

... this sounds good to me.

> * Assuming I can finish the first 3 items on that list before the next
> cygwin release, move the newlib manpages to a new package
> (man-pages-newlib?) and make that a dependency of cygwin-doc.

As I wrote, no stress.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--lBPdJKrYqo3eKYSb
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVgaAJAAoJEPU2Bp2uRE+g0XcP/3WaRqjQW4LHrRYlwosO0VYf
9QqDc/JsFAJ0J9vxDk08Lvr0C8XcFlorOZNhjUoyFnJHO9vQjE5xrCdzR40Omtzp
LPoMkPba2wBUjaI6YO26Qo2ERYF5W97pf4f+Yc7lIo2vcjZedIzwuToUnZVeolwN
kNTHDgrgXhfKVv3EpZVMAOmvOWPR9fhMJqPFP0oKv7OcZBD88eQ7QZZFtHu1bZaZ
jfAeXiOMpKSva5n9HXgkf+uonRe0pIDPvdc3h3/KtdxxFMMaxFQY52iFwk77J0Oo
L6IlGJA5qTFQSGHNztDI3q3jxU0lQgulIDAeDuiyVbNy8jmJSoVOA39hHiaPiQv9
R1Yoo7xpF0rry2jTzKNNyn4/GW/iL3B4/yTI0IFz7lkhInTKATQzHci5+VLisyej
y6YXFaRqXuEdr9xsCQDwiwds1U47bGotavIfhHO4GLpWyXUcAd4R/3SnleFJeqoA
Xe6syXA32kUZuFQejmiBbglSf/US3fGXQpRtbOeiBthl6BCV8UbVn06I+wWSmpfy
bfa2DH/R8wfef+7o2sBc6gX4bz1TTB66qQ/xFqS58OYX/qtxu8e4DlAFaaw+5FqR
H6D7IkbV+s+TNkpz25LDxMxx1YF4Ond125aFB0f8ox97tUxWBp6FlG3DH5ylh/Vg
aD5yGXVOF9Hih3DgEGzK
=IT0K
-----END PGP SIGNATURE-----

--lBPdJKrYqo3eKYSb--
