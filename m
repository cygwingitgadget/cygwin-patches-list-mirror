Return-Path: <cygwin-patches-return-3393-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13906 invoked by alias); 15 Jan 2003 12:54:33 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 13758 invoked from network); 15 Jan 2003 12:54:32 -0000
Subject: Re: [PATCH] system-cancel part2
From: Robert Collins <rbcollins@cygwin.com>
To: Thomas Pfaff <tpfaff@gmx.net>
Cc: cygwin-patches@cygwin.com
In-Reply-To: <Pine.WNT.4.44.0301151113240.93-300000@algeria.intern.net>
References: <Pine.WNT.4.44.0301151113240.93-300000@algeria.intern.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-FfMqjQm2A+LLXAJmUj02"
Organization: 
Message-Id: <1042635258.16748.21.camel@lifelesslap>
Mime-Version: 1.0
Date: Wed, 15 Jan 2003 12:54:00 -0000
X-SW-Source: 2003-q1/txt/msg00042.txt.bz2


--=-FfMqjQm2A+LLXAJmUj02
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Content-length: 510

On Wed, 2003-01-15 at 22:23, Thomas Pfaff wrote:
> This patch will make sure that the signal handlers that are saved in the
> system call are restored even if the thread got cancelled. Since
> spawn_guts uses waitpid when mode is _P_WAIT spawn_guts is a cancellation
> point.
>=20
> Attached is the patch and a new test case.

The new test case doesn't appear to check that the signal handlers where
saved. Am I misreading that?

Rob
--=20
GPG key available at: <http://users.bigpond.net.au/robertc/keys.txt>.

--=-FfMqjQm2A+LLXAJmUj02
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part
Content-length: 189

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+JVn6I5+kQ8LJcoIRAtTaAKCiFnCzWv2rNiBJsBov+JabQsO+vgCbBluV
47DUI528tMdaQgoxTxVUpxU=
=SWbF
-----END PGP SIGNATURE-----

--=-FfMqjQm2A+LLXAJmUj02--
