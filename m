Return-Path: <cygwin-patches-return-3369-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20986 invoked by alias); 10 Jan 2003 09:00:27 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 20866 invoked from network); 10 Jan 2003 09:00:21 -0000
Subject: Re: [PATCH] make handle_sigsuspend a cancellation point
From: Robert Collins <rbcollins@cygwin.com>
To: Thomas Pfaff <tpfaff@gmx.net>
Cc: cygwin-patches@cygwin.com
In-Reply-To: <Pine.WNT.4.44.0301100953500.299-200000@algeria.intern.net>
References: <Pine.WNT.4.44.0301100953500.299-200000@algeria.intern.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-d2N+JvtDT8st+yTQyxiD"
Organization: 
Message-Id: <1042189207.17813.4.camel@lifelesslap>
Mime-Version: 1.0
Date: Fri, 10 Jan 2003 09:00:00 -0000
X-SW-Source: 2003-q1/txt/msg00018.txt.bz2


--=-d2N+JvtDT8st+yTQyxiD
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Content-length: 313

On Fri, 2003-01-10 at 19:57, Thomas Pfaff wrote:
> This patch will make handle_sigsuspend (used by pause, sigpause
> and sigsuspend) a pthread cancellation point.

Also looks good. Again, please do a scriptable testcase for these.

Rob

--=20
GPG key available at: <http://users.bigpond.net.au/robertc/keys.txt>.

--=-d2N+JvtDT8st+yTQyxiD
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part
Content-length: 189

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+HouXI5+kQ8LJcoIRAp0wAJ9CQKGzbfj+K8aB8JA6GbShohaCAQCeNe6b
2QOLPJhyofUZnOGSOagcXuI=
=w+Yi
-----END PGP SIGNATURE-----

--=-d2N+JvtDT8st+yTQyxiD--
