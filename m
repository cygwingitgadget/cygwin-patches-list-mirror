Return-Path: <cygwin-patches-return-8006-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13755 invoked by alias); 14 Jul 2014 09:45:42 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 13690 invoked by uid 89); 14 Jul 2014 09:45:38 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-5.9 required=5.0 tests=AWL,BAYES_00 autolearn=ham version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 14 Jul 2014 09:45:36 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id D05E88E0600; Mon, 14 Jul 2014 11:45:33 +0200 (CEST)
Date: Mon, 14 Jul 2014 09:45:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] default to normal pthread mutexes
Message-ID: <20140714094533.GA29162@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <53C31871.9020900@cygwin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;	protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
Content-Disposition: inline
In-Reply-To: <53C31871.9020900@cygwin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2014-q3/txt/msg00001.txt.bz2


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1183

Hi Yaakov,

On Jul 13 18:38, Yaakov Selkowitz wrote:
> Defaulting to ERRORCHECK mutexes (with the various stringencies it implie=
s)
> does not match the behaviour on Linux, where NORMAL mutexes are the defau=
lt.
> I have been testing this locally for some time, and I believe it affects a
> lot of software.  Patch and STC attached.
>=20
>=20
> Yaakov

> 2014-07-13  Yaakov Selkowitz  <yselkowitz@...>
>=20
> 	* thread.cc (pthread_mutex::pthread_mutex): Change default type
> 	to PTHREAD_MUTEX_NORMAL.
> 	(pthread_mutexattr::pthread_mutexattr): Ditto.
> 	(pthread_mutex_unlock): Do not fail if mutex is a normal mutex
> 	initializer.
> 	* include/pthread.h (PTHREAD_MUTEX_INITIALIZER): Redefine as
> 	PTHREAD_NORMAL_MUTEX_INITIALIZER_NP.

I checked this in with a small addition.  While testing I found that
Cygwin's pthread_mutex_unlock returned EINVAL if the mutex is of the
PTHREAD_MUTEX_ERRORCHECK type and the mutex wasn't owned by any thread
(as in your STC),  Linux returns EPERM in this case.  I fixed that.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTw6a9AAoJEPU2Bp2uRE+glAYP/2trK4y910eWd8kXcbCwmSxt
MSV1zbNQ/uZcpShxl+IHiDBYYkqOQAjDL2TGXm2kg7szxZz1uHsGyEdIaD2Mj903
tIgaDIRdmZfawkSl74kWMroVb8mDLioOTHYjGxlkzLCWSJ3/FpiFs5YOMW+9F7BE
ybL5LU7B4D+vHMac5HuijI/t536+gWPsm3XYUcSc2oQmMvA16dty7MKoUfQJ65q7
+dewHWfEQO5KAJedUTzplRwBoB8SsmGXFfCOMzkUDCV3zJjAH86DEbgkFD0Nv7Y0
QvUrn5V6whpha56BcdYVAK0A12Ksq6fc2LR1+K8mvX1Zqmv6tGwlj1B5rO0Uz2ye
T8R+zj+hQfH6qw0zCCAq3apACEsaEbMfZQJub40I5czvENwtp5U+/b0RJw6Q+t+n
nseoZ9/I0B60v2mTv773vXbsytoDxC8ERJBiLu7PRm4/1trak9qoaqrLqxxp57gC
fZpQ7NVz8X9LCvwbBhUu9FawrN8YjNn2Yz22uE5db1bY725qyDFfCWn1rZzJhZmq
cQ/PwVTyw8LDWw9A2lwFZ9nXZkZQzUYt6Wyap5+N15Vbhd3I4g4t+U5uGAUSxKx6
swMP8If11Yqff8AauiWE1lxFRxPQxpDGrX55DeB8e8lIQflUdPyNh9W06Kil7oYE
ld9olTyn5MKe/w3ybOmh
=2TWc
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--
