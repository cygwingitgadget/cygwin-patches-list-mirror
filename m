Return-Path: <cygwin-patches-return-10055-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 120405 invoked by alias); 10 Feb 2020 10:05:08 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 120390 invoked by uid 89); 10 Feb 2020 10:05:08 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-109.7 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.130) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 10 Feb 2020 10:05:03 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id 1N7iT4-1jWd3u2Fmc-014gTx for <cygwin-patches@cygwin.com>; Mon, 10 Feb 2020 11:05:00 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 039C8A80CFA; Mon, 10 Feb 2020 11:05:00 +0100 (CET)
Date: Mon, 10 Feb 2020 10:05:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Inherit typeahead data between two input pipes.
Message-ID: <20200210100459.GB4442@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200209144659.441-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="24zk1gE8NUlDmwG9"
Content-Disposition: inline
In-Reply-To: <20200209144659.441-1-takashi.yano@nifty.ne.jp>
X-SW-Source: 2020-q1/txt/msg00161.txt


--24zk1gE8NUlDmwG9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 954

On Feb  9 23:46, Takashi Yano wrote:
> - PTY has a problem that the key input, which is typed during
>   windows native app is running, disappear when it returns to shell.
>   (Problem 3 in https://cygwin.com/ml/cygwin/2020-02/msg00007.html)
>   This is beacuse pty has two input pipes, one is for cygwin apps
>   and the other one is for native windows apps. The key input during
>   windows native program is running is sent to the second input pipe
>   while cygwin shell reads input from the first input pipe.
>   This patch realize transfering input data between these two pipes.
> ---
>  winsup/cygwin/fhandler.h      |  12 +-
>  winsup/cygwin/fhandler_tty.cc | 400 ++++++++++++++++++++++++++--------
>  winsup/cygwin/select.cc       |   2 +
>  winsup/cygwin/tty.cc          |   3 +
>  winsup/cygwin/tty.h           |   3 +
>  5 files changed, 329 insertions(+), 91 deletions(-)

Pushed.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--24zk1gE8NUlDmwG9
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl5BKssACgkQ9TYGna5E
T6BkJg/9Gc1Zb4b8X994WnAxl6MGBkZn10Z0z0WrXAa+733o+YU6ntYFXByGw1iu
r+CiIDu6ENI1zsg8V7u2NQuf7TRrSDXFxnQUoxNTWgyJ/gLjMdEyzEO8JzpBaKWa
CPUq/FtTDW/Z7cLeBFcOZ/6wEiwVJUB4FF9gqzc/yHZIAAfP7se4h3XHzZbj4M6X
lX1d280WS50uMlWMBdVKAFStOzKxQ5YF4mXpP4Zr8/fLe5F+IYO6ybi5VXBXaAdC
PDoroZ3sQxVDtenLMuaeK99P2hHj79CT2upbF9yibjVw2DUkw6YQDoSoP6xxXWDI
NjglzEJnHraUhdWiEh7vCGO+oqzVuMcAyyOy79lBUpQpwiEeZjZgsj0vvXDOQ32N
GCM6cyOhHU8KOgNOVcGgLQ3P2auuTub4lJR0EspCsAMfrKDtR9dmQl/kdxmjqc3U
pw/kRp3810G6X3OgW7mEGB5ZBU7OvfRXSsLhcLiHFR6DdWNbp8t8CRXi7JDxWxfO
XvaFVfth4TrEbrjMAB0qbMC0yJ3A+cc44wnNWbOrSioJqf/JXE/SB/qRufrYenXR
RWXUHSsLnLGoO4v+rNsqfb0i6bo2IcPrkOSbR6K9nRhv2Dd0HpuD6S0hqiP81rk6
jwZzj0SPrlAJWAlO2dbfwyj2wv1cJOdOzJKHxQvz97cU+ViZH2A=
=tCEc
-----END PGP SIGNATURE-----

--24zk1gE8NUlDmwG9--
