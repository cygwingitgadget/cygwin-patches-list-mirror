Return-Path: <cygwin-patches-return-8813-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 121699 invoked by alias); 2 Aug 2017 08:12:43 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 119808 invoked by uid 89); 2 Aug 2017 08:12:42 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-101.9 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=H*Ad:U*cygwin-patches, HTo:U*cygwin-patches, H*c:application
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 02 Aug 2017 08:12:41 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id E972B71E3F90A;	Wed,  2 Aug 2017 10:12:38 +0200 (CEST)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id 4E6565E01D9;	Wed,  2 Aug 2017 10:12:38 +0200 (CEST)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 316C0A8079A; Wed,  2 Aug 2017 10:12:38 +0200 (CEST)
Date: Sun, 06 Aug 2017 22:26:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: newlib@sourceware.org, cygwin-patches@cygwin.com
Subject: Re: [PATCH] Add elf.h to newlib
Message-ID: <20170802081238.GG25551@calimero.vinschen.de>
Reply-To: newlib@sourceware.org, cygwin-patches@cygwin.com
Mail-Followup-To: newlib@sourceware.org, cygwin-patches@cygwin.com
References: <20170802062108.20220-1-yselkowi@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="bKyqfOwhbdpXa4YI"
Content-Disposition: inline
In-Reply-To: <20170802062108.20220-1-yselkowi@redhat.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-SW-Source: 2017-q3/txt/msg00015.txt.bz2


--bKyqfOwhbdpXa4YI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 352

On Aug  2 01:21, Yaakov Selkowitz wrote:
> This is copied from musl (MIT license).  This is newer and more thorough
> than that of FreeBSD currently shipped only on Cygwin.

Please push.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--bKyqfOwhbdpXa4YI
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZgYl2AAoJEPU2Bp2uRE+g6MgP/ieD+3krlyCsVqnNW7snr7C7
0V3+EB7PnFlbuk39Q28g9ZwSStSYv0sGljfniG6It7gSzlsqrptx+p9DDbcvH6QS
fpoZgAlItR7vzzPLc5cVUHROHEd511MTXWw8Pny9sza/WkGQ7IR9n9PabEOz5QuY
rA6GKJsHQmrZsf2wkzpU3U6+rEhyO8iLUY9NPh9nlbifgeg+U/4FXYpdOrLiKXTt
MG+D+cBVFf4MZQRAcXCaNolMm4cOSU+k2SdYYQqFIJ0JcvJuhw+NhVjvv7xrEwC/
di2bx4tD+zco3VYg5tFsSfl2XET5lszaXAf/SnVIXzadSOZZ1zi5XEpYsL8UxX2I
MA73WAhUGOwIwKzAcQHP7lVju41Mc745irKz5oEkItFkV25e169luLfnpxscDxPE
qo6qkVuyy8rmsytqYn7pG1r4puPzfD1CNEilWHyFH/9MO+TwmphxreVv41CxYROG
Py7Cq3pZ4mQqMPalu9IX+UHzuaf+6jxGss4u3C2j5bR7r+eborIXo+dwczoDAGKN
be/j3sYBtGziiyuieXj1GWCn/UKoS1zkPy9BMCr0CiwIEN44k5jjvg61c2x7K+V2
famsT4ScfOaPrtaXgv505vUx1gGuAAFOLFH7zK/vmVm6YoQtOJP2M2HvtYvZH8zA
vZ7bPLteQM7xOdve+cf/
=2zwc
-----END PGP SIGNATURE-----

--bKyqfOwhbdpXa4YI--
