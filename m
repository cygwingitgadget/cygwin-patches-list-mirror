Return-Path: <cygwin-patches-return-10111-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 54987 invoked by alias); 24 Feb 2020 18:50:14 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 54977 invoked by uid 89); 24 Feb 2020 18:50:14 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-109.3 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=HX-Languages-Length:704
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.133) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 24 Feb 2020 18:50:12 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MCKWI-1jFgSR3LBy-009Ocx for <cygwin-patches@cygwin.com>; Mon, 24 Feb 2020 19:50:09 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 1D4CDA82770; Mon, 24 Feb 2020 19:50:09 +0100 (CET)
Date: Mon, 24 Feb 2020 18:50:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: console: Fix segfault on shared_console_info access.
Message-ID: <20200224185009.GI4045@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200224161217.1879-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="iVCmgExH7+hIHJ1A"
Content-Disposition: inline
In-Reply-To: <20200224161217.1879-1-takashi.yano@nifty.ne.jp>
X-SW-Source: 2020-q1/txt/msg00217.txt


--iVCmgExH7+hIHJ1A
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 643

On Feb 25 01:12, Takashi Yano wrote:
> - Accessing shared_console_info before initialization causes access
>   violation because it is a NULL pointer. The cause of the problem
>   reported in https://cygwin.com/ml/cygwin/2020-02/msg00197.html is
>   this NULL pointer access in request_xterm_mode_output() when it is
>   called from close(). This patch makes sure that shared_console_info
>   is not NULL before calling request_xterm_mode_output().
> ---
>  winsup/cygwin/fhandler_console.cc | 23 +++++++++++------------
>  1 file changed, 11 insertions(+), 12 deletions(-)

Pushed.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--iVCmgExH7+hIHJ1A
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl5UGuAACgkQ9TYGna5E
T6B4sQ/7Bkl2zVX6qQUarDKNPItSyA0layTNWo85+EOzoWPgJ+hKVg6UqPFEYNF0
Lr3TjE11jgsvlX3kdh/okQZmL0K8efcJQsxlwnrgLY6/giSEGXIZF+Fmi+mmcmhj
/gF6brHThx/0iy0yk8FqVZE+FWqkhPo8kLjXxeKmUVpGKHzxTruCb2/bJv8YvyWs
nppjweliZ/2j4W0nxRG5EJ0CRoACAIR1+fIlPY4TC9VKm4ZNC53POORw6yq0/vxx
6/B3Wqju/qexrrcilytnmFRKAFK/bgfiYbakJ7Ch2PiPOtp61eahiGbP2hMq5hnJ
dR4BT/K0KTxxfYIidNzmnUDbGVACGlSdzPMp4HLnAkKhPWZgPHymkMvRqm24w9kx
CceyAyYIg8hhWA0UlayeLtStmSfHEjRPLxbxFuhskjptTATmnI8hxgkx8CH0b3qr
XNytApzmBtBzyUxVikMyIb8RLaMD3WVr91DZfgGKjPi0rGqSMsYX3vv4b+WfYIF2
v9IWdgWadh5NfvhKJzJ/xzyPlNbM6NnEjYkipZVEgD+3+c4W3VUMm9e4LIjvoQIq
LPVipEiJWB+7ZLFi14nw0iUaGSzWr5CvcGCNqaOTUyGFQA0DsnCrfCJKijkJuBBZ
3tbH9ip8MXtP3wt1vM/Q/J9QEqzGwbWvoSE+Ws9CViu1QXBZIN8=
=L2vD
-----END PGP SIGNATURE-----

--iVCmgExH7+hIHJ1A--
