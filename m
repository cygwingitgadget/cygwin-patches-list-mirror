Return-Path: <cygwin-patches-return-8877-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2775 invoked by alias); 10 Oct 2017 11:48:57 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 2763 invoked by uid 89); 10 Oct 2017 11:48:56 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-124.4 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=H*R:D*cygwin.com, H*Ad:U*cygwin-patches, HTo:U*cygwin-patches, H*c:application
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 10 Oct 2017 11:48:55 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id 37866721BBD15	for <cygwin-patches@cygwin.com>; Tue, 10 Oct 2017 13:48:52 +0200 (CEST)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id A66545E039E	for <cygwin-patches@cygwin.com>; Tue, 10 Oct 2017 13:48:51 +0200 (CEST)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id A4E93A80C9D; Tue, 10 Oct 2017 13:48:51 +0200 (CEST)
Date: Tue, 10 Oct 2017 11:48:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] cygwin: fix potential buffer overflow in small_sprintf
Message-ID: <20171010114851.GC30630@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <499683af-b4f7-a50a-829b-514259c39cc5@ssi-schaefer.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="QRj9sO5tAVLaXnSD"
Content-Disposition: inline
In-Reply-To: <499683af-b4f7-a50a-829b-514259c39cc5@ssi-schaefer.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-SW-Source: 2017-q4/txt/msg00007.txt.bz2


--QRj9sO5tAVLaXnSD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1158

On Oct  9 18:57, Michael Haubenwallner wrote:
> With "%C" format string, argument may convert in up to MB_LEN_MAX bytes.
> Relying on sys_wcstombs to add a trailing zero here requires us to
> provide a large enough buffer.
>=20
> * smallprint.c (__small_vsprintf): Use MB_LEN_MAX+1 bufsize for "%C".
> ---
>  winsup/cygwin/smallprint.cc | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/winsup/cygwin/smallprint.cc b/winsup/cygwin/smallprint.cc
> index 3cec31cce..8553f7002 100644
> --- a/winsup/cygwin/smallprint.cc
> +++ b/winsup/cygwin/smallprint.cc
> @@ -193,8 +193,8 @@ __small_vsprintf (char *dst, const char *fmt, va_list=
 ap)
>  		case 'C':
>  		  {
>  		    WCHAR wc =3D (WCHAR) va_arg (ap, int);
> -		    char buf[4], *c;
> -		    sys_wcstombs (buf, 4, &wc, 1);
> +		    char buf[MB_LEN_MAX+1] =3D "", *c;
> +		    sys_wcstombs (buf, MB_LEN_MAX+1, &wc, 1);
>  		    for (c =3D buf; *c; ++c)
>  		      *dst++ =3D *c;
>  		  }
> --=20
> 2.14.2

Pushed.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--QRj9sO5tAVLaXnSD
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZ3LOjAAoJEPU2Bp2uRE+gGZwP/0nq2J41fxeLyWdygLChJnGa
j2c3KlZ6v53a6m7NgC1aUNIHYhq2s9PXSod/diRmAyDHA5GhdSpewv+frgRHqgji
YFwscjujpWQV2Mo3AJOCUTB2GcJ79IpyiDFrgJDBl5WUv/ikkARxwwfGB6DiuIo5
P7CmcsFPsYb85/lub36++1C5vaDSZFGKymqHfzbdCYaSkp38ukvKk7JycjUfVMyo
yLzY+NHe3DbySzK6oacTBAkOnV4e+PT0GQv6VOo26tgadOG9F6ijlt5gpf2fz7Eb
0UFNtXtfaG89xDZBMIp/JqJW20XtsKOx6/U1EkMr3cU8IWu/HmAzv48+Rfj6Yafi
aShgb9DlzH64izgYW7q6yGu6ol0pmool5qPYDVQ9mq9a6ZfiniPEV6VzkOK4waxa
g/5YNnat7+N/ST9xhj9Tr+OQ7szJGwS4kMixzlmTiRuG46HdTqzzYDUXr8w84Bzo
qMrFrhRPyR/Qg13/cd3igI0hasEjMuqKmXab23fEijROD1EDxS8eGowrW8x1+thB
vzGt/2klJyzsrprgAFVhaveJKpk1Yijx4hSbShGOVJW+othfjXg4t+3LEounlvSp
vuDLzGbDFJtbVTrxkZ1fVzX3m8MOSCd9pSzmlxIAvKYdzZVR3KrRvfREJXegsQcg
Y4PZcY+GxN68T4f4cC9Z
=/d5u
-----END PGP SIGNATURE-----

--QRj9sO5tAVLaXnSD--
