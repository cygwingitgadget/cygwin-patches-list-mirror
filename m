Return-Path: <cygwin-patches-return-2932-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 20701 invoked by alias); 4 Sep 2002 09:04:55 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 20686 invoked from network); 4 Sep 2002 09:04:54 -0000
Subject: Re: mingw - free_osfhnd
From: Robert Collins <rbcollins@cygwin.com>
To: Danny Smith <danny_r_smith_2001@yahoo.co.nz>
Cc: cygwin-patches@cygwin.com, serassio@libero.it
In-Reply-To: <20020904085629.97623.qmail@web14502.mail.yahoo.com>
References: <20020904085629.97623.qmail@web14502.mail.yahoo.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-3Bhpm1BBly5YhQaRbMC1"
Date: Wed, 04 Sep 2002 02:04:00 -0000
Message-Id: <1031130306.9180.12.camel@lifelesswks>
Mime-Version: 1.0
X-SW-Source: 2002-q3/txt/msg00380.txt.bz2


--=-3Bhpm1BBly5YhQaRbMC1
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Content-length: 1537

On Wed, 2002-09-04 at 18:56, Danny Smith wrote:
>  --- Robert Collins <rbcollins@cygwin.com> wrote: > On Wed, 2002-09-04 at
> 13:29, Danny Smith wrote:
> > >  --- Robert Collins <rbcollins@cygwin.com> wrote: > Changelog:
> > > >=20
> > > > 2002-09-04  Robert Collins  <robertc@cygwin.com>
> > > >=20
> > > > 	* msvcrt.def: Export _free_osfhnd.
> > > >=20
> > > > Is this ok Earnie/Danny?
> > >=20
> > > I can't see this in my msvcrt.dll.  Where do you see it?
> > > Danny
> >=20
> > Its one of the undocumented internals... along with _get_osfhnd and
> > _set_osfhnd. (I think that _get_osfhnd is there already).
>=20=20
> No, only the *_osfhandle functions that are documented.=20
>=20
> >=20
> > The NT Native port of squid, build with Visual C uses this when linking
> > to MSVCRT. As a reference in 1999 XEmacs started using this call, but
> > they defined it locally rather than patching mingw from what I can tell.
> >=20
> > Rob
> >=20
>=20
> Okay, but do you see it in mscvrt.dll?  I can't see it in the export table
> anywhere.  I would accept that the internals may be available from the st=
atic
> libc but not from dll (ms doesn't do the --export-all, for good reason, I
> suspect)

Hmm, well there is an interesting thing then. I simply added it to the
def, rebuilt and copied that to /usr/include/mingw. Then I linked the
program that had been recieving mising symbols on link, and voila' - it
worked.

Leave it with me/Guido until we get the whole program ported. It may be
that I haven't actually used it fully yet.

Rob

--=-3Bhpm1BBly5YhQaRbMC1
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part
Content-length: 189

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9dcy+I5+kQ8LJcoIRAs4PAJ91pGGwQb2hGovegW8DumrFXLaJ0wCgpkH6
JeCvS5bpUcx3dXEmWf0C6yw=
=zvUr
-----END PGP SIGNATURE-----

--=-3Bhpm1BBly5YhQaRbMC1--
