Return-Path: <cygwin-patches-return-2982-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 17834 invoked by alias); 16 Sep 2002 22:19:11 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 17820 invoked from network); 16 Sep 2002 22:19:10 -0000
Subject: Re: [PATCH] check for valid pthread_self pointer
From: Robert Collins <rbcollins@cygwin.com>
To: Jason Tishler <jason@tishler.net>
Cc: cygwin-patches@cygwin.com
In-Reply-To: <20020916165427.GI424@tishler.net>
References: <Pine.WNT.4.44.0208071245020.353-200000@algeria.intern.net>
	<20020816112218.GA892@tishler.net> <1032176803.17676.135.camel@lifelesswks>
	 <20020916165427.GI424@tishler.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-ThxxrCz5sD6CtKbRccaM"
Date: Mon, 16 Sep 2002 15:19:00 -0000
Message-Id: <1032214783.17693.165.camel@lifelesswks>
Mime-Version: 1.0
X-SW-Source: 2002-q3/txt/msg00430.txt.bz2


--=-ThxxrCz5sD6CtKbRccaM
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Content-length: 846

On Tue, 2002-09-17 at 02:54, Jason Tishler wrote:
> Rob,
>=20
> On Mon, Sep 16, 2002 at 09:46:38PM +1000, Robert Collins wrote:
> > On Fri, 2002-08-16 at 21:22, Jason Tishler wrote:
> > > Rob,
> > >=20
> > > On Wed, Aug 07, 2002 at 05:19:10PM +0200, Thomas Pfaff wrote:
> > > > This patch should fix the problem with the ipc-daemon started as
> > > > service and threads that are not created by pthread_create.
> > >=20
> > > Please evaluate and commit if OK -- the PostgreSQL folks could really
> > > use this.
> >=20
> > BTW: they really should use pthread_create if they want to use threaded
> > code with cygwin. But you knew that right?
>=20
> Huh?  This is really a cygipc issue -- not a PostgreSQL issue.
> Unfortunately, PostgreSQL is dependent on cygipc until cygserver
> supports IPC.

Oh. Blush. So cygipc should use pthreads :}.

Rob

--=-ThxxrCz5sD6CtKbRccaM
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part
Content-length: 189

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9hlj+I5+kQ8LJcoIRAgl9AKCUjYygXjsxRQvHwpS5xCWu+Me9aACePvkV
N2dvxXm644HflTH9URs3QpQ=
=xmx+
-----END PGP SIGNATURE-----

--=-ThxxrCz5sD6CtKbRccaM--
