Return-Path: <cygwin-patches-return-4395-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 489 invoked by alias); 15 Nov 2003 08:07:30 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 480 invoked from network); 15 Nov 2003 08:07:28 -0000
Subject: Re: For masochists: the leap o faith
From: Robert Collins <rbcollins@cygwin.com>
To: cygwin-patches@cygwin.com
In-Reply-To: <20031115044347.GA29583@redhat.com>
References: <3FB4D81C.6010808@cygwin.com> <3FB53BAE.3000803@cygwin.com>
	 <20031114220708.GA26100@redhat.com> <3FB55BCE.8030304@cygwin.com>
	 <20031115044347.GA29583@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-hqgC2NgKLqvbFY3OsjGm"
Message-Id: <1068883645.1109.122.camel@localhost>
Mime-Version: 1.0
Date: Sat, 15 Nov 2003 08:07:00 -0000
X-SW-Source: 2003-q4/txt/msg00114.txt.bz2


--=-hqgC2NgKLqvbFY3OsjGm
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Content-length: 1137

On Sat, 2003-11-15 at 15:43, Christopher Faylor wrote:

> Yes, I've already (obviously?) been to SUSv3.  I wasn't talking about
> standards.  I was talking about common practice.
>=20
> If you have a common practice web site that you want to show me then
> that might be a convincing argument.  Otherwise, I'll have to fall back
> on my personal UNIX experience.

http://zebra.fh-weingarten.de/~maxi/html/mplayer-dev-eng/2003-04/msg00600.h=
tml

Part of a thread on this in another project. Seems like the hurd follows
the no-PATH_MAX, use pathconf() always approach. Which means that
everything thats portable to the hurd, will Do The Right Thing, if we
eliminate the PATH_MAX and MAXPATHLEN defines. In my digging, I found
that PATH_MAX, if defined, MUST be the largest path length possible.
Presumably thats so that programs with static buffers won't run into
trouble.

Either way(increase PATH_MAX or remove it), to support longer paths,
we'll need to make the change and transition to it. So, as I see it the
question for you is : which route do you prefer?

Rob
--=20
GPG key available at: <http://www.robertcollins.net/keys.txt>.

--=-hqgC2NgKLqvbFY3OsjGm
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part
Content-length: 189

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/td69I5+kQ8LJcoIRArmEAJwOOrc9nwXRsZJcwobieJ9xKQ4aFwCfdBKO
lTqK0jT4s1P2fZnrYSXjSNI=
=2NXI
-----END PGP SIGNATURE-----

--=-hqgC2NgKLqvbFY3OsjGm--
