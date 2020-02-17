Return-Path: <cygwin-patches-return-10078-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 107155 invoked by alias); 17 Feb 2020 12:59:10 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 107143 invoked by uid 89); 17 Feb 2020 12:59:10 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-119.1 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.187) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 17 Feb 2020 12:59:09 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MIdW9-1jIIaF3LnR-00EgAw for <cygwin-patches@cygwin.com>; Mon, 17 Feb 2020 13:59:06 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 430CEA80666; Mon, 17 Feb 2020 13:59:06 +0100 (CET)
Date: Mon, 17 Feb 2020 12:59:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: console: Fix code for restoring console mode.
Message-ID: <20200217125906.GF4092@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200217124627.1639-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="cPi+lWm09sJ+d57q"
Content-Disposition: inline
In-Reply-To: <20200217124627.1639-1-takashi.yano@nifty.ne.jp>
X-SW-Source: 2020-q1/txt/msg00184.txt


--cPi+lWm09sJ+d57q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1030

On Feb 17 21:46, Takashi Yano wrote:
> - Commit 774b8996d1f3e535e8267be4eb8e751d756c2cec has a bug that
>   restores console output mode into console input. This patch fixes
>   the issue.
> ---
>  winsup/cygwin/fhandler_console.cc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_c=
onsole.cc
> index 2afb5c529..9bfee64d3 100644
> --- a/winsup/cygwin/fhandler_console.cc
> +++ b/winsup/cygwin/fhandler_console.cc
> @@ -1122,7 +1122,7 @@ fhandler_console::close ()
>  			  &obi, sizeof obi, NULL);
>    if (NT_SUCCESS (status) && obi.HandleCount =3D=3D 1)
>      if (orig_conout_mode !=3D (DWORD) -1)
> -      SetConsoleMode (get_handle (), orig_conout_mode);
> +      SetConsoleMode (get_output_handle (), orig_conout_mode);
>=20=20
>    release_output_mutex ();
>=20=20
> --=20
> 2.21.0

I pushed this now, but I let it simmering for a bit.  I'll create the
3.1.4 release tomorrow.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--cPi+lWm09sJ+d57q
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl5KjhoACgkQ9TYGna5E
T6C+JhAAkyuqOpYOSx2tP3yXtnG5oPamjOpdrO4Ifza3Qrg1T2eaFyxAMwt/D65c
KTnNypobBhRSnp8KtRaezr4MC8oBN5Ci8ouvxCUIuMZ0q7jsqPWHtFJHpxt7qs3+
x/1LxI7ZmFz5alqZAjaRLqTr3WPqQi+1a1CBt5W94fqNICn2JTCAuglO7mbp+55U
ZkZj3oMytx14kuhAHnsHohQsEN/1KnfMiFhCcQyKiYN+nHOuBw0YHPCloQvCyN/8
f9jCwMWSGprKdFVdMQokeGHqmrb809TLj3ql9haBmUe7tnCUbYstt3rA0409T3ie
nzMzJ2b0gsI6TkHcEFlDUeXBgxzI1SiXV+xdZ6PPLEH0PyfsnizYZlMHyMWOBKft
5CEkq0jr5LPPDcgO6QMVTG1bjz0N2qHhuse85h58DeLg6OD+qSsrHC5no+2SlgKj
JFtqSF1zh8I6G3jQMry+IrGSS0q1xh6rjMZoIPpZeJN5STWzHLQziHG8qvMifvPD
d9lDTqq5jgCAnwWsLICtIMQKhEFuR6JdFwfATqdVZNRMzAQ1UF1EH0exHWG+f9FY
OFAlhGzwPp/ZV4+IV+d3K2oaJpNFSxZlsuzumWH0Sk12pnL4EQ7mr4SSM8w2fg1B
DH9wz9IlUPjBwxaWcqccCDQnKMfn7ml/tn+aCWEgFHjss1PAXDg=
=/l/h
-----END PGP SIGNATURE-----

--cPi+lWm09sJ+d57q--
