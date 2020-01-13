Return-Path: <cygwin-patches-return-9912-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 63546 invoked by alias); 13 Jan 2020 15:56:23 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 63536 invoked by uid 89); 13 Jan 2020 15:56:23 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-124.4 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=HX-Languages-Length:1471
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.17.10) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 13 Jan 2020 15:56:22 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id 1N2mWA-1jnJ9j3Qho-0135Yd for <cygwin-patches@cygwin.com>; Mon, 13 Jan 2020 16:56:19 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 6FBC9A806B2; Mon, 13 Jan 2020 16:56:19 +0100 (CET)
Date: Mon, 13 Jan 2020 15:56:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Add missing CloseHandle() calls.
Message-ID: <20200113155619.GJ5858@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200101064845.8756-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="lIrNkN/7tmsD/ALM"
Content-Disposition: inline
In-Reply-To: <20200101064845.8756-1-takashi.yano@nifty.ne.jp>
X-SW-Source: 2020-q1/txt/msg00018.txt


--lIrNkN/7tmsD/ALM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1501

Hi Takashi,

On Jan  1 15:48, Takashi Yano wrote:
> ---
>  winsup/cygwin/fhandler_tty.cc | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
>=20
> diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
> index 65b12fd6c..23156f977 100644
> --- a/winsup/cygwin/fhandler_tty.cc
> +++ b/winsup/cygwin/fhandler_tty.cc
> @@ -2242,11 +2242,27 @@ fhandler_pty_master::close ()
>  	  /* Terminate helper process */
>  	  SetEvent (get_ttyp ()->h_helper_goodbye);
>  	  WaitForSingleObject (get_ttyp ()->h_helper_process, INFINITE);
> +	  CloseHandle (get_ttyp ()->h_helper_goodbye);
> +	  CloseHandle (get_ttyp ()->h_helper_process);
>  	  /* FIXME: Pseudo console can be accessed via its handle
>  	     only in the process which created it. What else can we do? */
>  	  if (master_pid_tmp =3D=3D myself->pid)
> -	    /* Release pseudo console */
> -	    ClosePseudoConsole (get_pseudo_console ());
> +	    {
> +	      /* ClosePseudoConsole() seems to have a bug that one
> +		 internal handle remains opened. This causes handle leak.
> +		 This is a workaround for this problem. */
> +	      typedef struct
> +	      {
> +		HANDLE hWritePipe;
> +		HANDLE hConDrvReference;
> +		HANDLE hConHostProcess;
> +	      } HPCON_INTERNAL;

Can you please move this struct to some header?  Even if it's not a
really close match, maybe ntdll.h works best, combined with a short
comment what this is about...


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--lIrNkN/7tmsD/ALM
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl4ckyMACgkQ9TYGna5E
T6DtSg/+PQyFaG1MF3xfjVzvW8a6SPhYZQxiclz3f98ute0/9H6/ItuN8QzRxMEF
Mt8uY6sptrVwOYtUzvYKgsGAK1fXahmHV9l9UchS+aFddX0hQpn5jxH2/Z+a3I+A
UXpL4rIyiKop43dDo0IkMVqDaDZQcteeBzbrmYRULEDcGxQRHTEaVOCPAsirUb01
pBH5VxbXzg/5uyd9cNuQYNpgECkQ+6cC0LjmjTGgAo6IYAE0G7peIMB/znsBRqnB
uKczycel024DmPTLNRbxRRuLWAdL3sGY1qloCGSuHoXVaXlNlfAnKRNNQ9KQFbLJ
QKWQoNIHuEqOcBXIac8U9ZhrE2Z8UR6x5xf1rQy8pLZEcTGODDxMhkgKUhggSsH7
4c0YO4FB6ym1ZA8FOiDh9gurit8JXzGhKKT2atQ6bsioIJ6EyvGowBacPWAqB0jX
1uphOVgALcEQfgEWGWWmfW2Wn1VsR984k0YaKHrCtzQDQBMtsebio9zWG0KbdRzB
FGbeFeEwkdYz4+QGszaDmFklXWUTlcQs/GjEhNblFV6pvsnFOUBlHa5MFmRndODk
fBAvRTc3jdRnkaHveIgsj8ejKttNVw9THMcsjRKV8/SId2tgBVZlb4BvI5hgTXwh
J+4yTca1BhgJmVF1GaFWNKNzXdC28h2P/opUek77XS4Bx4FrEgw=
=gvMC
-----END PGP SIGNATURE-----

--lIrNkN/7tmsD/ALM--
