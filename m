Return-Path: <cygwin-patches-return-3722-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20682 invoked by alias); 19 Mar 2003 22:22:49 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 20607 invoked from network); 19 Mar 2003 22:22:48 -0000
Subject: Re: [PATCH] updated pthread list patch
From: Robert Collins <rbcollins@cygwin.com>
To: Thomas Pfaff <tpfaff@gmx.net>
Cc: cygwin-patches@cygwin.com
In-Reply-To: <Pine.WNT.4.44.0303191454490.257-200000@algeria.intern.net>
References: <Pine.WNT.4.44.0303191454490.257-200000@algeria.intern.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-OkTdaq5lnGWHMkt2UNi9"
Organization: 
Message-Id: <1048112562.5299.175.camel@localhost>
Mime-Version: 1.0
Date: Wed, 19 Mar 2003 22:22:00 -0000
X-SW-Source: 2003-q1/txt/msg00371.txt.bz2


--=-OkTdaq5lnGWHMkt2UNi9
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Content-length: 782

I'm happy with changing the method naming format, but is it GNU
standard? Thats a requirement for the cygwin project.

http://www.gnu.org/prep/standards_26.html#SEC26 says that=20
"For example, you should use names like ignore_space_change_flag; don't
use names like iCantReadThis."

Now, I happen to disagree with the GNU conventions here, particularly as
they don't have a C++ section (and C doesn't have the same degree of
name space conflicts that C++ does) :}. But, the pthread code should
stay within the GNU guidelines.

So, I'm sorry to have you jumping through hoops, but can you please
change your patch so that all new methods use the GNU convention here.

Other than that, please apply it.
Rob
--=20
GPG key available at: <http://users.bigpond.net.au/robertc/keys.txt>.

--=-OkTdaq5lnGWHMkt2UNi9
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part
Content-length: 189

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+eO2yI5+kQ8LJcoIRAhVjAJ9tKZVAyqQpZFgoBcH9kArm9lV7iwCfVDW4
rlXGgQWGbId09/lY+Ty2waU=
=uiuU
-----END PGP SIGNATURE-----

--=-OkTdaq5lnGWHMkt2UNi9--
