Return-Path: <cygwin-patches-return-4378-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 32425 invoked by alias); 14 Nov 2003 13:19:13 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 32395 invoked from network); 14 Nov 2003 13:19:10 -0000
Subject: Re: thunking, the next step
From: Robert Collins <rbcollins@cygwin.com>
To: Corinna Vinschen <cygwin-patches@cygwin.com>
In-Reply-To: <20031114125810.GV18706@cygbert.vinschen.de>
References: <3FB4C443.2040301@cygwin.com>
	 <20031114125810.GV18706@cygbert.vinschen.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-o/WRAOB93txF8t2nATfj"
Message-Id: <1068815948.1109.94.camel@localhost>
Mime-Version: 1.0
Date: Fri, 14 Nov 2003 13:19:00 -0000
X-SW-Source: 2003-q4/txt/msg00097.txt.bz2


--=-o/WRAOB93txF8t2nATfj
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Content-length: 737

On Fri, 2003-11-14 at 23:58, Corinna Vinschen wrote:
> I'm wondering if we couldn't get rid of that strlen call.  These
> functions already get a Windows path.  This path is constructed by a
> call to path_conv::check().  check() already scans the path so it
> should be simple to add a length field to path_conv, which could
> be used when calling the IOThunkState constructor.
>=20
> Right?  Wrong?

Probably yes. Passing length in (i.e. pascal style strings :}) would be
useful.

I've got a short term goal of a *working* stupidly long paths cygwin
first though :}.

I'm not hearing any 'your concepts are stuffed' feedback though, which I
like :}.

Rob
--=20
GPG key available at: <http://members.aardvark.net.au/lifeless/keys.txt>.

--=-o/WRAOB93txF8t2nATfj
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part
Content-length: 189

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/tNZLI5+kQ8LJcoIRAjIgAJ9wxZAdzuDdW/s3kL65Zmz/FOL3bwCfZ0+S
mPb2DfYzYvueFdUPmCg+GS8=
=N4gv
-----END PGP SIGNATURE-----

--=-o/WRAOB93txF8t2nATfj--
