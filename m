Return-Path: <cygwin-patches-return-8316-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 120382 invoked by alias); 13 Feb 2016 16:05:13 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 120365 invoked by uid 89); 13 Feb 2016 16:05:12 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-96.6 required=5.0 tests=BAYES_00,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC,USER_IN_WHITELIST autolearn=no version=3.3.2 spammy=H*F:U*corinna-cygwin, H*R:U*cygwin-patches, HTo:U*cygwin-patches, H*Ad:U*cygwin-patches
X-HELO: calimero.vinschen.de
Received: from ipbcc0d020.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.208.32) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sat, 13 Feb 2016 16:05:11 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id D0630A804DE; Sat, 13 Feb 2016 17:05:09 +0100 (CET)
Date: Sat, 13 Feb 2016 16:05:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] POSIX barrier implementation, take 3
Message-ID: <20160213160509.GB28726@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <56BDB206.9090101@gmail.com> <20160212142537.GD3415@calimero.vinschen.de> <56BE4DE7.7050605@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="bCsyhTFzCvuiizWE"
Content-Disposition: inline
In-Reply-To: <56BE4DE7.7050605@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SW-Source: 2016-q1/txt/msg00022.txt.bz2


--bCsyhTFzCvuiizWE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1650

On Feb 12 22:25, V=C3=A1clav Haisman wrote:
> On 12.2.2016 15:25, Corinna Vinschen wrote:
> > Hi V=C3=A1clav,
> >=20
> >=20
> > the patch looks pretty good, I have just a few (minor) nits:
> > [...]
> The attached patch should address all of the review comments.
>=20
> Modifed change log:
>=20
> Newlib:
>=20
> 	* libc/include/sys/features.h (_POSIX_BARRIERS): Define for Cygwin.
> 	* libc/include/sys/types.h (pthread_barrier_t)
> 	(pthread_barrierattr_t): Do not define for Cygwin.
>=20
> Cygwin:
>=20
> 	* common.din (pthread_barrierattr_init)
> 	(pthread_barrierattr_setpshared, pthread_barrierattr_getpshared)
> 	(pthread_barrierattr_destroy, pthread_barrier_init)
> 	(pthread_barrier_destroy, pthread_barrier_wait): Export.
> 	* include/cygwin/types.h (pthread_barrierattr_t)
> 	(pthread_barrier_t): Declare.
> 	* include/pthread.h (PTHREAD_BARRIER_SERIAL_THREAD)
> 	(pthread_barrierattr_init, pthread_barrierattr_setpshared)
> 	(pthread_barrierattr_getpshared, pthread_barrierattr_destroy)
> 	(pthread_barrier_init, pthread_barrier_destroy)
> 	(pthread_barrier_wait): Declare.
> 	* thread.h (PTHREAD_BARRIER_MAGIC)
> 	(PTHREAD_BARRIERATTR_MAGIC): Define.
> 	(class pthread_barrierattr, class pthread_barrier): Declare.
> 	* thread.cc (delete_and_clear): New local helper function.
> 	(class pthread_barrierattr, class pthread_barrier): Implement.
> 	* miscfuncs.h (likely, unlikely): New macros.

Patch applied.  I added documentation changes to reflect this welcome
addition.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--bCsyhTFzCvuiizWE
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWv1Q1AAoJEPU2Bp2uRE+gRxwP+QFJUhhBjvJSEN+mciuJwHhJ
1GcjCw4W5oHh/cF7UgAZKsp83lPaW3JmwhKSjawUbQzAXU69p/qkcd1UkvLTJjaa
R+Y4HodVGeuQ72WKh0gUrlECdjyeI4M9fTp0tyof5A4sFwSiOVFL50alTs/s6WdY
k+ZzOFxcpC7dvMwQJoV0qxIvURG+O9YYwt3rZ3tIWuKUURrimTsxQF6wsDJQ2oG8
xQ7XV0Vt3YfJt6mxE49l63pZ6UYd5KxwDJyk0tf5JNoDeOCWNf2fZv3LclSF87Nt
8q5oK2KXCyiC82NVM5KqxGC4i3nVZ4n1EbjBibrvGKV+joZJhfJGok8H8dO5EOu+
lVdvJItfJaMMI+RNskyYKADH9S/ZsB8f/ZEkv+NSRf2NcfZPxcUYMYhOdFKDXRNc
B7R57USam6GPGC2h/LOWALJHwb5lir3FeLC0wShvgDWdJ/vZ8h6ODc1PHAA8vkaM
J8bEGzebgDrtGlRawuOoMcI5AsCP5pCGwYqgE1ymmwJc/kZ1SO7HNkDqmNEHk1IH
quBPRQnREEU+6xbubsPUxagZL0fRYpm7QFafgsp7sYMmmAGse0F9aGsjNyduo/wG
7Q/7LOaWLehWGOCm0Nd1VHhi0c3c7iSibmVguYzU2cc62F076KT64vIhfJZpVieq
6oxJrv2Rld0XJZNDBPVv
=878r
-----END PGP SIGNATURE-----

--bCsyhTFzCvuiizWE--
