Return-Path: <cygwin-patches-return-3019-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 13225 invoked by alias); 22 Sep 2002 02:02:32 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 13209 invoked from network); 22 Sep 2002 02:02:31 -0000
Subject: Re: [PATCH] new mutex implementation 2. posting
From: Robert Collins <rbcollins@cygwin.com>
To: cygwin-patches@cygwin.com
In-Reply-To: <20020920154735.GF24740@redhat.com>
References: <Pine.WNT.4.44.0209201428100.279-100000@algeria.intern.net>
	<1032525980.9116.55.camel@lifelesswks>  <20020920154735.GF24740@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-dzUxDvE9N/e8uelknnmv"
Date: Sat, 21 Sep 2002 19:02:00 -0000
Message-Id: <1032660183.10933.150.camel@lifelesswks>
Mime-Version: 1.0
X-SW-Source: 2002-q3/txt/msg00467.txt.bz2


--=-dzUxDvE9N/e8uelknnmv
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Content-length: 1107

On Sat, 2002-09-21 at 01:47, Christopher Faylor wrote:
> I haven't been following very closely.  Is the reason why we are not using
> critical sections that TryEnterCriticalSection isn't available anywhere?
> If so, then we can probably fix that with some assembly programming.

Thats a factor, yes.
=20
> Critical sections are *so* much faster than mutexes or semaphores that
> it makes sense to use them if possible.
>=20
> Or, maybe we're talking about something else entirely...

Well there are two things. Thomas's work gives use recursive and error
checking mutexes, which aren't currently supported. He also points out
that semaphores leverage critical sections on NT, so should be ~ in
speed.

From my POV, we haven't benchmarked his work enough to really tell, BUT
- critical sections don't scale well anyway, certainly not to MP
environments (there is doco on this somewhere).

We could look at having both classes implemented and doing some testing.
Hmm.

In fact, given that we object based, we probably should subclass
pthread_mutex anyway for clarity with the different forms of mutexs.

Rob

--=-dzUxDvE9N/e8uelknnmv
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part
Content-length: 189

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9jSTXI5+kQ8LJcoIRAugNAJoDQ3E4LzmtJ2F5vu4/Hq8T29N0tgCfUcad
jrJg4auxbD4ivq6LWEJkuDs=
=bTof
-----END PGP SIGNATURE-----

--=-dzUxDvE9N/e8uelknnmv--
