Return-Path: <cygwin-patches-return-3717-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7129 invoked by alias); 19 Mar 2003 12:36:41 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 6951 invoked from network); 19 Mar 2003 12:36:39 -0000
Subject: Re: [PATCH] reorganize list handling of fixable pthread objects
From: Robert Collins <rbcollins@cygwin.com>
To: Thomas Pfaff <tpfaff@gmx.net>
Cc: cygwin-patches@cygwin.com
In-Reply-To: <Pine.WNT.4.44.0303191149350.264-100000@algeria.intern.net>
References: <Pine.WNT.4.44.0303191149350.264-100000@algeria.intern.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-R6SQIP2LiXYHjTY0BbGz"
Organization: 
Message-Id: <1048077394.5689.159.camel@localhost>
Mime-Version: 1.0
Date: Wed, 19 Mar 2003 12:36:00 -0000
X-SW-Source: 2003-q1/txt/msg00366.txt.bz2


--=-R6SQIP2LiXYHjTY0BbGz
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Content-length: 1280

On Wed, 2003-03-19 at 21:56, Thomas Pfaff wrote:
> I think that the code could be simplified by making callback a pointer to
> member function.
>=20
> void forEach (void (ListNode::*callback) ())
> {
>   ListNode *aNode =3D head;
>   while (aNode)
>     {
>       (aNode->*callback) ();
>       aNode =3D aNode->next;
>     }
> }
>=20
> With this change you do not need a static to member wrapper function like
> pthread_key::saveAKey.
>=20
> You could write
>=20
> void pthread_key::fixup_before_fork()
> {
>   keys.forEach (&pthread_key::saveKeyToBuffer);
> }
>=20
> void pthread_key::fixup_after_fork()
> {
>   keys.forEach (&pthread_key::recreateKeyFromBuffer);
> }
>=20
> void pthread_key::runAllDestructors ()
> {
>   keys.forEach (&pthread_key::runDestructor);
> }
>=20
> instead.

For some reason, I forgot that I put in the 'poor mans generic
programming' initially. It just stood out in the patch.

Using a member pointer like that still requires each function to have
the same signature. The for_each I sketched below allows arbitrary
callbacks like using a member function does, but computes them at
compile time which allows for more efficient binary output.

Please apply your patch.

Rob

--=20
GPG key available at: <http://users.bigpond.net.au/robertc/keys.txt>.

--=-R6SQIP2LiXYHjTY0BbGz
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part
Content-length: 189

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+eGRSI5+kQ8LJcoIRAkcSAKChO/vjWVsW+V6QllPCG7lq3wCfagCfd/QA
skHQh0Z8bUd+9lhELZs3Txo=
=bKZ0
-----END PGP SIGNATURE-----

--=-R6SQIP2LiXYHjTY0BbGz--
