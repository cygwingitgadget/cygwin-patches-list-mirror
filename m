Return-Path: <cygwin-patches-return-4427-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3652 invoked by alias); 20 Nov 2003 20:52:24 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 3613 invoked from network); 20 Nov 2003 20:52:22 -0000
Subject: Re: thunking, the next step
From: Robert Collins <rbcollins@cygwin.com>
To: Corinna Vinschen <cygwin-patches@cygwin.com>
In-Reply-To: <20031117120229.GH18706@cygbert.vinschen.de>
References: <3FB4C443.2040301@cygwin.com>
	 <20031114155716.GA16485@redhat.com> <1068832363.1109.101.camel@localhost>
	 <20031114191010.GA22870@redhat.com>
	 <20031117112126.GE18706@cygbert.vinschen.de>
	 <1069068688.2287.219.camel@localhost>
	 <20031117120229.GH18706@cygbert.vinschen.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-/hsoCEIkrlMGs2r/8xLq"
Message-Id: <1069361541.1117.42.camel@localhost>
Mime-Version: 1.0
Date: Thu, 20 Nov 2003 20:52:00 -0000
X-SW-Source: 2003-q4/txt/msg00146.txt.bz2


--=-/hsoCEIkrlMGs2r/8xLq
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Content-length: 1722

On Mon, 2003-11-17 at 23:02, Corinna Vinschen wrote:

> >  And, structures like
> > the FindNext* details change in definition when UNICODE is defined. I
> > was trying to avoid all that complexity, which is significant, by
> > staying in a thunk approach.
>=20
> Yep, I agree, that's an extra problem.  But it doesn't invalidate the
> general idea of putting the work into autoload and path_conv.  The
> FindFile example might be something which justifies the use of wrapper
> functions for these very cases.

Ok. Well for now, I'm going to leave the thunks in place, until / if
they become nothing more than if (unicode) ...W() else A(). That said,
all the calls we are thunking require kernel mode transitions, so I
really don't believe that the thunking will add any overhead on it's
own: the context switch going into kernel will obliterate the much
smaller overhead of checking which call we want to make.

> > I decided against redefining the 'real' calls because I figured some
> > areas may want to use the 'real' calls directly, and only the
> > auto-adjusting parts of cygwin should have the ansi/wide dichotomy.
>=20
> I don't know if I understand you right.  I was only talking about
> calls which are affecting the file system.  Other calls like
> CreateSemaphore or what not should still work as before.  The autoload
> part would define some new LoadDLLfuncBLURB which is used only for
> the affected functions.  I (and I assume cgf) was not talking about
> using that approach for all functions with an ascii and a wide char
> implementation.

Never mind, thinko on my part: the A and W versions would still be
directly accesible.

Rob
--=20
GPG key available at: <http://www.robertcollins.net/keys.txt>.

--=-/hsoCEIkrlMGs2r/8xLq
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part
Content-length: 189

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/vSmEI5+kQ8LJcoIRAjRTAKDQWfgfP0YIm5uvHLjxXqR7zCwM2wCeOVUh
cfecdJzXXE6bN7JP0VmqX0c=
=7xD/
-----END PGP SIGNATURE-----

--=-/hsoCEIkrlMGs2r/8xLq--
