Return-Path: <cygwin-patches-return-9622-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 70828 invoked by alias); 4 Sep 2019 14:00:39 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 70803 invoked by uid 89); 4 Sep 2019 14:00:39 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-106.3 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.131) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 04 Sep 2019 14:00:38 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MLzWL-1hnZLO1ei1-00Hv43 for <cygwin-patches@cygwin.com>; Wed, 04 Sep 2019 16:00:35 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id E0220A80659; Wed,  4 Sep 2019 16:00:34 +0200 (CEST)
Date: Wed, 04 Sep 2019 14:00:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 1/1] Cygwin: pty: Limit API hook to the program linked with the APIs.
Message-ID: <20190904140034.GT4164@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20190904134651.1750-1-takashi.yano@nifty.ne.jp> <20190904134651.1750-2-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="Kuk/n493crKO4rgR"
Content-Disposition: inline
In-Reply-To: <20190904134651.1750-2-takashi.yano@nifty.ne.jp>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SW-Source: 2019-q3/txt/msg00142.txt.bz2


--Kuk/n493crKO4rgR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 872

On Sep  4 22:46, Takashi Yano wrote:
> - API hook used for pseudo console support causes slow down.
>   This patch limits API hook to only program which is linked
>   with the corresponding APIs. Normal cygwin program is not
>   linked with such APIs (such as WriteFile, etc...) directly,
>   therefore, no slow down occurs. However, console access by
>   cygwin.dll itself cannot switch the r/w pipe to pseudo console
>   side. Therefore, the code to switch it forcely to pseudo
>   console side is added to smallprint.cc and strace.cc.
> ---
>  winsup/cygwin/fhandler_tty.cc | 106 +++++++++++++++++++---------------
>  winsup/cygwin/smallprint.cc   |   2 +
>  winsup/cygwin/strace.cc       |  26 +--------
>  winsup/cygwin/winsup.h        |   3 +
>  4 files changed, 66 insertions(+), 71 deletions(-)

Pushed.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--Kuk/n493crKO4rgR
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl1vw4IACgkQ9TYGna5E
T6AiCQ/9E/16meJjo3SFpwXzs2jlDKkVJlm0NI8KsQrwRC9Own9v/sr+wC0/dzF5
ebPtlzHGVmKMTRpMulPl+lHVFj7E/NJ9Ym0+MRj3hcasjk4gJa78nAgyHZ2kkXs3
E9/Q/H3EcLMFI0vmVbmxic+N79dFdGiXd32Mqhuz6mnmFoOCxeZii659HiCVZW4i
6hzWoVdAGi0bJSqwZEysnDe9M9pxuwClalNA8geOAI34OE6jT2gXNH6VBvnD8toR
wKZZK4UX96nL5eI4q1NBJ+8ItMcBefjdzaqnln0rqo9pUFgjJL4yQl4iVCzpy549
XKKco2VF+baicKz8+9Aua1w7q+JRozi9a/v4DVZp5aJeChqFIXcCdAs8/upFlILO
MXPI6OoH+/4vhXq2At2lRGl9iC56lyzoThyJ1icxUGxZf5xvRI00KQhD2/fuYwtH
HCFkS/fg8aXh1L55qZvphIvniyXrwmcOXezKQ7xSIqmjrWcvxV+E+ZRIEZYphGrZ
Q3HqqmZ7/FteAg1f1GGrMwpsywDjD5EN1b75em5nNChy9F+zn9GJGcpLag5q5P/5
/Z+iVgyL+YotvECSNZEYqXbZgO5vBJt2jEkQoMxC2v99gd/+cWMw0jhsvmeK+ilx
nW5e1UG1ZJx49DNnkj0Ipd/6lfRkbh1eYhHkM0eXXuxuoXALs8Y=
=xEDW
-----END PGP SIGNATURE-----

--Kuk/n493crKO4rgR--
