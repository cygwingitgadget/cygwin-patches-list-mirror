Return-Path: <cygwin-patches-return-4394-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3764 invoked by alias); 15 Nov 2003 04:48:56 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 3755 invoked from network); 15 Nov 2003 04:48:54 -0000
Subject: Re: For masochists: the leap o faith
From: Robert Collins <rbcollins@cygwin.com>
To: cygwin-patches@cygwin.com
In-Reply-To: <20031115044347.GA29583@redhat.com>
References: <3FB4D81C.6010808@cygwin.com> <3FB53BAE.3000803@cygwin.com>
	 <20031114220708.GA26100@redhat.com> <3FB55BCE.8030304@cygwin.com>
	 <20031115044347.GA29583@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-lVhkZTp2diYlwAwX3INL"
Message-Id: <1068871732.1109.105.camel@localhost>
Mime-Version: 1.0
Date: Sat, 15 Nov 2003 04:48:00 -0000
X-SW-Source: 2003-q4/txt/msg00113.txt.bz2


--=-lVhkZTp2diYlwAwX3INL
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Content-length: 1466

On Sat, 2003-11-15 at 15:43, Christopher Faylor wrote:
> On Sat, Nov 15, 2003 at 09:48:46AM +1100, Robert Collins wrote:
> >Christopher Faylor wrote:
> >>It is fairly unusual for PATH_MAX to be many times greater than what is
> >>support by pathconf.
> >
> >And yet:
> >http://www.opengroup.org/onlinepubs/007908799/xsh/fpathconf.html
>=20
> Yes, I've already (obviously?) been to SUSv3.  I wasn't talking about
> standards.  I was talking about common practice.
>=20
> If you have a common practice web site that you want to show me then
> that might be a convincing argument.  Otherwise, I'll have to fall back
> on my personal UNIX experience.
>=20
> I'm not vetoing the change because PATH_MAX is potentially large.  I was
> kind of hoping (because I'm in incurable optimist) to start a discussion
> with people who were familiar with packages that used PATH_MAX.  How
> SUSv3 defines PATH_MAX is irrelevant to existing programs.

Well, it'll keep. I'll publish up my latest revision of the patch
tonight, and leave it for Ron or other interested parties to carry
through. There is obviously another couple of days work to get all the
edges off, and then there's the gcc objects-on-stack issue to resolve.
Still it'd be great to get this in, in some fashion.

I would like to get the thunking changes in, simply to make the only
part of the patch outstanding the controversial stuff.=20

Rob

--=20
GPG key available at: <http://www.robertcollins.net/keys.txt>.

--=-lVhkZTp2diYlwAwX3INL
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part
Content-length: 189

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/tbAyI5+kQ8LJcoIRAunNAJoDjvlrabyT3R1AatWIDkVFf2OJVgCdGx6h
XDQIEY3E5Tu/eZY7YS5vf/E=
=85Ws
-----END PGP SIGNATURE-----

--=-lVhkZTp2diYlwAwX3INL--
