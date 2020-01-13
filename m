Return-Path: <cygwin-patches-return-9913-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 87366 invoked by alias); 13 Jan 2020 16:00:53 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 73249 invoked by uid 89); 13 Jan 2020 16:00:46 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-124.8 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.187) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 13 Jan 2020 16:00:45 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id 1Mum6l-1jiafR1eXj-00roIN for <cygwin-patches@cygwin.com>; Mon, 13 Jan 2020 17:00:42 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 0B66DA806B2; Mon, 13 Jan 2020 17:00:42 +0100 (CET)
Date: Mon, 13 Jan 2020 16:00:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Remove destructor for fhandler_pty_master class.
Message-ID: <20200113160042.GK5858@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200101064941.8803-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="FwyhczKCDPOVeYh6"
Content-Disposition: inline
In-Reply-To: <20200101064941.8803-1-takashi.yano@nifty.ne.jp>
X-SW-Source: 2020-q1/txt/msg00019.txt


--FwyhczKCDPOVeYh6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1448

On Jan  1 15:49, Takashi Yano wrote:
> - The destructor for fhandler_pty_master class does not seem to be
>   necessary anymore. Therefore, it has been removed.
> ---
>  winsup/cygwin/fhandler.h      | 1 -
>  winsup/cygwin/fhandler_tty.cc | 9 ---------
>  2 files changed, 10 deletions(-)
>=20
> diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
> index 3954c37d1..4a71c1628 100644
> --- a/winsup/cygwin/fhandler.h
> +++ b/winsup/cygwin/fhandler.h
> @@ -2218,7 +2218,6 @@ public:
>    HANDLE get_echo_handle () const { return echo_r; }
>    /* Constructor */
>    fhandler_pty_master (int);
> -  ~fhandler_pty_master ();
>=20=20
>    DWORD pty_master_thread ();
>    DWORD pty_master_fwd_thread ();
> diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
> index 23156f977..d3d0d7430 100644
> --- a/winsup/cygwin/fhandler_tty.cc
> +++ b/winsup/cygwin/fhandler_tty.cc
> @@ -2126,15 +2126,6 @@ fhandler_pty_master::fhandler_pty_master (int unit)
>    set_name ("/dev/ptmx");
>  }
>=20=20
> -fhandler_pty_master::~fhandler_pty_master ()
> -{
> -  /* Without this wait, helper process for pseudo console
> -     sometimes remains running after the pty session is
> -     closed. The reason is not clear. */
> -  if (to_master && from_master)
> -    Sleep (20);
> -}
> -
>  int
>  fhandler_pty_master::open (int flags, mode_t)
>  {
> --=20
> 2.21.0

Pushed.


Thanks,
Corinna
--=20
Corinna Vinschen
Cygwin Maintainer

--FwyhczKCDPOVeYh6
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl4clCkACgkQ9TYGna5E
T6DyjRAAg4U+GRsEQVP3k0QGOqT1eQlAZCHc0Y6LYooV847KvZUITY+iH6CgIl1M
FCF7+GQ+EIlDmW/iWKYwcFmTEaycZeEbySlZy6QRFyT3X8cVohqOeWpFQs5hKyxm
6SluA6cOGR/WFmA/LybzAMXhETPvvvsCdqksVSJEKNQ1SuQptpteISdtX4Pnxneh
4Zipc35Sk2rG81LvL7VykJt0V+Moe0VbqumLdGbhdZnMqlVw8jGfXKQ5lDq/JXzi
MloRmipkH9qkafSMjIOwcxVzpMIHwAhtMYk7/45LPL02U/1Olrtamu94j29HMtdY
LbEpwF+SftYmyHKKOUYQW+FvALK0ln3Za2CnLT+1B7r7r+TzI6ocMAZT5g+Gj4RP
g5CT8VTGszEmgOXBkIyKUp70QnKU7jbZ86ARObz88UFmHURJPHF1EASrqjjeVMfp
PIs9vUENEh49BZ+OtRHtPurkrN0bTrrQwxYE/6nPjx9w/O85UXLO7le5HOybD9/C
ryNVtBFnpbenz1qxCj5QsoeF6fDNXSnS9/xdXn/VdF2gTV2i8uLKUmCufnt2Zx5m
vwox14d6kbNnN+Db3V+niyZO8tecldAFmT6wnXL/zBWpy96h32b2NU+AwrBZCOw4
0IdQccN5qEuOuKzFKv9/EXvUwlyN1vSZHpCOuFFtp/jvxwIN9Cg=
=5R6w
-----END PGP SIGNATURE-----

--FwyhczKCDPOVeYh6--
