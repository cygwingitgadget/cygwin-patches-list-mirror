Return-Path: <cygwin-patches-return-7585-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30074 invoked by alias); 2 Jan 2012 18:09:38 -0000
Received: (qmail 30062 invoked by uid 22791); 2 Jan 2012 18:09:37 -0000
X-SWARE-Spam-Status: No, hits=-1.7 required=5.0	tests=AWL,BAYES_00,RP_MATCHES_RCVD,SPF_HELO_PASS
X-Spam-Check-By: sourceware.org
Received: from dancol.org (HELO dancol.org) (96.126.100.184)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 02 Jan 2012 18:09:23 +0000
Received: from c-24-18-179-193.hsd1.wa.comcast.net ([24.18.179.193] helo=edith.local)	by dancol.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)	(Exim 4.72)	(envelope-from <dancol@dancol.org>)	id 1RhmK2-0006gi-Ph	for cygwin-patches@cygwin.com; Mon, 02 Jan 2012 10:09:22 -0800
Message-ID: <4F01F2D1.6000501@dancol.org>
Date: Mon, 02 Jan 2012 18:09:00 -0000
From: Daniel Colascione <dancol@dancol.org>
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:8.0) Gecko/20111105 Thunderbird/8.0
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Add pthread_sigqueue(3)
References: <1325444340.6724.15.camel@YAAKOV04> <20120102175952.GB9433@ednor.casa.cgf.cx>
In-Reply-To: <20120102175952.GB9433@ednor.casa.cgf.cx>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="------------enig46EE3E0F9C4EFA3413E28AE6"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2012-q1/txt/msg00008.txt.bz2

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig46EE3E0F9C4EFA3413E28AE6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-length: 481

On 1/2/12 9:59 AM, Christopher Faylor wrote:
> On Sun, Jan 01, 2012 at 12:59:00PM -0600, Yaakov (Cygwin/X) wrote:
> I guess this can go in since I already "implemented" sigqueue but
> SI_QUEUE isn't actually fully functional.  Cygwin doesn't queue signals
> and I don't believe it handles the sigval union correctly.

By the way: have you had a chance to track down the signal-related
crash bug at http://sourceware.org/ml/cygwin/2010-04/msg00989.html ? I
can still reproduce it.


--------------enig46EE3E0F9C4EFA3413E28AE6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-length: 235

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (Darwin)
Comment: GPGTools - http://gpgtools.org

iEYEARECAAYFAk8B8tEACgkQ17c2LVA10Vtb1ACaA1Pn+WMagxBSOg0vtjGXFHQL
xzsAn0hCSJ7e96Y+OJ5Epy41e6ZJ4GeQ
=5ZlP
-----END PGP SIGNATURE-----

--------------enig46EE3E0F9C4EFA3413E28AE6--
