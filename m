Return-Path: <cygwin-patches-return-8182-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 117467 invoked by alias); 17 Jun 2015 08:46:30 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 117452 invoked by uid 89); 17 Jun 2015 08:46:29 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-5.4 required=5.0 tests=AWL,BAYES_00,KAM_LAZY_DOMAIN_SECURITY autolearn=no version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 17 Jun 2015 08:46:28 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 0A15FA807BF; Wed, 17 Jun 2015 10:46:26 +0200 (CEST)
Date: Wed, 17 Jun 2015 08:46:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Hide sethostname() in unistd.h
Message-ID: <20150617084626.GI31537@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <55804E7D.3060504@t-online.de> <20150616174551.GF31537@calimero.vinschen.de> <558107F2.3030809@t-online.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="XilfshMFnlxBucLf"
Content-Disposition: inline
In-Reply-To: <558107F2.3030809@t-online.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2015-q2/txt/msg00083.txt.bz2


--XilfshMFnlxBucLf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1363

On Jun 17 07:38, Christian Franke wrote:
> Corinna Vinschen wrote:
> >On Jun 16 18:27, Christian Franke wrote:
> >>Found during an experimental build of busybox:
> >>
> >>The sethostname() prototype in /usr/include/sys/unistd.h is enabled als=
o on
> >>Cygwin.
> >>It should be disabled because Cygwin does not provide this function.
> >>
> >>Christian
> >>
> >
> >What about implementing sethostname instead?
> >
> >   extern "C" int
> >   sethostname (const char *name, size_t len)
> >...
>=20
> I didn't consider this as an alternative because I guessed that it is
> intentional that sethostname is missing.
> (it is not a typical that someone wants to use Cygwin to change the name =
of
> a Windows machine)

You're right there.  But, we have a lot of interfaces defined in newlib
headers which are not available on all platforms, but we're not
explicitely filtering them per platform.

Afaics, the problem is the configuration of busybox, not unistd.h.
Checking for prototypes in headers is not sufficient to check for the
availablility of functions, only for the availability of the prototype.
The configuration should also try a link check on the function with
AC_CHECK_FUNC or something like that.


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--XilfshMFnlxBucLf
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVgTPhAAoJEPU2Bp2uRE+gQCkQAJtLKlLYDRZOTyTP+Z+Jdgpk
TOyrOHRjJ5bkxqrmPI2E2UwnQfo03EgKaA0YcUwUdUyLYl31UR8Ymzz/B8QubXIb
QETfqYPVAR7c0/D3MUiznJBFLEEKSH30TBiwDo2fMjpK4aH7ZnDPhV1kqp5Qqi1F
QRRVRwVbPsKZ8fWRDNxgKpYC0RGNqu686Giz0Jbwe71m0CZadrwm36Cj9KJOnEVT
RRBFOMdm3eD7bqPII17p+U2tflBUaqsn0IHAH7ajC0LWHTvcTyJgybW6v+wiY0Ci
HOwEoUvEUYZUXJMiL1MDVS/+GcitxbdSf0FK7/PcQGpU1Rw6Dk5wX8pQoXjMM9Qo
2FYEK1kw5MxP1GMgGq/ob7ckFU3KU0QKSkQBDE5wqlV2j9x41wUElnWf0W3HQWrz
A2Pzb4d8Re8ZVHzWHHIwNf0MzaDIauANDf2clsooNjQ9/oyStGTmv8ZMumpLd4Ki
xJ0AcsOAYo61cINaFEU4w515Y19HGrDSjCQU673PLk4W5yR7YB8/+fFhhiWY4knw
r7PQ8PNIemLJy2xavfGe0ICa8SLEiDIjdMoLX9cGOiA1LTLHJ2dop6/uxo5Ty8yD
PF4sEZ9Mk81JXifjl/MmY4NCMUZulCQjgMpQI5mUDDkeAF1aABQP21MJj5H2iCWA
GKUTDYoRaqdderNcpeXX
=jttQ
-----END PGP SIGNATURE-----

--XilfshMFnlxBucLf--
