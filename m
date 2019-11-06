Return-Path: <cygwin-patches-return-9803-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26159 invoked by alias); 6 Nov 2019 14:05:53 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 26067 invoked by uid 89); 6 Nov 2019 14:05:52 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-103.9 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*F:D*cygwin.com
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (217.72.192.75) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 06 Nov 2019 14:05:51 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MJW5G-1iCtUK2ca8-00Jswi for <cygwin-patches@cygwin.com>; Wed, 06 Nov 2019 15:05:48 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id DB8B3A80A67; Wed,  6 Nov 2019 15:05:47 +0100 (CET)
Date: Wed, 06 Nov 2019 14:05:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: console, pty: Prevent error in legacy console mode.
Message-ID: <20191106140547.GU3372@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20191106115909.429-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="6CXocAQn8Xbegyxo"
Content-Disposition: inline
In-Reply-To: <20191106115909.429-1-takashi.yano@nifty.ne.jp>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SW-Source: 2019-q4/txt/msg00074.txt.bz2


--6CXocAQn8Xbegyxo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 852

Hi Takashi,

the patch is fine in general.  Still, what I really like to see is a
descriptive log message, as well as a matching comment...

On Nov  6 20:59, Takashi Yano wrote:
> @@ -3131,6 +3134,16 @@ fhandler_pty_master::setup_pseudoconsole ()
>        if (res !=3D S_OK)
>  	system_printf ("CreatePseudoConsole() failed. %08x\n",
>  		       GetLastError ());
> +      error =3D true;
> +    }
> +

...here, to explain briefly why this check is done.

> +  reg_key reg (HKEY_CURRENT_USER, KEY_READ, L"Console", NULL);
> +  if (reg.error ())
> +    error =3D true;
> +  if (reg.get_dword (L"ForceV2", 1) =3D=3D 0)
> +    error =3D true;
> +  if (error)
> +    {
>        CloseHandle (from_master);
>        CloseHandle (to_slave);
>        from_master =3D from_master_cyg;
> --=20
> 2.21.0

Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--6CXocAQn8Xbegyxo
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl3C0zsACgkQ9TYGna5E
T6Aq6g/+LLf568VL3dQv4nbbIax7xBkujypF34rsAtBW6Bh3/2uFxu8NRQfFx/qZ
gHyXL5inLcmuLxG5pxatvB9MHlVna7CoKT13z+EHyNlbBc0P7qNBKFNuzsjcjnW6
tHO/Cwh06qku/6xEA9lU0l051t8vc+Myot368EdL/s8dfRHq69txZxLzoNbRbsbK
ARO0Iel8jqk4j30Q1lwSj8QUVbbMKNVgL8m/G2j+O/yvMN/NaP30oVqfsF4Argw1
IZuys65HAfCbo6g2e9B0ZHfLISRA3uci7poKSXV7VgmmAZl2yPKRNhfvFfgX/5tr
GCCDvIF+Z8ug48QlLyPHRQe5eAlu4tlOsxrj9PmVvPXJU6iZTz8t5dM/N76qwBe5
Q+CQDj1qfcEhzQX0pUB8K8YwH+Q9AmJoxqOcMs1StA5ffJoIVwz5hliw1VfBpCWx
EZSpjKWkMFRlLPMu0T13JZ/84SzuE2NGZYTNrQQpS2tz5XrbxtqdqMgRb+jN4aYE
DAAFTpsPTRI25MRhbCf8esXjDF0KtE/lOumuetJGpFTzK0f5YpyxrGYAUhDOPmEp
CJWL09bQmrByOnUyXe+EYof8jkIPe1wohkCiQxRkb9Yoyvl8e007hcA6+bbBae9A
5TEaGCuKJwU0vQMCxjZOAOSaSkZYUOk00DbSJGXgGxp0fjiW/so=
=jS+2
-----END PGP SIGNATURE-----

--6CXocAQn8Xbegyxo--
