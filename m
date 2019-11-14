Return-Path: <cygwin-patches-return-9849-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6353 invoked by alias); 14 Nov 2019 09:35:46 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 6344 invoked by uid 89); 14 Nov 2019 09:35:46 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-116.9 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=honored, screen
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.131) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 14 Nov 2019 09:35:44 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id 1N4A1h-1hn9SO3iwz-01022G for <cygwin-patches@cygwin.com>; Thu, 14 Nov 2019 10:35:41 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 2E5A2A80A39; Thu, 14 Nov 2019 10:35:41 +0100 (CET)
Date: Thu, 14 Nov 2019 09:35:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Trigger redraw screen if ESC[?3h or ESC[?3l is sent.
Message-ID: <20191114093541.GS3372@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20191113104929.748-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="lLbDBsvWahy0xqFJ"
Content-Disposition: inline
In-Reply-To: <20191113104929.748-1-takashi.yano@nifty.ne.jp>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SW-Source: 2019-q4/txt/msg00120.txt.bz2


--lLbDBsvWahy0xqFJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2392

Hi Takashi,

On Nov 13 19:49, Takashi Yano wrote:
> - Pseudo console clears console screen buffer if ESC[?3h or ESC[?3l
>   is sent. However, xterm/vt100 does not clear screen. This cause

This is only correct if xterm hasn't been started with the c132 widget
resource set to 'true'.  This resource specifies whether the ESC[?3h
and ESC[?3l ESC sequences are honored or not.  The default is 'false'.

However, if you specify the c132 resource, or if you start xterm
with the commandline option -132, it will resize when these sequences
are sent.  And here's the joke: The resize also clears the screen
in xterm.

My question now is, does this change anything in terms of the below
code, or is it still valid as is?


Thanks,
Corinna


>   mismatch between real screen and console screen buffer. Therefore,
>   this patch triggers redraw screen in that situation so that the
>   synchronization is done on the next execution of native app.
>   This solves the problem reported in:
>   https://www.cygwin.com/ml/cygwin-patches/2019-q4/msg00116.html
> ---
>  winsup/cygwin/fhandler_tty.cc | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>=20
> diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
> index e02a8f43b..f9c7c3ade 100644
> --- a/winsup/cygwin/fhandler_tty.cc
> +++ b/winsup/cygwin/fhandler_tty.cc
> @@ -1255,6 +1255,28 @@ fhandler_pty_slave::push_to_pcon_screenbuffer (con=
st char *ptr, size_t len)
>        memmove (p0, p0+4, nlen - (p0+4 - buf));
>        nlen -=3D 4;
>      }
> +
> +  /* If the ESC sequence ESC[?3h or ESC[?3l which clears console screen
> +     buffer is pushed, set need_redraw_screen to trigger redraw screen. =
*/
> +  p0 =3D buf;
> +  while ((p0 =3D (char *) memmem (p0, nlen - (p0 - buf), "\033[?", 3)))
> +    {
> +      p0 +=3D 3;
> +      while (p0 < buf + nlen && *p0 !=3D 'h' && *p0 !=3D 'l')
> +	{
> +	  int arg =3D 0;
> +	  while (p0 < buf + nlen && isdigit (*p0))
> +	    arg =3D arg * 10 + (*p0 ++) - '0';
> +	  if (arg =3D=3D 3)
> +	    get_ttyp ()->need_redraw_screen =3D true;
> +	  if (p0 < buf + nlen && *p0 =3D=3D ';')
> +	    p0 ++;
> +	}
> +      p0 ++;
> +      if (p0 >=3D buf + nlen)
> +	break;
> +    }
> +
>    DWORD dwMode, flags;
>    flags =3D ENABLE_VIRTUAL_TERMINAL_PROCESSING;
>    GetConsoleMode (get_output_handle (), &dwMode);
> --=20
> 2.21.0

--=20
Corinna Vinschen
Cygwin Maintainer

--lLbDBsvWahy0xqFJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl3NH+0ACgkQ9TYGna5E
T6DwWA//fAVMsjOU4t8JffBkX8DOtqIF7wLwrD3efzV1gRNsD0PCNC5W7Ol2Mxb/
+7Ps/6jeiCLSGmHVc7WvOmuMGSabGEVCTPH/jSdqTjeMeeVUgej4Zx4elTQn/MTa
CZUlM20rijL/Q/3FqSiMuu9qQ9Z56Ri4/xsJ++580IUQcLUG0yz932bwc/qdN9gn
3KAqumh+5GgiCdx8413dYOZC7Wnt/GY+qYeEsZu54FhFwHFn/gPtBzqzQAsTmzrj
84f7EV07j6csMcrhPQMt38YmyxoPdLohn7lQ0uHyLADnPB+lZMe69sTCPeFGniyi
v4/e8Vc11RnDv5pUab/5JsopbOxTmUFMzpFRZPf7PWC72wWSZ0UH0sY0Wo/BHTZB
A61d/o7ykdolGjdw6gz7TutyhGtbAGL+BYOBuffOHdN0XPeVZaWUQo9v2EW8c7M4
VoO6fiXTj6tslWS3OsY/lleLJ7qyf8sJor1+ylN3DHePogeb9/ThVvEhYT7c0fVZ
mM5gPtSqM/7NVNj/RoWppmJwVhGsOrKb2cft1odrUnYQl1ndUnDe5vwA5LMoIpxJ
cTtqNiWWJrc3d2zSoPyi6MvVVFrWlLlb6r+yg7wMPwVQ6t8eQ871Epc0JpGN6Ssn
dvQqL0LhRLsJZJ2BqMRFJOXhuBh9lueNvD/qfuv86zxwaaqTcmQ=
=fV4n
-----END PGP SIGNATURE-----

--lLbDBsvWahy0xqFJ--
