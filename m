Return-Path: <cygwin-patches-return-3119-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 1998 invoked by alias); 5 Nov 2002 13:29:12 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 1988 invoked from network); 5 Nov 2002 13:29:11 -0000
Subject: Re: [PATCH] Patch for MTinterface
From: Robert Collins <rbcollins@cygwin.com>
To: Thomas Pfaff <tpfaff@gmx.net>
Cc: cygwin-patches@cygwin.com
In-Reply-To: <Pine.WNT.4.44.0211051319080.289-200000@algeria.intern.net>
References: <Pine.WNT.4.44.0211051319080.289-200000@algeria.intern.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-VGMOjaNW2hFkWYVOFPBH"
Date: Tue, 05 Nov 2002 05:29:00 -0000
Message-Id: <1036502950.17049.51.camel@lifelesswks>
Mime-Version: 1.0
X-SW-Source: 2002-q4/txt/msg00070.txt.bz2


--=-VGMOjaNW2hFkWYVOFPBH
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Content-length: 1775

On Wed, 2002-11-06 at 00:14, Thomas Pfaff wrote:
>=20
> I have discovered some problems with the current MTinterface
> implementation. Here are 2 test cases:

> Even if the handles would be valid the pthread_join call would try to
> delete a thread object that is created static which would result in a
> corrupted heap.

Ouch. Good catch.

> 2: fork related

> The forked child will not get the same thread handle as its parent, it
> will get the thread handle from the main thread instead. The child will
> not terminate because the threadcount is still 2 after the fork (it is
> set to 1 in MTinterface::Init and then set back to 2 after the childs
> memory gets overwritten by the parent).

For memory that should not be copied, mark it with NO_COPY in the
declaration. MTinterface is set thusly IIRC.

> And i do not agree with the the current pthread_self code where the
> threadcount is incremented if a new thread handle has been created but
> never gets decremented (i do not expect that threads that are not created
> by pthread_created will terminate via pthread_exit). And the newly created
> object never gets freed.

The dllinit routine will take care of this when we get that implemented
again. I don't=20

> To avoid these errors i have made changes that will create the mainthread
> object dynamic and store the reents and thread self pointer via fork safe
> keys.

Overall this looks good. What happens to non-cygwinapi created threads
now though? You mention you don't agree with the code, but I can't see
(from a brief look) how you correct it.

BTW: I'm currently packing to move house, so don't expect much feedback
until late next week, or early the week after :[.

Rob
--=20
---
GPG key available at: http://users.bigpond.net.au/robertc/keys.txt.
---

--=-VGMOjaNW2hFkWYVOFPBH
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part
Content-length: 189

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9x8eiI5+kQ8LJcoIRAjZUAKCyN1GjLFjZ9YrY1ZfZqNpAsEDBtgCfaouC
w/mK4AQMzQ8AQDWCBk+u+Z8=
=ZND9
-----END PGP SIGNATURE-----

--=-VGMOjaNW2hFkWYVOFPBH--
