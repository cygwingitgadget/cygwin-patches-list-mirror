Return-Path: <cygwin-patches-return-3635-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22030 invoked by alias); 27 Feb 2003 12:29:56 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 22021 invoked from network); 27 Feb 2003 12:29:56 -0000
Subject: Re: [PATCH] add support for PTHREAD_MUTEX_NORMAL
From: Robert Collins <rbcollins@cygwin.com>
To: Thomas Pfaff <tpfaff@gmx.net>
Cc: cygwin-patches@cygwin.com
In-Reply-To: <Pine.WNT.4.44.0302271028080.285-201000@algeria.intern.net>
References: <Pine.WNT.4.44.0302271028080.285-201000@algeria.intern.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-dJVffB5KdXMRDzofEwh0"
Organization: 
Message-Id: <1046348989.2137.22.camel@localhost>
Mime-Version: 1.0
Date: Thu, 27 Feb 2003 12:29:00 -0000
X-SW-Source: 2003-q1/txt/msg00284.txt.bz2


--=-dJVffB5KdXMRDzofEwh0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Content-length: 385

On Thu, 2003-02-27 at 23:26, Thomas Pfaff wrote:
> This patch adds support for PTHREAD_MUTEX_NORMAL (fast and
> deadlocking) mutexes and slightly modifies the lock counter logic.
> The counter now start at 0.


I'll review these this weekend - if you haven't heard anything on
Monday, please prod me :}.

Rob
--=20
GPG key available at: <http://users.bigpond.net.au/robertc/keys.txt>.

--=-dJVffB5KdXMRDzofEwh0
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part
Content-length: 189

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+XgS9I5+kQ8LJcoIRAhxIAKDFjXTOlg4qsiPu8aQvh40PDQ7ZWgCg0KCe
IVM8e/4qLGzstfMVPGQmwe4=
=8Oje
-----END PGP SIGNATURE-----

--=-dJVffB5KdXMRDzofEwh0--
