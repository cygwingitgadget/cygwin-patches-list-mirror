Return-Path: <cygwin-patches-return-3455-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9671 invoked by alias); 23 Jan 2003 12:29:05 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 9662 invoked from network); 23 Jan 2003 12:29:05 -0000
Subject: Re: [PATCH] a new pthread_cond implementation
From: Robert Collins <rbcollins@cygwin.com>
To: Thomas Pfaff <tpfaff@gmx.net>
Cc: cygwin-patches@cygwin.com
In-Reply-To: <Pine.WNT.4.44.0301221427270.531-400000@algeria.intern.net>
References: <Pine.WNT.4.44.0301221427270.531-400000@algeria.intern.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-U5I8W/rP6P5DlZyU+OYz"
Organization: 
Message-Id: <1043324936.27382.5.camel@lifelesslap>
Mime-Version: 1.0
Date: Thu, 23 Jan 2003 12:29:00 -0000
X-SW-Source: 2003-q1/txt/msg00104.txt.bz2


--=-U5I8W/rP6P5DlZyU+OYz
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Content-length: 659

On Thu, 2003-01-23 at 23:21, Thomas Pfaff wrote:


> 4. The spec requires that the mutex which is used with the condition
> shall be locked by the calling thread. The current code does not check
> this and will additionally create the mutex if it initialized with
> PTHREAD_MUTEX_INITIALIZER. The opengroup spec suggests EPERM under that
> condition.

The spec only requires this for pthread_cond_wait, not for all
pthread_cond_ calls. I hadn't noticed the EPERM suggestion.

I want to go through this patch in detail - it'll be a couple of days.

Please don't check it in yet.

Rob
--=20
GPG key available at: <http://users.bigpond.net.au/robertc/keys.txt>.

--=-U5I8W/rP6P5DlZyU+OYz
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part
Content-length: 189

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+L+AII5+kQ8LJcoIRAtX4AKCf6Azsv+bK5n9m4Wl8a/4jxoiQIQCgvDhF
3sCot0WSpELLC/LxUkYrJ+0=
=f+zV
-----END PGP SIGNATURE-----

--=-U5I8W/rP6P5DlZyU+OYz--
