Return-Path: <cygwin-patches-return-3404-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25899 invoked by alias); 15 Jan 2003 20:13:29 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 25890 invoked from network); 15 Jan 2003 20:13:28 -0000
Subject: Re: [PATCH] system-cancel part2
From: Robert Collins <rbcollins@cygwin.com>
To: Thomas Pfaff <tpfaff@gmx.net>
Cc: cygwin-patches@cygwin.com
In-Reply-To: <Pine.WNT.4.44.0301151357510.249-300000@algeria.intern.net>
References: <Pine.WNT.4.44.0301151357510.249-300000@algeria.intern.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-9jX4nJA4zeKx3ujlavOo"
Organization: 
Message-Id: <1042661605.13218.37.camel@lifelesslap>
Mime-Version: 1.0
Date: Wed, 15 Jan 2003 20:13:00 -0000
X-SW-Source: 2003-q1/txt/msg00053.txt.bz2


--=-9jX4nJA4zeKx3ujlavOo
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Content-length: 474

On Thu, 2003-01-16 at 00:19, Thomas Pfaff wrote:
> On Wed, 15 Jan 2003, Robert Collins wrote:

> The test case was created to prove that system is a cancellation point
> even if the child process is already created and the system call is
> waiting on child termination.

Thank you for the new test cases. When Chris approves the system()
changes, I'm happy with the pthreads aspects of this.

Rob

--=20
GPG key available at: <http://users.bigpond.net.au/robertc/keys.txt>.

--=-9jX4nJA4zeKx3ujlavOo
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part
Content-length: 189

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+JcDlI5+kQ8LJcoIRAlA9AKCU4nXC3ZhBeIa7NLexAKMbKbCMegCeL1IA
3+8MILq4mWbFhH93NPvxIKM=
=uwpA
-----END PGP SIGNATURE-----

--=-9jX4nJA4zeKx3ujlavOo--
