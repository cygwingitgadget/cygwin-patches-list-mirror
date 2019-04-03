Return-Path: <cygwin-patches-return-9307-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10243 invoked by alias); 3 Apr 2019 16:46:57 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 10233 invoked by uid 89); 3 Apr 2019 16:46:57 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-114.3 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=HX-Languages-Length:1635, H*F:D*cygwin.com
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.17.24) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 03 Apr 2019 16:46:56 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id 1N9d4t-1gogKO3sg9-015WmB for <cygwin-patches@cygwin.com>; Wed, 03 Apr 2019 18:46:53 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 072E1A8034C; Wed,  3 Apr 2019 18:46:53 +0200 (CEST)
Date: Wed, 03 Apr 2019 16:46:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/1] Cygwin: console: fix key input for native console application
Message-ID: <20190403164652.GA21669@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20190403072758.GR3337@calimero.vinschen.de> <20190403162531.2837-1-takashi.yano@nifty.ne.jp> <20190403162531.2837-2-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline
In-Reply-To: <20190403162531.2837-2-takashi.yano@nifty.ne.jp>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q2/txt/msg00014.txt.bz2


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1677

On Apr  4 01:25, Takashi Yano wrote:
> - After 24 bit color support patch, arrow keys and function keys
>   do not work properly in native console applications if they
>   are started in cygwin console. This patch fixes this issue.
> ---
>  winsup/cygwin/fhandler_console.cc | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>=20
> diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_c=
onsole.cc
> index d2e3184a6..335467b0b 100644
> --- a/winsup/cygwin/fhandler_console.cc
> +++ b/winsup/cygwin/fhandler_console.cc
> @@ -455,6 +455,15 @@ sig_exit:
>  fhandler_console::input_states
>  fhandler_console::process_input_message (void)
>  {
> +  if (wincap.has_con_24bit_colors ())
> +    {
> +      DWORD dwMode;
> +      /* Enable xterm compatible mode in input */
> +      GetConsoleMode (get_handle (), &dwMode);
> +      dwMode |=3D ENABLE_VIRTUAL_TERMINAL_INPUT;
> +      SetConsoleMode (get_handle (), dwMode);
> +    }
> +
>    char tmp[60];
>=20=20
>    if (!shared_console_info)
> @@ -2894,6 +2903,14 @@ fhandler_console::fixup_after_fork_exec (bool exec=
ing)
>  {
>    set_unit ();
>    setup_io_mutex ();
> +  if (wincap.has_con_24bit_colors ())
> +    {
> +      DWORD dwMode;
> +      /* Disable xterm compatible mode in input */
> +      GetConsoleMode (get_handle (), &dwMode);
> +      dwMode &=3D ~ENABLE_VIRTUAL_TERMINAL_INPUT;
> +      SetConsoleMode (get_handle (), dwMode);
> +    }
>  }
>=20=20
>  // #define WINSTA_ACCESS (WINSTA_READATTRIBUTES | STANDARD_RIGHTS_READ |=
 STANDARD_RIGHTS_WRITE | WINSTA_CREATEDESKTOP | WINSTA_EXITWINDOWS)
> --=20
> 2.17.0

Pushed.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlyk43wACgkQ9TYGna5E
T6AlKBAAh8Upq0pAFDOHcXRZaASy0ZbzMFQ2eEYbLp29zXqymgAvRtmIu8ev1sDW
K6KnH1yJpJi5h9n+1wS0h6ADU0VoGnDmAbAYtHMXQP1+WXN5xApTq2enXJgCYOVG
Qlw4DhAV1JKBrTEznsnXu/U1L2AQSzMccJAeemIL29PpvyP/7z/0YYewAWAoV67w
FJZW1Bdab/pZTcvRdGyJWswx9cDkJHxLzPPKlGQlBCj7Eny4UHYFSsfnbeBjgmvd
VJvJfmJs6FHVqylb4N2thMWYtKth09hBhvMyP1l6J4EmSxVBC8XUqlfTRliSdLjN
3NbFOCAT80qJprrVxFj6I2SrGBq74Nh00qLlLGGWnJqPLeSxmiU5xeeTxIo7ombD
F3LbDs0uUIaUVS2vdSBvejhcF/NkfJY66rM0EtfLpIg4uA8rFyGrorVg2EJZbh+v
AT8NZYeYDw036kAGDeZSj62qZP2yshdqs9E8NmOKhZRoNJiFP0z0tZUrjNPQqAGq
14i7CJm1XoJh1CrVefvfvi2ZfDKOxHnq+y2ciMSfxj29zEEsvoY/rnwLk1sKpzoQ
XZpEEAS9G3wL+q6/tdy7lOdmD7BXKrjICEfDYNvFzMlmbwjNk5O7rsTDc03YAARq
DKGconGmsoc5/ivxDggXPU6XISxuhkhwwsN3eyVKazL5eXqia4w=
=+ZB0
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--
