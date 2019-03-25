Return-Path: <cygwin-patches-return-9231-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 126427 invoked by alias); 25 Mar 2019 10:27:11 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 126349 invoked by uid 89); 25 Mar 2019 10:27:10 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-103.6 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=HX-Languages-Length:744, dec, Dec, H*F:D*cygwin.com
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.134) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 25 Mar 2019 10:27:08 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MKKdD-1hPkXx3nNH-00LjE7; Mon, 25 Mar 2019 11:27:02 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 933D9A807AE; Mon, 25 Mar 2019 11:27:01 +0100 (CET)
Date: Mon, 25 Mar 2019 10:27:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Brian Inglis <Brian.Inglis@systematicsw.ab.ca>
Cc: Cygwin Patches <cygwin-patches@cygwin.com>
Subject: Re: [PATCH 0/2] default ps -W process start time to boot time when unavailable
Message-ID: <20190325102701.GG3471@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Brian Inglis <Brian.Inglis@systematicsw.ab.ca>,	Cygwin Patches <cygwin-patches@cygwin.com>
References: <20190324022239.48618-1-Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="yQbNiKLmgenwUfTN"
Content-Disposition: inline
In-Reply-To: <20190324022239.48618-1-Brian.Inglis@SystematicSW.ab.ca>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q1/txt/msg00041.txt.bz2


--yQbNiKLmgenwUfTN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 688

On Mar 23 20:22, Brian Inglis wrote:
> non-elevated users can not access system startup process start times,
> defaulting to time_t 0, displaying as Dec 31/Jan 1 depending on time zone,
> so instead use system boot time, which is within seconds of correct,
> to avoid WMI overhead getting correct system startup process start time
>=20
> Brian Inglis (2):
>   default ps -W process start time to system boot time when inaccessible,=
 0, -1
>   get and convert boot time once and use as needed
>=20
>  winsup/utils/ps.cc | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
>=20
> --=20
> 2.17.0

Pushed.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--yQbNiKLmgenwUfTN
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlyYrPUACgkQ9TYGna5E
T6AXdQ/9FuwMUcMHD3smWvUoylKSA5PdTtSHrJ9zJ+ssK+guEwRHdoiP2v3T1ybk
SpEDMMpZ/AzOjGzoQgK8HkeZ/cdZHcljbznsZ6TSK/UeSHNETbK1MlsF/7GRU/wY
h8+aTkRuoTwJhe217n8tsrYSFNAj1o66WR4mc20oXfHQ5PKQzUAjrLRl55pkcEDY
a5AAPAxmeVqMNdrm6ESAVk8EC5gIFa+LePp+Lxxpn8PnGCb4dzfNnXWgLbLttFgb
seNi4otOcONRN58RppOp4B+6+9t/9dS1fV2hvCXBjIxoNXdCcvxV/WJoATz6a6/N
ollV4ujtaX3uHmkEHmjc8xLd6FatxM0CsjbY85sxYPtr/kFTOGGRzXFcbeLqJaVm
3n0k6XSuootue358+nuymiQlkwyalzYL0dw9iH2xeb+bwr1fyEJP8jlJTzFl3Kq3
LzRtRa0YoCs+UGxh9eZUzhcyGZZ3VnHuhp4K1Q1in4NPl65FT72fBt5VGuYQ9yhL
77FBY2vIsFVszlgJF+h0LWERH9F1qlPR0uppByIRljNb5ZCBWRffd6Umkc/NzzqR
6j1pZIC0iQ+EfFFbcMmnXK8ozLVt3sL8Ck4RA752oSr48HEaaUkAicy6JvuQ0Reh
iYEHWy/7+5OTmEjm/wLTLQnqp0lKaY5nte8fPigfUO4NOFBj0LE=
=499+
-----END PGP SIGNATURE-----

--yQbNiKLmgenwUfTN--
