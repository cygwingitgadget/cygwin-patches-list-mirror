Return-Path: <cygwin-patches-return-4060-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27872 invoked by alias); 9 Aug 2003 21:55:32 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 27863 invoked from network); 9 Aug 2003 21:55:31 -0000
Subject: Re: [PATCH] Checking integrity of installed packages in cygcheck
From: Robert Collins <rbcollins@cygwin.com>
To: cygwin-patches@cygwin.com
In-Reply-To: <20030809162939.GA9863@redhat.com>
References: <Pine.GSO.4.44.0308071843550.5132-200000@slinky.cs.nyu.edu>
	 <20030809161211.GB9514@redhat.com>  <20030809162939.GA9863@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-pQ8bQJI6c+qoZSicOnTu"
Message-Id: <1060466141.10220.39.camel@localhost>
Mime-Version: 1.0
Date: Sat, 09 Aug 2003 21:55:00 -0000
X-SW-Source: 2003-q3/txt/msg00076.txt.bz2


--=-pQ8bQJI6c+qoZSicOnTu
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Content-length: 527

On Sun, 2003-08-10 at 02:29, Christopher Faylor wrote:

> I wonder why setup is using gzip rather than bzip2 for the package files.=
..

It's historical. I'm not *planning* on altering that before the
hypothetical dpkg/rpm backend integration.

I'd suggest though, that further cygcheck setup smarts should come by
librarising setup's code, rather than reproducing it - the setup dir
format is likely to change if we find we need to.

Cheers,
Rob
--=20
GPG key available at: <http://members.aardvark.net.au/lifeless/keys.txt>.

--=-pQ8bQJI6c+qoZSicOnTu
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part
Content-length: 189

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/NW3dI5+kQ8LJcoIRAnQMAKCn3gLLCiIbXWKpXMSP92yF6aV64QCfe2gK
36/UxoOME8E587htIq8utzA=
=qfSY
-----END PGP SIGNATURE-----

--=-pQ8bQJI6c+qoZSicOnTu--
