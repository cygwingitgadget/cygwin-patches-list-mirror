Return-Path: <cygwin-patches-return-8654-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16748 invoked by alias); 17 Nov 2016 10:08:38 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 15971 invoked by uid 89); 17 Nov 2016 10:08:37 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-101.5 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=border, thrice, Hx-languages-length:954, cygport
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 17 Nov 2016 10:08:31 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id 9801C71E3F90A	for <cygwin-patches@cygwin.com>; Thu, 17 Nov 2016 11:08:28 +0100 (CET)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id 0A8A15E008B	for <cygwin-patches@cygwin.com>; Thu, 17 Nov 2016 11:08:28 +0100 (CET)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 04904A805F2; Thu, 17 Nov 2016 11:08:28 +0100 (CET)
Date: Thu, 17 Nov 2016 10:08:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 3/6] forkables: Create forkable hardlinks, yet unused.
Message-ID: <20161117100827.GB29853@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1459364024-24891-1-git-send-email-michael.haubenwallner@ssi-schaefer.com> <1459364024-24891-4-git-send-email-michael.haubenwallner@ssi-schaefer.com> <d71ad20f-df44-0b88-bb3a-83abb9d7c709@ssi-schaefer.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="IiVenqGWf+H9Y6IX"
Content-Disposition: inline
In-Reply-To: <d71ad20f-df44-0b88-bb3a-83abb9d7c709@ssi-schaefer.com>
User-Agent: Mutt/1.7.1 (2016-10-04)
X-SW-Source: 2016-q4/txt/msg00012.txt.bz2


--IiVenqGWf+H9Y6IX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 936

On Nov 16 13:34, Michael Haubenwallner wrote:
> (sorry about previous empty mail)
>=20
> Hi Corinna,
>=20
> This is a fixup for the race condition where multiple processes failed
> to concurrently create identical hardlinks.
>=20
> So I'm quite successful with the forkable hardlinks now...

I'm still pretty unhappy with this patch.  It adds *lots* of code
to handle a seldom border case.

Assuming you perform some action which starts lots of processes.
Like, say, a bigger build.  Let's say, you install the coreutils
source package and run `time cygport coreutils.cygport prep build'.

If you do this thrice, once without your patch, once with your patch
but without utilizing it, and once with your patch and utilizing it,
how do they compare?  Do you have numbers?


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--IiVenqGWf+H9Y6IX
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYLYGbAAoJEPU2Bp2uRE+g7egP/i3Keswvsu199Ac47w3FontO
4GrwwOzregNykIORRoBrkOziskuuYvIfVVHlHuuTn3+7sGbpik4XPRm8MrftQQr8
MmYrBj7VgDizzw1I/cfRcpb7UbBVCrnivEFsqn9u3ns9DoHqnrt3C51iSkgPBt35
hHoZo1hwgvWtOUAIk3FXRYBy9rQOmkjCwR5cwzwa2SI0L3zwpDWk9lq6fDU6oPGM
BDyuJHP2fT7LAvNb0BsPlo4pdFUn+YZMm65UjnFIFhhyYL9W8F03qTLgR7gdqDuv
l80jmUnt8dnNVcUzZxFYXnjm74YUE2Zi68B42bONYrzEEBcNKy4KV2zhIaTBPqzr
0e0Q43jqy+auyKrFZvRmBtno2qWzHUezTsKC97vH8rX14Wj60dnZtgA7iU3tgXHT
69BblsgjGhG1vpMw01RwzaYkeCAikmYI7GzsMfQ7V8BRNXGZ9GPPTnQO+Hfz075J
c7hvdmnvmjRWlP6m5MURnxAf6BeX8i4icxVq8bDnhB9ZFuAc0hpiy65bEqDsnnF2
zZjpL9cC8fdSfQ9Ei9IVREwgTGP3LUNDAOYbG/qHwZcZrXS4wrD0Mz+EWKpIZ3Zd
Cv/lkMkk4PH+H7buaB69La5YaAYSZRkIQD7nDZ0tefz1Z2+OMwM8vQymM0enKG14
w8bjAmDbBTMGa0KiXi/7
=b5C6
-----END PGP SIGNATURE-----

--IiVenqGWf+H9Y6IX--
