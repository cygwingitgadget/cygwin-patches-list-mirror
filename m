Return-Path: <cygwin-patches-return-4383-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23468 invoked by alias); 14 Nov 2003 17:52:49 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 23439 invoked from network); 14 Nov 2003 17:52:48 -0000
Subject: Re: thunking, the next step
From: Robert Collins <rbcollins@cygwin.com>
To: cygwin-patches@cygwin.com
In-Reply-To: <20031114155716.GA16485@redhat.com>
References: <3FB4C443.2040301@cygwin.com>
	 <20031114155716.GA16485@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-FyhqZ2CItKwRYLCQOSj0"
Message-Id: <1068832363.1109.101.camel@localhost>
Mime-Version: 1.0
Date: Fri, 14 Nov 2003 17:52:00 -0000
X-SW-Source: 2003-q4/txt/msg00102.txt.bz2


--=-FyhqZ2CItKwRYLCQOSj0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Content-length: 857

On Sat, 2003-11-15 at 02:57, Christopher Faylor wrote:
> On Fri, Nov 14, 2003 at 11:02:11PM +1100, Robert Collins wrote:
> >Ok, I've now integrated and generalised Ron's unicode support mini-patch.
> >
> >So, here tis a version that, well the changelog explains the overview,=20
> >and io.h the detail.
> >
> >Overhead wise, this is reasonably low:
> >1 strlen() per IO call minimum.
> >1 unicode conversion, only if needed.
>=20
> And a couple of tests for "do we do unicode" for every call.

Which are all inline aren't they? I guess I don't see the overhead as
significant compared to the strlen generation.

> I wonder if path_conv couldn't be doing more of the upfront work.

Perhaps. I'll look at pushing the functionality in there when the dll is
happy in all other respects.

Rob
--=20
GPG key available at: <http://www.robertcollins.net/keys.txt>.

--=-FyhqZ2CItKwRYLCQOSj0
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part
Content-length: 189

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/tRZqI5+kQ8LJcoIRArmcAJ4g/TpaE1vsdRrboK+1jOkFLRAFiQCfT8NB
9WNifX09Gfyuzvm+82aSpdk=
=W3Pm
-----END PGP SIGNATURE-----

--=-FyhqZ2CItKwRYLCQOSj0--
