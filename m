Return-Path: <cygwin-patches-return-10143-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 99788 invoked by alias); 28 Feb 2020 14:49:09 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 99779 invoked by uid 89); 28 Feb 2020 14:49:09 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-118.9 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=HX-Languages-Length:1807
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.130) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 28 Feb 2020 14:49:08 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id 1McpaE-1jhZzv2XKs-00a05I; Fri, 28 Feb 2020 15:49:05 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 493EEA82778; Fri, 28 Feb 2020 15:49:05 +0100 (CET)
Date: Fri, 28 Feb 2020 14:49:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Cc: Hans-Bernhard =?utf-8?Q?Br=C3=B6ker?= <HBBroeker@t-online.de>
Subject: Re: [PATCH v2 1/4] Cygwin: console: Add workaround for broken IL/DL in xterm mode.
Message-ID: <20200228144905.GK4045@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com,	Hans-Bernhard =?utf-8?Q?Br=C3=B6ker?= <HBBroeker@t-online.de>
References: <20200226153302.584-1-takashi.yano@nifty.ne.jp> <20200226153302.584-2-takashi.yano@nifty.ne.jp> <05cca441-eb83-4600-90f3-bf82ec7a0190@dronecode.org.uk> <20200228111409.149929dcf710cabf99a879b3@nifty.ne.jp> <20200228133122.GG4045@calimero.vinschen.de> <20200228144459.GI4045@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="buDNgeHiu+HCsDEc"
Content-Disposition: inline
In-Reply-To: <20200228144459.GI4045@calimero.vinschen.de>
X-SW-Source: 2020-q1/txt/msg00249.txt


--buDNgeHiu+HCsDEc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1790

On Feb 28 15:44, Corinna Vinschen wrote:
> On Feb 28 14:31, Corinna Vinschen wrote:
> > [CC Hans]
> >=20
> > On Feb 28 11:14, Takashi Yano wrote:
> > > On Thu, 27 Feb 2020 18:03:47 +0000
> > > Jon Turney wrote:
> > > > > +#define wpbuf_put(x) \
> > > > > +  wpbuf[wpixput++] =3D x; \
> > > > > +  if (wpixput > WPBUF_LEN) \
> > > > > +    wpixput--;
> > > > > +
> > > >=20
> > > > So I think either the macro need it contents contained by a 'do { .=
.. }=20
> > > > while(0)',  or that instance of it needs to be surrounded by braces=
, to=20
> > > > do what you intend.
> > >=20
> > > Thanks for the advice. Fortunately, "if" statement does not
> > > cause a problem even if it is accidentally executed outside
> > > "else" block in this case.
> > >=20
> > > Hans,
> > > as for making a patch for this issue, may I leave it to you
> > > because you are already working on it?=20
> > >=20
> > > --=20
> > > Takashi Yano <takashi.yano@nifty.ne.jp>
>=20
> What about an inline function instead?
>=20
> diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_c=
onsole.cc
> index 64e12b8320a1..6c3e33818aca 100644
> --- a/winsup/cygwin/fhandler_console.cc
> +++ b/winsup/cygwin/fhandler_console.cc
> @@ -63,10 +63,14 @@ static struct fhandler_base::rabuf_t con_ra;
>  static unsigned char wpbuf[WPBUF_LEN];
>  static int wpixput;
>  static unsigned char last_char;
> -#define wpbuf_put(x) \
> -  wpbuf[wpixput++] =3D x; \
> -  if (wpixput > WPBUF_LEN) \
> +
> +static inline void
> +wpbuf_put (unsigned char x)
> +{
> +  wpbuf[wpixput++] =3D x;
> +  if (wpixput > WPBUF_LEN)
>      wpixput--;
> +}

Also, on second thought, given wpbuf is global inside this file, doesn't
this require guarding against multi-threaded access?


Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--buDNgeHiu+HCsDEc
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl5ZKGEACgkQ9TYGna5E
T6AEsg/9G/F/500VxaMp38Q9fIFj8ayhArl9rfIZZtrLsVS65XjCPuSmdNA1DoxH
OyIBlydGUF2hem5R1hP6lQm1Fw82WufjR7o781Ouv5w5eFX963pMm9A/U+Qgsk6I
np7WvIv0gbyU40hFIxYTD2oSErb6xgAl+fbSNaUpYiPbapPsQLUagLbSnd64ZXoh
GyoJdvpep9vz39NLG6CiKPOBTzRfa8rQLCmEF2ic/xZP9y6OwmuROTISNsHUIa7Q
OQPDIt33y7IHIsIx2HeS18ivoCWKT1OpYm60ayNvWQP9C3CD07D531g4b3dqasXM
fSEaw6Jx5+jSCdK3X4MF5WRA3vD3xJh7k4TzSG9jX1TFWZ8kRssQWQjbfTEdW1A9
7qIpA57DQr6B/oSEvk2Ep9SqVWVzULK7UEX/juMRYzwrmOdGADfr08mCTq2U3QIB
JXzFKscnCfngM7IfvaFJywZD6/USJuQNoyGAV9F7hd8joRXKgTxWbedHpvCOLYfH
DO13uQfCjLYhOMXCilg+Vbj7rsSihjwyq7XCVpUkrw1HdV6MZs6Tozf3zzDb/UlL
54bRFjZS7pqSrkPrtQOg9/XLhdi+9rvtzRwiOfne4OD7+Zu4UoreXeEsHOm99FuH
L60+FSWK/a4bs5NxKhLltvTFADeH38SmybELpb+Wiq9By1kOjEs=
=bvS6
-----END PGP SIGNATURE-----

--buDNgeHiu+HCsDEc--
