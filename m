Return-Path: <cygwin-patches-return-9638-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 60940 invoked by alias); 5 Sep 2019 12:11:15 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 60927 invoked by uid 89); 5 Sep 2019 12:11:15 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-106.3 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=screen
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.130) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 05 Sep 2019 12:11:14 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id 1M4bA6-1i7V1v3kpC-001gpB for <cygwin-patches@cygwin.com>; Thu, 05 Sep 2019 14:11:09 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 25528A80666; Thu,  5 Sep 2019 14:11:09 +0200 (CEST)
Date: Thu, 05 Sep 2019 12:11:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 0/1] Disable clear screen on new pty if TERM=dumb or emacs*.
Message-ID: <20190905121109.GC4136@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20190905002426.362-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="LyciRD1jyfeSSjG0"
Content-Disposition: inline
In-Reply-To: <20190905002426.362-1-takashi.yano@nifty.ne.jp>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SW-Source: 2019-q3/txt/msg00158.txt.bz2


--LyciRD1jyfeSSjG0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 739

On Sep  5 09:24, Takashi Yano wrote:
> - Pseudo console support introduced by commit
>   169d65a5774acc76ce3f3feeedcbae7405aa9b57 shows garbage ^[[H^[[J in
>   some of emacs screens. These screens do not handle ANSI escape
>   sequences. Therefore, clear screen is disabled on these screens.
>=20
> v2:
> Remove check for TERM in fixup_after_attach().
>=20
> Takashi Yano (1):
>   Cygwin: pty: Disable clear screen on new pty if TERM=3Ddumb or emacs*.
>=20
>  winsup/cygwin/fhandler_tty.cc | 19 ++++++++++++++-----
>  winsup/cygwin/tty.cc          |  1 +
>  winsup/cygwin/tty.h           |  1 +
>  3 files changed, 16 insertions(+), 5 deletions(-)
>=20
> --=20
> 2.21.0

Pushed.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--LyciRD1jyfeSSjG0
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl1w+1wACgkQ9TYGna5E
T6D0pBAApMdLniCByhCITXntgzlFQgZ92Ewvu1vpkRKCngynx0LEa7B98ipi/tni
BNyIdtdRWyDzQFKqQMxRFfuv/B6nskQ5gYAIlmZfIbG5jz6BitFGe2jrdJLqVQyA
OIrKkxsy2j+mHzoYCzLCX+patoFvG27JFKg8tbT3zIuHlgWx2NW1cimfXBZQ+AK1
56kKV3caW96rldTDFxlg/hdBSbUEugdkp69RYrMIETIWGzQzZa9nvsGK/EXg25wz
n/G6EepcHYlLB6Q93PdZ+6iYQVD37F2gvGOO8x658yC8YfoyskJE+Z/W/P68cjEg
5+0dEDjiIg+1yx1oC3z72mLmwFLAc/UHh/QawrHoM53JiiLikeL3rfZUxY4+SZAV
abb5LO1HA67OkgwA9yvXFyElxAU2uK2eUzSf/NOrtFquB1F830IInTcQ7GD4yD30
8qzp0hy1zD83AgicrTa+O2CNtY0I+8m+38hqQm8PkTEsNIBAMy0iTGNn4V1faZSX
BK9lccflmFoIeNJus1Ja9MOVy1RxWWlvLPHu1hEV4GiS0BE2jsBfO3Es80kHUmah
8lDf2fJ9Dnwxpv/Gn30WJvLnfzZe3ze8IkRXU4PLpizmQRCeCBBNPRVLQAI5m85L
HHYz9sGBYdqzPcsoBo0ags9ZhL3D0MfqrPOcwFnLK6g6LifR22g=
=M8Te
-----END PGP SIGNATURE-----

--LyciRD1jyfeSSjG0--
