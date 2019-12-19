Return-Path: <cygwin-patches-return-9870-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 86720 invoked by alias); 19 Dec 2019 11:29:28 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 86704 invoked by uid 89); 19 Dec 2019 11:29:28 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-116.9 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (217.72.192.74) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 19 Dec 2019 11:29:27 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id 1Mw8cU-1hsGqO3hsS-00s3G8 for <cygwin-patches@cygwin.com>; Thu, 19 Dec 2019 12:29:24 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 5E3D1A8065A; Thu, 19 Dec 2019 12:29:24 +0100 (CET)
Date: Thu, 19 Dec 2019 11:29:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Fix ESC[?3h and ESC[?3l handling again.
Message-ID: <20191219112924.GT10310@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20191219110330.1902-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="K/+MhuhYzqQJJ3Xj"
Content-Disposition: inline
In-Reply-To: <20191219110330.1902-1-takashi.yano@nifty.ne.jp>
X-SW-Source: 2019-q4/txt/msg00141.txt.bz2


--K/+MhuhYzqQJJ3Xj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 974

On Dec 19 20:03, Takashi Yano wrote:
> - Even with commit fe512b2b12a2cea8393d14f038dc3914b1bf3f60, pty
>   still has a problem in ESC[?3h and ESC[?3l handling if invalid
>   sequence such as ESC[?$ is sent. This patch fixes the issue.
> ---
>  winsup/cygwin/fhandler_tty.cc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
> index 8c3a6e72e..f10f0fc61 100644
> --- a/winsup/cygwin/fhandler_tty.cc
> +++ b/winsup/cygwin/fhandler_tty.cc
> @@ -1263,7 +1263,7 @@ fhandler_pty_slave::push_to_pcon_screenbuffer (cons=
t char *ptr, size_t len)
>      {
>        p0 +=3D 3;
>        bool exist_arg_3 =3D false;
> -      while (p0 < buf + nlen && !isalpha (*p0))
> +      while (p0 < buf + nlen && (isdigit (*p0) || *p0 =3D=3D ';'))
>  	{
>  	  int arg =3D 0;
>  	  while (p0 < buf + nlen && isdigit (*p0))
> --=20
> 2.21.0

Pushed.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--K/+MhuhYzqQJJ3Xj
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl37XxQACgkQ9TYGna5E
T6C5Dw//ZBit71uY+Mk8WZ9bFL3wbb7TRAgJY0hVgTf/uMlRLqLbMDgTxUAGtNHl
7T91nLoir0u8WxsZcr2q9dl7/sYRKu49sznbHjh1kGmQt34kaWSHi+6nB2PGub5d
iKyyrc9KgXiw5kaE99tcxZC4MzzBrqtspYDfKeAQQuWdN1be6b4ehVPGz9quVtEI
SoSBr7CVtS+hoMMkJibBNpWaxz9ARZ2wYEJpwKdyOiDVzlvsANdUdizThT1Nn3h6
9JViY3I6HvWoXnZPjfvPErQa2paW35vDmqptS/Ow8pSRVQoMjTr7zKvytnkVedlS
S9gFc/YqtkvIRqx1JKOKrYTCk1OKWcqGPA2QwBfPuxcVxpjvqWIHX6W787K4iMmu
O4aZvdk9ZtfNH8PMzOEcdEAzo76ScHFePlYIqYnniI1u+8nK6OhlodGtBOBYhHT8
R027mriKwZCZmLGkALLOK7PMacMAXp22lhwnse14tLQ7e6K2Zei2B1U2pt6S1PeF
f/sYfiJhtGahdgfzWkhbCdU4enY8VwztMbueBArdMISqOE6EnQJcKm37cqGt6eeB
t7Z7NIZjR90adbMW1F50IdWrGxb21KoYm6uqs8PhPkfj4r2lPLZCaxYG4jQ8KB01
UcB0FjtL2sdBdaHAxYZka6G5EtlwoNzxigRsafmQZp9XQP+Ah+A=
=amAr
-----END PGP SIGNATURE-----

--K/+MhuhYzqQJJ3Xj--
