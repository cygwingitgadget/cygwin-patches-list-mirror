Return-Path: <cygwin-patches-return-9842-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 68045 invoked by alias); 13 Nov 2019 09:28:48 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 68031 invoked by uid 89); 13 Nov 2019 09:28:48 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-107.1 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=HX-Languages-Length:568
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.17.13) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 13 Nov 2019 09:28:47 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id 1M8QNy-1iZEo10Sdk-004USN for <cygwin-patches@cygwin.com>; Wed, 13 Nov 2019 10:28:45 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 8D424A809F3; Wed, 13 Nov 2019 10:28:44 +0100 (CET)
Date: Wed, 13 Nov 2019 09:28:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: console: Revise the code checking if the console is legacy.
Message-ID: <20191113092844.GN3372@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20191112180459.1786-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="XsxFkDPDWfsXVt/M"
Content-Disposition: inline
In-Reply-To: <20191112180459.1786-1-takashi.yano@nifty.ne.jp>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SW-Source: 2019-q4/txt/msg00113.txt.bz2


--XsxFkDPDWfsXVt/M
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 499

On Nov 13 03:04, Takashi Yano wrote:
> - Accessing shared_console_info before initializing causes access
>   violation in checking if the console is legacy mode. This patch
>   fixes this issue. This solves the problem reported in:
>   https://www.cygwin.com/ml/cygwin-patches/2019-q4/msg00099.html
> ---
>  winsup/cygwin/fhandler_console.cc | 29 +++++++++++++++--------------
>  1 file changed, 15 insertions(+), 14 deletions(-)

Pushed.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--XsxFkDPDWfsXVt/M
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl3LzMwACgkQ9TYGna5E
T6B7tBAAgD5KsllkV2X/90/F/5TU8BeWAbxYN428tVtrqoSw78c13q5FjQyY07HZ
Cgw267gN22wPdKViOlTC2Whucd4uj7AR1Y/kQBLdsV0CDwXxSDuyMGxjOj9GcnWK
pbfeA2MrWzgj93+60QOXvRHRMIBbXkueW0BHjDEQ66C2dWIs2Xy9Uk7OS7e9RxWI
eKY1lED39DcAWJGRRm7Oiqr1Mcjwa5gx9tQ7eYjQHjZjqXY8Eby8XB0hKBqEmMSa
oshuZ28H+2/geUvTvublJUik/UyV+kDhYyl5E8xCrkvsoo1rAqZ66CBD5b/pJlop
UvygC7kMyqQetN6GagB1luBmft0PAMoD2pzw11skbbSk1LXFrTXran9p4tPLcmXb
eH17I/adqTBpkz+Pf+fy/acsNkq7q94h//HrmjdwP8xVznaHWgXcB7n0x5MABa3x
/TUJxj8qRoujLmO6985/roaJmFJ9/8mcOXyW/lVGfJQbSyShfksPIBx9dlzKEbCi
utph5DVTPnRQnpGaNezjoK8tEa5DTMd83UMmOwe8vMQFGYOBytXwV5/7s5VYRBLT
ptgD6rgiOEXUiID6esRZJX//hAXaMz/IsHJCds9l2bxNx09KJ5KUctLhGEZXtMCe
5pdD0ut0OWqIpi9tMKkTZIsG8feKY7ycrydEgVcw0eIiG9uOVzA=
=femd
-----END PGP SIGNATURE-----

--XsxFkDPDWfsXVt/M--
