Return-Path: <cygwin-patches-return-10054-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 119331 invoked by alias); 10 Feb 2020 10:04:48 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 119321 invoked by uid 89); 10 Feb 2020 10:04:48 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-109.7 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=HX-Languages-Length:661, screen
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.134) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 10 Feb 2020 10:04:46 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MTw02-1issTB41Z4-00Qzvf for <cygwin-patches@cygwin.com>; Mon, 10 Feb 2020 11:04:44 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 1589BA80CFA; Mon, 10 Feb 2020 11:04:43 +0100 (CET)
Date: Mon, 10 Feb 2020 10:04:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/4] Remove debug codes and organize with some fixes.
Message-ID: <20200210100443.GA4442@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200209144603.389-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="h31gzZEtNLTqOjlF"
Content-Disposition: inline
In-Reply-To: <20200209144603.389-1-takashi.yano@nifty.ne.jp>
X-SW-Source: 2020-q1/txt/msg00160.txt


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 634

On Feb  9 23:45, Takashi Yano wrote:
> Takashi Yano (4):
>   Cygwin: pty: Define mask_switch_to_pcon_in() in fhandler_tty.cc.
>   Cygwin: pty: Avoid screen distortion on slave read.
>   Cygwin: pty: Remove debug codes and organize related codes.
>   Cygwin: pty: Add missing member initialization for struct pipe_reply.
>=20
>  winsup/cygwin/fhandler.h      |  12 +--
>  winsup/cygwin/fhandler_tty.cc | 144 +++++++++++++++-------------------
>  winsup/cygwin/select.cc       |  23 ------
>  3 files changed, 67 insertions(+), 112 deletions(-)
>=20
> --=20
> 2.21.0

Pushed.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--h31gzZEtNLTqOjlF
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl5BKroACgkQ9TYGna5E
T6CvFhAAoTNHCiPDA7QsdzZ+F0whDogFg5pxvQGil5xzErlsEuj7Umy3jFr4B/h3
Bkl8YVvrsi20fmDUWusQhmLx3uzexE5+i0jp4Jp9WfFGngCKdhEt4N1fcBD8ZF25
d0v2IMvND9zfvm2sbb2Rj/iR5RpXFO4o3bL3d/r2/3kVyvD1NJxfdp7srEqTLNp9
FwHDl3jNJcXy4EewsFro5zatjzz2shu6FcrE9IGA90PzuLvok4WeKLRfnW9wOaEk
4uBaI2pH9cKR+lIelDvluPhYb2g6Y25Q5PnRU/G9hagpRpGzijqy5n5HWPniFOVM
46p6gWdHBlfuAdT5BMl9+C0vAcjbD94BDA5WzUwehq0ytQ03hsb5yTXk/8VxK3bg
OPRtOLGVnt0GvZRcEMzofbZTZSSt6ikjOxmXDplgLXPhRvftjNiHVVZ6zAiWlHOh
Mhmtgm5BniSxAXsr7GIh8+h5y+0JtuOQLhH6Za8qHPwCa8uf2ePeRhpayZtrrx46
/FTDPAo2wdFtykOOx91rU7elGBTD6NdP85qy+DuSA454zT96lK9HXAg6Sv99A9ky
6HgTC8J5K+ApqRf6IBu2/FryspN9eeubghXgJxeLUNz0ztdGzELxCow4dKG3Kmlf
6n7FTYidbzS+uSecqY+tnal+gCULtF6vRWPON/xFKEOpCrCPpCI=
=CwIa
-----END PGP SIGNATURE-----

--h31gzZEtNLTqOjlF--
