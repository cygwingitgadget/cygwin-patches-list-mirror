Return-Path: <cygwin-patches-return-9967-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 50247 invoked by alias); 21 Jan 2020 09:37:47 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 50224 invoked by uid 89); 21 Jan 2020 09:37:47 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-108.2 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.135) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 21 Jan 2020 09:37:38 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id 1Mg6Na-1jXrof3iOs-00hbdM for <cygwin-patches@cygwin.com>; Tue, 21 Jan 2020 10:37:35 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 6ED41A80758; Tue, 21 Jan 2020 10:37:35 +0100 (CET)
Date: Tue, 21 Jan 2020 09:37:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: pty: Revise code waiting for forwarding by master_fwd_thread.
Message-ID: <20200121093735.GN20672@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200121111556.ceb40aa746220718b44dfb25@nifty.ne.jp> <20200121022202.2960-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="DWg365Y4B18r8evw"
Content-Disposition: inline
In-Reply-To: <20200121022202.2960-1-takashi.yano@nifty.ne.jp>
X-SW-Source: 2020-q1/txt/msg00073.txt


--DWg365Y4B18r8evw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 329

On Jan 21 11:22, Takashi Yano wrote:
> - Though this rarely happens, sometimes the first printing of non-
>   cygwin process does not displayed correctly. To fix this issue,
>   the code for waiting for forwarding by master_fwd_thread is revised.

Looks good.  Pushed.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--DWg365Y4B18r8evw
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl4mxl8ACgkQ9TYGna5E
T6CQQg/8CdHDPPY8oqYWmPx0cGB+fPLSJ/PyAbpjJ7ESwQrzyIf6cLSdLfnnHfhG
gGDCTZuGGw5wd80o4mJreKF810tIXqqTAvzQysj5z9hghMWyC2pFG0XSaM5baUoH
0zTbR54k5wzJ1hngWRAM/ehZGSJiQaaL9aw0wGH5NcxArXtSEr41bEz03a0yZz7c
ItLFYpQt6WErYZarcQO1BllsU6sAWHwEJE8Lc0fiH/mWMk61TYgVD16hD7GuI4Rd
k2guDsw5KbGVOxJDQI31ZZn2hUOAhpY+5atnXdAvLjpjsncZVKos1RawWlVxcyFv
uNmgJjnWROUd9cKkj9pvneBCdhTSescGv9Y8/9xfvx1Hzsv7bEPQEkGR6vcxun8I
gxKtm2CdseB/JbMmd6dGc8z/DOrxoLYXsB8mtR9M1iKhNK7iXEvKSZWRUMMQVrBl
JTXvtOFYxgi7W1N/3GCrUKqvyf8k+s8STdl8ZZU1aH/XJrT3EIHNiHrSNMsrgLb0
4aQ+CyFwyDtyPzGzfMg86cUiwqTJwu1vjmB5Dag8wsRlbGf3EyqVm9pYIyoM8zBp
VqMrlz7ECvGML0FJRY5It9gNTo7x548aQl6j0N2Z8vWKlG76bRImazIAiTrklFwM
uIe8ArM0H0d6dd8KcZtJ5gQnThKG9qJnCte39kUjlZzugHgB2rw=
=7CFp
-----END PGP SIGNATURE-----

--DWg365Y4B18r8evw--
