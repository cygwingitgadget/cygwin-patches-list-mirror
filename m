Return-Path: <cygwin-patches-return-2990-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 11908 invoked by alias); 17 Sep 2002 09:53:53 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 11894 invoked from network); 17 Sep 2002 09:53:52 -0000
Subject: Re: [PATCH] pthread_fork Part 2
From: Robert Collins <rbcollins@cygwin.com>
To: Thomas Pfaff <tpfaff@gmx.net>
Cc: cygwin-patches@cygwin.com
In-Reply-To: <Pine.WNT.4.44.0209171135350.297-100000@algeria.intern.net>
References: <Pine.WNT.4.44.0209171135350.297-100000@algeria.intern.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-VSGfjqaWY6N0tuGP+Ynt"
Date: Tue, 17 Sep 2002 02:53:00 -0000
Message-Id: <1032256464.17674.187.camel@lifelesswks>
Mime-Version: 1.0
X-SW-Source: 2002-q3/txt/msg00438.txt.bz2


--=-VSGfjqaWY6N0tuGP+Ynt
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Content-length: 621

On Tue, 2002-09-17 at 19:47, Thomas Pfaff wrote:

> Agreed, I missed the point where magic is set to 0 if TlsAlloc has failed.
> But i would really appreciate if you would apply the patch for
> pthread_key::get that removes the set_errno(0) and preserves the WIN32
> LastError.
> If you configure gcc to use the the pthreads interface for exceptions then
> it makes heavy use of pthread_getspecific to read the actual eh context.
> Some people might be very surprised when errno and Win32 LastError is
> cleared behind her back (It took me 2 days to find the reason for this
> about 2 years ago on mingw).

ok.

Rob
=20


--=-VSGfjqaWY6N0tuGP+Ynt
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part
Content-length: 189

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9hvvOI5+kQ8LJcoIRAqCnAJ9OWDeFHBPjgISYToMPwPxDPocbZwCgxtpv
TUOgzekV2IwdBLcOZBfgIS8=
=gh1Y
-----END PGP SIGNATURE-----

--=-VSGfjqaWY6N0tuGP+Ynt--
