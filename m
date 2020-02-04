Return-Path: <cygwin-patches-return-10039-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 80047 invoked by alias); 4 Feb 2020 10:50:11 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 79984 invoked by uid 89); 4 Feb 2020 10:50:08 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-109.8 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*Ad:U*cygwin-patches, corinna, simultaneously, Vinschen
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (217.72.192.73) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 04 Feb 2020 10:50:06 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id 1My3In-1jkZyl0YxD-00zSdY for <cygwin-patches@cygwin.com>; Tue, 04 Feb 2020 11:50:04 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 43BB5A80F08; Tue,  4 Feb 2020 11:50:03 +0100 (CET)
Date: Tue, 04 Feb 2020 10:50:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: console: Revise color setting codes in legacy console mode.
Message-ID: <20200204105003.GE3403@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200201042839.1899-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="YZ5djTAD1cGYuMQK"
Content-Disposition: inline
In-Reply-To: <20200201042839.1899-1-takashi.yano@nifty.ne.jp>
X-SW-Source: 2020-q1/txt/msg00145.txt


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 486

On Feb  1 13:28, Takashi Yano wrote:
> - With this patch, foreground color and background color are allowed
>   to be set simultaneously by 24 bit color escape sequence such as
>   ESC[38;2;0;0;255;48;2;128;128;0m in legacy console mode.
> ---
>  winsup/cygwin/fhandler.h          |  2 +-
>  winsup/cygwin/fhandler_console.cc | 47 ++++++++++++++++++-------------
>  2 files changed, 28 insertions(+), 21 deletions(-)

Pushed.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl45TFsACgkQ9TYGna5E
T6AwAxAAhi1E/wLZKbOlTA4M6PMqO+sSEGaeSssFWu7851BWg/BFHPGzsq+ikTI6
XCPCL/biF5VquEmMzDgOj5RTvicTGzvCGvQW1wycQr8ZrJhlyqclIhWcUg+dfbWW
n+tgNTD0Fjfu5j858oMTzt9MBvLnyWtb/psigCiGQeCIYPxR1Acqy896/vDr/B/9
74cBtpGZVq07qEqN27EfClyeGCIIbyP35+XKS8QScogFes1Wy/xYMRbp5tGr5ZcU
A665KY7/2gpdJ+DITwkbzK/2G0CZq3uWMybP80JDnpJcmXuBaYzXWiNrtO3e9P+X
drsHdXz0OElS6Olml7j5lVPjITScf/kSwZ8VzwrLvqKgqoVZQBTb5i7F83JgCQEN
pxXfOebaJwmIu62NtuBErQ88VjiRgaMG2wTEL0Fgr3F74T0StTCt3/NGhNpi0MeF
nfmAjOs3SQUSWr1Q5+6f8dx9+bSMdRMQodrzn4Y4z+ekwEPq+ofuVZzP6jqybwS6
SZ0eQsld1un//9XEvMhviPoDZvShxb9gqa+SCVzsPopvY8kUEaf3DtpPKCrOg0vd
BJd3b3n6r0t5tXMYjuXBHjhW/fQUZ8xOLLPRvK4cNIMFa83Z62g90/MnMbADvSMW
WEw0eUKg+Adszgittj9YX7/QuVwc964bwUbx9ZTEoboXo55bKdk=
=lPw8
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--
