Return-Path: <cygwin-patches-return-10134-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25361 invoked by alias); 26 Feb 2020 20:22:30 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 25352 invoked by uid 89); 26 Feb 2020 20:22:30 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-111.6 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.187) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 26 Feb 2020 20:22:29 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id 1Mo77T-1jmSRE0xJr-00pcId for <cygwin-patches@cygwin.com>; Wed, 26 Feb 2020 21:22:27 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id E2921A82772; Wed, 26 Feb 2020 21:22:26 +0100 (CET)
Date: Wed, 26 Feb 2020 20:22:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 0/4] Modify handling of several ESC sequences in xterm mode.
Message-ID: <20200226202226.GY4045@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200226153302.584-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="/TUrtqMIkCP4YtJm"
Content-Disposition: inline
In-Reply-To: <20200226153302.584-1-takashi.yano@nifty.ne.jp>
X-SW-Source: 2020-q1/txt/msg00240.txt


--/TUrtqMIkCP4YtJm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 662

On Feb 27 00:32, Takashi Yano wrote:
> Takashi Yano (4):
>   Cygwin: console: Add workaround for broken IL/DL in xterm mode.
>   Cygwin: console: Unify workaround code for CSI3J and CSI?1049h/l.
>   Cygwin: console: Add support for REP escape sequence to xterm mode.
>   Cygwin: console: Add emulation of CSI3J on Win10 1809.
>=20
>  winsup/cygwin/fhandler_console.cc | 247 +++++++++++++++++++++++++++---
>  winsup/cygwin/wincap.cc           |  20 +++
>  winsup/cygwin/wincap.h            |   4 +
>  3 files changed, 248 insertions(+), 23 deletions(-)
>=20
> --=20
> 2.21.0

Looks good to me.  Pushed.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--/TUrtqMIkCP4YtJm
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl5W04IACgkQ9TYGna5E
T6Ap8Q//UoltViVgAA4IN8Fwx1ty4CrW+BW9+aCTCpFIYUkVYVzFYRvKrebH2eRN
ipR/1T6t95obabWItaV5NX+nVAmirzL9svUOo3NJRnZYw8dajAEOrcigGAww8Ave
scRFrUSfuQBegroSomlQvpP7O9V8k9f/USWGfp/36nlz65MmCZs7BH0xRMbmvZYD
cgKbuq5k/XvRDjc82ImQxqIoBymxjMNkzj0zp9ela0rxfJjSG1bCDLZtGm8Vwxk9
qJShP1h5RRucpKkL2l3co15EveMaNLv/qMRuD5UqrbTkC4kvLiMkrzwvFKno5Ii9
DIe5E0Rfmdcoxo9/rqrgvi98dlOXm0PGCvR+908OU/p3o9+HKmxtnMpzm/lX6/rQ
V5V3hQOER+NKHfrcLaohGUKNXcH3VITMNe76Ebkf6zIPMGFMogSYEG7YVAle1ThK
sWbHW00OZagRlBELua0YEuiwPklboUTv3FSuIPSMUXXlieZBYv9KYZAPM474/OIe
jrJY+o5PaNaobGL5CUmRkjGNkbqB5soN5YweG69eRXLDJosJUjnL2AO1a7flpBzo
4I90lUAqqAW/bPS0GezzWRqK+7DKNSll0OKhScZfsCdBDvfwBAjVmUFeQPo3gYll
8JW01CimAoqIfxfTOwMcJMvp4JDLr/Jw5dwo7cO2Wmc+NtOUJCA=
=ThOh
-----END PGP SIGNATURE-----

--/TUrtqMIkCP4YtJm--
