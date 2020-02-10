Return-Path: <cygwin-patches-return-10061-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 75894 invoked by alias); 10 Feb 2020 15:07:46 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 75884 invoked by uid 89); 10 Feb 2020 15:07:46 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-119.5 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.17.10) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 10 Feb 2020 15:07:45 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MBDvU-1jDnhT0Ue6-00Ceam for <cygwin-patches@cygwin.com>; Mon, 10 Feb 2020 16:07:41 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id D19CEA80CFA; Mon, 10 Feb 2020 16:07:39 +0100 (CET)
Date: Mon, 10 Feb 2020 15:07:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Prevent potential errno overwriting.
Message-ID: <20200210150739.GE4442@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200210114245.1272-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="9l24NVCWtSuIVIod"
Content-Disposition: inline
In-Reply-To: <20200210114245.1272-1-takashi.yano@nifty.ne.jp>
X-SW-Source: 2020-q1/txt/msg00167.txt


--9l24NVCWtSuIVIod
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1223

On Feb 10 20:42, Takashi Yano wrote:
> - In push_to_pcon_screenbuffer(), open() and ioctl() are called.
>   Since push_to_pcon_screenbuffer() is called in read() and write(),
>   errno which is set in read() and write() code may be overwritten
>   in open() or ioctl() call. This patch prevent this situation.
> ---
>  winsup/cygwin/fhandler_tty.cc | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
> index 260776a56..cfd4b1c44 100644
> --- a/winsup/cygwin/fhandler_tty.cc
> +++ b/winsup/cygwin/fhandler_tty.cc
> @@ -1412,10 +1412,13 @@ fhandler_pty_slave::push_to_pcon_screenbuffer (co=
nst char *ptr, size_t len,
>    while (!GetConsoleMode (get_output_handle (), &dwMode))
>      {
>        termios_printf ("GetConsoleMode failed, %E");
> +      int errno_save =3D errno;
>        /* Re-open handles */
>        this->open (0, 0);
>        /* Fix pseudo console window size */
>        this->ioctl (TIOCSWINSZ, &get_ttyp ()->winsize);
> +      if (errno !=3D errno_save)
> +	set_errno (errno_save);
>        if (++retry_count > 3)
>  	goto cleanup;
>      }
> --=20
> 2.21.0


Pushed.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--9l24NVCWtSuIVIod
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl5BcbsACgkQ9TYGna5E
T6CAog/+Pr0zceq6YB77UEWlIlXUXx8iclLKrYRiuAQ49+FUrChMU/5ikQS9ehMS
VWfGQJ9kCGxaY/DR38T9+lE8ux84hrg3Lu3LHd173x1EgfVfaVPQHvlzUUCumkGP
Vym4DhpDVTu94/iKVCrtgrLo4sU27YSvhzGMI4s09Rk9yMWwAm9ZN9jylCH5CpEN
oFqSSdZuo2zoRKywBK9/ol84Rmft/1Z0B3BfoESDSDHZ/7N2Uo3twp7qxB949vM2
M9i0g2Kcexz/lqqpEfXZdL34c25St9qZcDJ7zvISUIm4eNuvLEIU86v5fxx6iYk6
LqYmnyb3lQulrVFWSiIG6dRReggiInhnfjv2cAQc1BTzAlEGh98rLps5+NSAHk/z
baJZau2xJAZOO69A3+pLs3WdWspGjRP78ctXrKiy+mXK0t+WbF/qfa9NfQ5+8f8X
O5XrNRJZBoyNUGshQJrSjeUwi3zU6H0mh+K+R4at+AVQVqTKwwTSz50HOzBp1OWO
PSsof1LlZcqC/UpzyXzChBVhLSeRiv8sS9aGlsCiqdxAcQTI2wqWQI6tOajuePDb
qf7KJrnVgY2H6iSKLJeibrrpguPSlLJiCdWKM1qhUK/Q9gwfpIu7rnAn0HC469ib
uUbLYNmA3PFh0QpU9+sAZOqdAbut2Hj0rmzkWKSjbZJmwUCuGu4=
=mapt
-----END PGP SIGNATURE-----

--9l24NVCWtSuIVIod--
