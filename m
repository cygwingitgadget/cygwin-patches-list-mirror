Return-Path: <cygwin-patches-return-8888-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 70786 invoked by alias); 25 Oct 2017 15:03:50 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 70776 invoked by uid 89); 25 Oct 2017 15:03:50 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-123.1 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_BRBL_LASTEXT,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=H*R:D*cygwin.com, H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 25 Oct 2017 15:03:48 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id E91DE721BBD2E	for <cygwin-patches@cygwin.com>; Wed, 25 Oct 2017 17:03:40 +0200 (CEST)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id 3354B5E049B	for <cygwin-patches@cygwin.com>; Wed, 25 Oct 2017 17:03:40 +0200 (CEST)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 2512BA818DE; Wed, 25 Oct 2017 17:03:40 +0200 (CEST)
Date: Wed, 25 Oct 2017 15:03:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] cygcheck: Fix parsing of file names containing colons
Message-ID: <20171025150340.GI22429@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20171025112316.13004-1-kbrown@cornell.edu> <20171025121138.GF22429@calimero.vinschen.de> <20171025121912.GG22429@calimero.vinschen.de> <b995c1b4-81cc-8d6b-91da-a44018393499@cornell.edu> <20171025141940.GH22429@calimero.vinschen.de> <c6e21bcd-b058-1c74-6732-a62ab0b7530f@cornell.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="924gEkU1VlJlwnwX"
Content-Disposition: inline
In-Reply-To: <c6e21bcd-b058-1c74-6732-a62ab0b7530f@cornell.edu>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-SW-Source: 2017-q4/txt/msg00018.txt.bz2


--924gEkU1VlJlwnwX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 3034

On Oct 25 10:56, Ken Brown wrote:
> On 10/25/2017 10:19 AM, Corinna Vinschen wrote:
> > On Oct 25 09:38, Ken Brown wrote:
> > > On 10/25/2017 8:19 AM, Corinna Vinschen wrote:
> > > > On Oct 25 14:11, Corinna Vinschen wrote:
> > > > > Hi Ken,
> > > > >=20
> > > > > On Oct 25 07:23, Ken Brown wrote:
> > > > > > Up to now the function winsup/utils/dump_setup.cc:base skips pa=
st
> > > > > > colons when parsing file names.  As a result, a line like
> > > > > >=20
> > > > > >     foo foo-1:2.3-4.tar.bz2 1
> > > > > >=20
> > > > > > in /etc/setup/installed.db would cause 'cygcheck -cd foo' to re=
port 4
> > > > > > as the installed version of foo insted of 1:2.3-4.  This is not=
 an
> > > > > > issue now, but it will become an issue when version numbers are
> > > > > > allowed to contain epochs.
> > > > > > ---
> > > > > >    winsup/utils/dump_setup.cc | 2 +-
> > > > > >    1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > >=20
> > > > > > diff --git a/winsup/utils/dump_setup.cc b/winsup/utils/dump_set=
up.cc
> > > > > > index 320d69fab..3922b18f8 100644
> > > > > > --- a/winsup/utils/dump_setup.cc
> > > > > > +++ b/winsup/utils/dump_setup.cc
> > > > > > @@ -56,7 +56,7 @@ base (const char *s)
> > > > > >      const char *rv =3D s;
> > > > > >      while (*s)
> > > > > >        {
> > > > > > -      if ((*s =3D=3D '/' || *s =3D=3D ':' || *s =3D=3D '\\') &=
& s[1])
> > > > > > +      if ((*s =3D=3D '/' || *s =3D=3D '\\') && s[1])
> > > > >=20
> > > > > I think this is a simplified way to test for the colon in paths l=
ike
> > > > > C:/foo/bar.  Nothing else makes sense in this context.
> > > > >=20
> > > > > I'm not sure how much we care, but maybe we shoulkd fix the test =
to
> > > > > ignore the colon only if it's the second character in the incoming
> > > > > string?
> > > >=20
> > > > Not "ignore", but "use as a delimiter" only as 2nd char in the inpu=
t.
> > >=20
> > > I'm not sure the distinction matters in this case, since the function=
 is
> > > just trying to get the base name.  Anyway, how's the attached?
> >=20
> > Fine, thanks.
> >=20
> > But now that you mention it... why does parse_filename() call base() at
> > all?  The filenames in installed.db are just basenames anyway.  Does
> > that cover an older DB format we don't support anymore, perhaps?
>=20
> It looks like parse_filename is more-or-less copied from the function with
> the same name in the setup sources (in filemanip.cc).  In that case there
> might be a good reason to call base; I'll have to look more closely.
>=20
> > I just wonder now if we should simply remove base() and the call to it.
> >=20
> > Either way, you're right, the colon check is just useless, so your first
> > patch was entirely sufficient.
> >=20
> > What do you think?  Stick to your patch or remove base()?
>=20
> I vote for removing base.  The attached patch does this.

Pushed.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--924gEkU1VlJlwnwX
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZ8KfLAAoJEPU2Bp2uRE+gRAcP+wezu6zKKbZkoKxXJLljjjON
pUlKl9XtQgWZE/tnA1rdy+afXNwVOYv7VWwGCcIecbULU99ikodWwWPU/0ZmKbh8
pja4smR8BZ+fdMXCJpTB1F6kvruHKLwdD252CzibiwFtB8JB9b21lynLAB+sAsy5
mvyUhaQ5ffja7zF/IUwbEtSI2H8JJ5G27TdqvOGWiHv/panfo1xXsBB+ijyCWQOW
3TJAsTsVRHGk1uC2+0AbOfupmvvxfKLSLadqkP/xIlvlx3lDU1fRutKHfA83vSLK
6BgjvOQF7WRRm9bSM5hhc3sX1Cgtyu7OqbdF+xx5br+9RewhCldblIMzKB88WiQH
yL75pOtwXI9nkOpduzCBY5RFs5Qd7B0pvNtzYRt4By14lbyxlOjXS/gin3cicK5R
LYZbQLf9adnSKB7FKxmSf2jQzxZSe3Z4lkteBkgMxVz1y0of7mngJqvLbKHHOW/X
CWjtokFtorzMZLPFCHPs6ID58Hpx/Lr6l5kDDCIVKRnltOF+fHagx+8Ljaxo+EKm
x6fin3EMSTIs3x8eCG8hxMFQoNI5eMSRoOYBvBN1ZnWyA1X0jv9JvVtzZ21R/2+c
8qbEHtM3wXZKmO3SroCFHVLNT+YwrjCbDoZKldgX6DEw9UZSpWJHJI+7HelHTXsq
/QkszIu5KsrWEFB2QrrL
=JTc+
-----END PGP SIGNATURE-----

--924gEkU1VlJlwnwX--
