Return-Path: <cygwin-patches-return-9815-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 79003 invoked by alias); 8 Nov 2019 09:25:03 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 78991 invoked by uid 89); 8 Nov 2019 09:25:03 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-117.0 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,KAM_NUMSUBJECT,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=Geisert, geisert, H*F:D*cygwin.com
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.187) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 08 Nov 2019 09:25:02 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MMG6Y-1iAvOf1ZFW-00JJcu for <cygwin-patches@cygwin.com>; Fri, 08 Nov 2019 10:24:59 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id E4B58A8065B; Fri,  8 Nov 2019 10:24:58 +0100 (CET)
Date: Fri, 08 Nov 2019 09:25:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Raise dumpstack frame limit to 32
Message-ID: <20191108092458.GZ3372@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20191108001334.2878-1-mark@maxrnd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="nLMor0SRtNCuLS/8"
Content-Disposition: inline
In-Reply-To: <20191108001334.2878-1-mark@maxrnd.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SW-Source: 2019-q4/txt/msg00086.txt.bz2


--nLMor0SRtNCuLS/8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1440

On Nov  7 16:13, Mark Geisert wrote:
> Create a #define for the limit and raise it from 16 to 32.
> ---
>  winsup/cygwin/exceptions.cc | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/winsup/cygwin/exceptions.cc b/winsup/cygwin/exceptions.cc
> index 132fea427..3e7d7275c 100644
> --- a/winsup/cygwin/exceptions.cc
> +++ b/winsup/cygwin/exceptions.cc
> @@ -42,6 +42,7 @@ details. */
>=20=20
>  #define CALL_HANDLER_RETRY_OUTER 10
>  #define CALL_HANDLER_RETRY_INNER 10
> +#define DUMPSTACK_FRAME_LIMIT    32
>=20=20
>  PWCHAR debugger_command;
>  extern uint8_t _sigbe;
> @@ -382,7 +383,7 @@ cygwin_exception::dumpstack ()
>  #else
>        small_printf ("Stack trace:\r\nFrame     Function  Args\r\n");
>  #endif
> -      for (i =3D 0; i < 16 && thestack++; i++)
> +      for (i =3D 0; i < DUMPSTACK_FRAME_LIMIT && thestack++; i++)
>  	{
>  	  small_printf (_AFMT "  " _AFMT, thestack.sf.AddrFrame.Offset,
>  			thestack.sf.AddrPC.Offset);
> @@ -392,7 +393,8 @@ cygwin_exception::dumpstack ()
>  	  small_printf (")\r\n");
>  	}
>        small_printf ("End of stack trace%s\n",
> -		    i =3D=3D 16 ? " (more stack frames may be present)" : "");
> +		    i =3D=3D DUMPSTACK_FRAME_LIMIT ?
> +		        " (more stack frames may be present)" : "");
>        if (h)
>  	NtClose (h);
>      }
> --=20
> 2.21.0

Pushed, including the release msg patch.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--nLMor0SRtNCuLS/8
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl3FNGoACgkQ9TYGna5E
T6CtfhAAkMF+4WL/IxqxERIVhteSJY14jrmM18XpLLFC3rFUBYNoBxWWQ5EuMj6Y
dAG52qbr2PuxmsBUei3vaTxPNFb/4Jz8HuPHZMGN3ormTqq+cuOklgp8JlkOZuS3
Gyc18O0hp3JDtgLw6O7gsM/03jEKGNchnMLZ/hH1SHd9Z2RM8rLbfN20WlQmKC1i
EaDV/6fsvU3H494gWatdmnbpJFyhJ+7LNB3H77Pu9ajUmPIx1EQXDpTMjQLyWBFc
46ipysf6wifF/7cmfqafzs+qC/fkYNXgVsLi6IIy/Rb7dbbPXR9NEb0IrdeezhVU
luQCRBWpFomqToP4fFS1q1fqXgHfz4seZyzC/VlPaPuACpxiGTTxoQNBIlztwSG0
FSFsXMIt84coQQt7jYF/CwsG1cHihzvpPpHEvQmV5Ytvo93oNm5yyP5I3zDYHm2N
jQcK06LE5LD27rdDyR+TXCsl/Vl/jpXdzgctGOhHaEML8Z43J2u4CaZ7F9XNPEWK
dC66HiEkzuMzygiN553LSmFI4X9/yOWUEd/rJ0lMxMEGWWierJvbbxhuRYV/Jdcg
GAP+Mw1UMEC4dMjiCVElPko6gyvqjDZODBhUkRPYrs1hHUc68NLYiVgcDc3PA1Gz
Vk2FQrb05RBgKBR1ivDXmfUkUwGOv3Pdp+NBUveOyOeIHlqreA4=
=8EZl
-----END PGP SIGNATURE-----

--nLMor0SRtNCuLS/8--
