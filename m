Return-Path: <cygwin-patches-return-9494-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 33017 invoked by alias); 19 Jul 2019 18:51:12 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 33008 invoked by uid 89); 19 Jul 2019 18:51:11 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-104.4 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_NUMSUBJECT,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=HX-Languages-Length:305
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.130) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 19 Jul 2019 18:51:11 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MzQwa-1ib8LU1Ntg-00vOhH for <cygwin-patches@cygwin.com>; Fri, 19 Jul 2019 20:51:08 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id A776FA80780; Fri, 19 Jul 2019 20:51:07 +0200 (CEST)
Date: Fri, 19 Jul 2019 18:51:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: unbreak the build with GCC 7
Message-ID: <20190719185107.GR3772@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20190719182710.34746-1-kbrown@cornell.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="sLx0z+5FKKtIVDwd"
Content-Disposition: inline
In-Reply-To: <20190719182710.34746-1-kbrown@cornell.edu>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q3/txt/msg00014.txt.bz2


--sLx0z+5FKKtIVDwd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 260

On Jul 19 18:27, Ken Brown wrote:
> The recent port to GCC 8 used the 'nonstring' attribute, which is
> unknown to GCC 7.  Define and use an 'ATTRIBUTE_NONSTRING' macro
> instead.

LGTM, please push.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--sLx0z+5FKKtIVDwd
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl0yERsACgkQ9TYGna5E
T6B/Aw/+N8+QfMtKBKVOAKfUAhmAoO69KVO3tR5QUaQKy774hV1V/N5eKUYB2y8x
vOGT4cPov1adSmbp7kaB0xm1E+wqSeatMxa4q9Eno2B0S0OO+eT5ZTD4kfL4AlsG
1fdJFod6NoAJJUoDp/lQSOs0SG/3dX/pfK5hSKcTxg9P+B0KVwBjtod7yZSsAef2
lArrKFMQ8HneFOYVLyC7g1jOgmRTG6UIk/tEDlDc7RkGzTUngP/frlM8rseqmkKW
MfglKOv5FNsGo0jxJjF2H3xLvebt/wH9J88+Tcd2BGYf37JHOf3IeKOKevG7iiuh
w9wzhI8PeaTXH0ZENPk2a/0hgQsl01+8uNqnwA1nc/E3xFB9R4rnMAJRocmtxslw
zKk16uUs5JqVAW90XuseSHQK+0UJP8fxP4dthgmW5Rs2V4q8Oj/sW77n98qZhLaw
BXEiAN5/ZRArJLmMT7lm+x2ipoe0rsLmqocJBoIWjUJItXPQU3fw4eLhgXLndwY4
UHi2eoABxDjafZp8h7BbovSX+Y5i3YBxB8pBx2jrfgHEqhv+Bypq2k7SSPD+bW7v
w7OAN16P6afErLl2QPJm1OMO71xKm/VFaWmzSMb4xQij651HLQDMI5X3jbEoBS5H
DCQXox4UhMU9CEFCOiCf5qYNPhpqrIKJaVPMXe+Y9LQJNMd72Yw=
=5qAX
-----END PGP SIGNATURE-----

--sLx0z+5FKKtIVDwd--
