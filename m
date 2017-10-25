Return-Path: <cygwin-patches-return-8884-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 79398 invoked by alias); 25 Oct 2017 12:19:21 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 79378 invoked by uid 89); 25 Oct 2017 12:19:20 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-123.1 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_BRBL_LASTEXT,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=H*R:D*cygwin.com, H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 25 Oct 2017 12:19:15 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id EECF7721E280C	for <cygwin-patches@cygwin.com>; Wed, 25 Oct 2017 14:19:12 +0200 (CEST)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id 4A4195E049B	for <cygwin-patches@cygwin.com>; Wed, 25 Oct 2017 14:19:12 +0200 (CEST)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 3B543A80758; Wed, 25 Oct 2017 14:19:12 +0200 (CEST)
Date: Wed, 25 Oct 2017 12:19:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] cygcheck: Fix parsing of file names containing colons
Message-ID: <20171025121912.GG22429@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20171025112316.13004-1-kbrown@cornell.edu> <20171025121138.GF22429@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="LTeJQqWS0MN7I/qa"
Content-Disposition: inline
In-Reply-To: <20171025121138.GF22429@calimero.vinschen.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-SW-Source: 2017-q4/txt/msg00014.txt.bz2


--LTeJQqWS0MN7I/qa
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1559

On Oct 25 14:11, Corinna Vinschen wrote:
> Hi Ken,
>=20
> On Oct 25 07:23, Ken Brown wrote:
> > Up to now the function winsup/utils/dump_setup.cc:base skips past
> > colons when parsing file names.  As a result, a line like
> >=20
> >   foo foo-1:2.3-4.tar.bz2 1
> >=20
> > in /etc/setup/installed.db would cause 'cygcheck -cd foo' to report 4
> > as the installed version of foo insted of 1:2.3-4.  This is not an
> > issue now, but it will become an issue when version numbers are
> > allowed to contain epochs.
> > ---
> >  winsup/utils/dump_setup.cc | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/winsup/utils/dump_setup.cc b/winsup/utils/dump_setup.cc
> > index 320d69fab..3922b18f8 100644
> > --- a/winsup/utils/dump_setup.cc
> > +++ b/winsup/utils/dump_setup.cc
> > @@ -56,7 +56,7 @@ base (const char *s)
> >    const char *rv =3D s;
> >    while (*s)
> >      {
> > -      if ((*s =3D=3D '/' || *s =3D=3D ':' || *s =3D=3D '\\') && s[1])
> > +      if ((*s =3D=3D '/' || *s =3D=3D '\\') && s[1])
>=20
> I think this is a simplified way to test for the colon in paths like
> C:/foo/bar.  Nothing else makes sense in this context.
>=20
> I'm not sure how much we care, but maybe we shoulkd fix the test to
> ignore the colon only if it's the second character in the incoming
> string?

Not "ignore", but "use as a delimiter" only as 2nd char in the input.

Sorry,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--LTeJQqWS0MN7I/qa
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZ8IFAAAoJEPU2Bp2uRE+gY3UP/RQidYy/DjzHP13jpBHuj5Yt
6fCewsCs+OS0Meblr2gAS55bAwdrKpyCcrrP3D5V7gw//OdOLdeFD8VBvYLH9uw5
39rZsUAktMWVkHnHwOUoixoBy4G5P4nSC0R59cx06jrkKmzl2StuxAOIVJePRXWR
KJomPcODedDaaVBOcVzHHtGWpm3O3AqOcgxDWP95nc8jw3Nl60IZP8V2RIJf86+k
DS3Aj+X3I5yUEJ4XfaPnLO/ESSs4AGFMA9gL5xo7mxJcI0iw7o2YJh7J1LtirC5D
TNBFj+r+sNxHVLuiW+GwceNpGjbjOElHjSzPrNajEOsgjoU5k0PYZtfiur+2ddl8
jr0DJxugc+AKHbkvSNLsmJk9TM+ef5VdU6VAcLKw7lobsX88leyx/K6zVHFQOtPx
djgmb8mMjki3t8M/P3GAg22BiJbfafUE9MfM/2D+Q59ocAN7dgknOSsE+SHN13OO
+5feQpWoNpZGOk13ZWWegn1Z3pVcMP6CAb/BAph144KYEDnHaxbXBjS+06CoVP7y
MeEFUPV+R3GsvmK0ojOkdpJ4RMi68+TLgJlwkv8Gy0zCg8zRZoe05Ll0R6dssYDQ
yHy2G+iZoQEd22vUg8tQeE1GmR9/q9JTwvtlJsB6PguD9PhlehGNF56mdzlFQVzR
Y7FES4qHGrGTOCNWnFDU
=1fEd
-----END PGP SIGNATURE-----

--LTeJQqWS0MN7I/qa--
