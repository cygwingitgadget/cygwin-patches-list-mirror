Return-Path: <cygwin-patches-return-4382-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20200 invoked by alias); 14 Nov 2003 17:48:25 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 20191 invoked from network); 14 Nov 2003 17:48:24 -0000
Subject: Re: thunk createDirectory and createFile calls
From: Robert Collins <rbcollins@cygwin.com>
To: cygwin-patches@cygwin.com
In-Reply-To: <20031114155212.GC15938@redhat.com>
References: <3FB4A341.5070101@cygwin.com>
	 <20031114155212.GC15938@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-xbL3uRUns/5uYjt/SegI"
Message-Id: <1068832095.1109.96.camel@localhost>
Mime-Version: 1.0
Date: Fri, 14 Nov 2003 17:48:00 -0000
X-SW-Source: 2003-q4/txt/msg00101.txt.bz2


--=-xbL3uRUns/5uYjt/SegI
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Content-length: 634

On Sat, 2003-11-15 at 02:52, Christopher Faylor wrote:
> On Fri, Nov 14, 2003 at 08:41:21PM +1100, Robert Collins wrote:
> >        Rename CreateFile to cygwin_create_file throughout.
>                               ^^^^^^^^^^^^^^^^^^
> >        Rename CreateDirectory to cygwin_create_directory throughout.
>                                    ^^^^^^^^^^^^^^^^^^^^^^^
>=20
> It is a given that we're working in cygwin.  Adding a cygwin_ to the
> beginning of a function is just noise.

Heh, will fix... was following Ron's convention semi-blindly.

Rob
--=20
GPG key available at: <http://members.aardvark.net.au/lifeless/keys.txt>.

--=-xbL3uRUns/5uYjt/SegI
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part
Content-length: 189

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD4DBQA/tRVeI5+kQ8LJcoIRAgkmAJ0YkQCDxdaukCZreKC6SoXWc8BhmgCYg8GC
8njtf5VBw8G/sDhw64CBVw==
=Dkz9
-----END PGP SIGNATURE-----

--=-xbL3uRUns/5uYjt/SegI--
