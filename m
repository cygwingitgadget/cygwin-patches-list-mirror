Return-Path: <cygwin-patches-return-3516-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17446 invoked by alias); 6 Feb 2003 00:57:12 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 17437 invoked from network); 6 Feb 2003 00:57:11 -0000
Subject: Re: Implementation of sched_rr_get_interval for NT systems.
From: Robert Collins <rbcollins@cygwin.com>
To: Vaclav Haisman <V.Haisman@sh.cvut.cz>
Cc: cygwin-patches@cygwin.com
In-Reply-To: <20030206012720.V68017-100000@logout.sh.cvut.cz>
References: <20030206012720.V68017-100000@logout.sh.cvut.cz>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-YKS15mEddWZ96IsbPXyF"
Organization: 
Message-Id: <1044493023.4328.122.camel@localhost>
Mime-Version: 1.0
Date: Thu, 06 Feb 2003 00:57:00 -0000
X-SW-Source: 2003-q1/txt/msg00165.txt.bz2


--=-YKS15mEddWZ96IsbPXyF
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Content-length: 1199

On Thu, 2003-02-06 at 11:50, Vaclav Haisman wrote:
> Hi,
> this patch implements sched_rr_get_interval for NT systems. The patch con=
sists
> of two parts.
>=20
> The first part is detection of NT server systems, NT servers have differe=
nt
> time quanta than workstations. Unfortunately the server detection is not
> perfect because GetVersionEx call with OSVERSIONINFOEX structure is suppo=
rted
> only on NT 4 SP6 and newer system. Therefore new is_system wincaps flag
> defaults to false as I assume that there are more NT workstations than se=
rvers.
>=20
> The second part is implementation of sched_rr_get_interval in sched.cc it=
self.
> I have used two main sources of informations about time quanta for NT sys=
tems.
> Those sources are two web pages:
> http://www.microsoft.com/mspress/books/sampchap/4354c.asp
> http://www.jsifaq.com/SUBH/tip3700/rh3795.htm
>=20


You should get for failure on all API calls you make - for instance the
registry key reading one. Other than that, the sched.cc stuff looks good
to me.=20

This will need a copyright assignment though, and Chris/Corinna to chime
in.

Cheers,
Rob
--=20
GPG key available at: <http://users.bigpond.net.au/robertc/keys.txt>.

--=-YKS15mEddWZ96IsbPXyF
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part
Content-length: 189

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+QbLfI5+kQ8LJcoIRAi53AJ4nPKgcnJ9lM9KZLDdLJ3kY5zICcwCgrZVJ
WEVSpRLx+8jNjeM/AnrNJ6k=
=6qU2
-----END PGP SIGNATURE-----

--=-YKS15mEddWZ96IsbPXyF--
