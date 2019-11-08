Return-Path: <cygwin-patches-return-9814-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 75679 invoked by alias); 8 Nov 2019 09:22:35 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 75668 invoked by uid 89); 8 Nov 2019 09:22:35 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-109.6 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*F:D*cygwin.com
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.130) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 08 Nov 2019 09:22:34 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MPXpS-1iGPGX1qMs-00MepV for <cygwin-patches@cygwin.com>; Fri, 08 Nov 2019 10:22:31 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id CD50FA8065B; Fri,  8 Nov 2019 10:22:30 +0100 (CET)
Date: Fri, 08 Nov 2019 09:22:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3] Cygwin: console, pty: Prevent error in legacy console mode.
Message-ID: <20191108092230.GY3372@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20191106162929.739-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="JfVplkuTfB13Rsg5"
Content-Disposition: inline
In-Reply-To: <20191106162929.739-1-takashi.yano@nifty.ne.jp>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SW-Source: 2019-q4/txt/msg00085.txt.bz2


--JfVplkuTfB13Rsg5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 539

On Nov  7 01:29, Takashi Yano wrote:
> ---

Pushed, albeit I'm still missing a bit of description here.  Just a one
liner is a bit low on info during `git log'.  I'd really appreciate more
descriptive log messages...

>  winsup/cygwin/environ.cc          |  2 +-
>  winsup/cygwin/fhandler.h          |  1 +
>  winsup/cygwin/fhandler_console.cc | 46 ++++++++++++++++++++-----------
>  winsup/cygwin/fhandler_tty.cc     | 14 ++++++++++
>  4 files changed, 46 insertions(+), 17 deletions(-)

Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--JfVplkuTfB13Rsg5
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl3FM9YACgkQ9TYGna5E
T6AevQ//dFWqEjbagpgA2d+o4cHHWe7ZdkUKhQYLp31t2RaBR/dvPHhTQWTWe6dQ
dPIN6bm2ZoA0JKY9S+BxCpeAcPdNAGMk3+AB/IAouWheqCx9lAU+teJGdBGFbXIV
vUizbVrTRdLxD4fwAzAUF/Z1Y55c9FJS+fQ+Mz7VcaJFuHka8+PT5FjT8L+GWCvE
lmPHeVOZ+oWp0Oi09F4wd8X01wBJQNUOuJUFmcjgtBho16SLvfmS0/WpVCMV4jEM
XHuTWsqWTkXEu8nsCGlD+WsHPJkgNIelK8saCsPsYEnXyGMKh8a1vP0ZhY4PpfBA
yzrMWGBsfiuwqjUljaO1uLF5EyfWsifYFMRWnSX95JJxbGsPvEVmlSkb6RGuMW8r
wuH+z6bPtN/syxFHMVSDsaBX5PcC1Lc2bKc7zMZPh2/eeNMi+26Sv8D3QoSJ47Ly
BszS2ZzstGkWpXyWGLJ/MFWe3XOlqWMlrY+bLVbRyyjWhCaHk+Cv0JJQKYJ+MFtu
vp7B2BPoF6lSpcBuHBb7e9yBQ5S+yBXE81ABUzCySi3fgdaZFWdTWVQAkBZORUsI
mx4uuaUxkzQa4n3+eiewBnuj+E7yHKjOQdOAAK4HkeV37ibce0Yh9Zr5DwiSI0qO
o9xVV5oSQjWowTCRsx8P2oY86GjZxjOWveuBf9+Qwa5usEX61Lk=
=u/Sf
-----END PGP SIGNATURE-----

--JfVplkuTfB13Rsg5--
