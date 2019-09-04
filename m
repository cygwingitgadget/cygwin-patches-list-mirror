Return-Path: <cygwin-patches-return-9615-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 130146 invoked by alias); 4 Sep 2019 13:33:30 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 130137 invoked by uid 89); 4 Sep 2019 13:33:30 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-103.7 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.17.10) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 04 Sep 2019 13:33:29 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MnagF-1iULtj1mGD-00jXwj for <cygwin-patches@cygwin.com>; Wed, 04 Sep 2019 15:33:26 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id B6D89A80659; Wed,  4 Sep 2019 15:33:25 +0200 (CEST)
Date: Wed, 04 Sep 2019 13:33:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 4/4] Cygwin: pty: Limit API hook to the program linked with the APIs.
Message-ID: <20190904133325.GQ4164@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20190904014426.1284-1-takashi.yano@nifty.ne.jp> <20190904014426.1284-5-takashi.yano@nifty.ne.jp> <20190904100351.GM4164@calimero.vinschen.de> <20190904213914.ce7cf3703871189e9613c7d1@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="yLaBmHMi4cq+C/u4"
Content-Disposition: inline
In-Reply-To: <20190904213914.ce7cf3703871189e9613c7d1@nifty.ne.jp>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SW-Source: 2019-q3/txt/msg00135.txt.bz2


--yLaBmHMi4cq+C/u4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 903

Hi Takashi,

On Sep  4 21:39, Takashi Yano wrote:
> Hi Corinna,
>=20
> On Wed, 4 Sep 2019 12:03:51 +0200
> Corinna Vinschen wrote:
> > I'll push the other 3 patches from this series.  For this patch,
> > I wonder why you create set_ishybrid_and_switch_to_pcon while
> > at the same time define a macro CHK_CONSOLE_ACCESS with identical
> > functionality.
>=20
> Yah, indeed!
>=20
> > Suggestion: Only define set_ishybrid_and_switch_to_pcon() as
> > inline function (probably in winsup.h) and use only this througout.
>=20
> This function uses static variable isHybrid (sorry camelback again)
> and static function set_switch_to_pcon() defined in fhandler_tty.cc.
>=20
> To make it inline, a lot of changes will be necessary. How about
> non-inline function?

That will add extra function calls, but, yeah, sure.  We can streamline
this later.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--yLaBmHMi4cq+C/u4
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl1vvSUACgkQ9TYGna5E
T6Bc9g/9GS6t0KmksW6bwonQz6B6ELm+r2GKf36cNu2lgyR1n+wFKXEcA8+2hvS0
6aXUa04lVyzwFN74uI/IpKcDcuwZ2YssgoX1v39MY9PHiFVZspJNj7UbgwPrkqH7
Ug6HRrMh5IKPhX3p98c2g9mRgpo1JezEBgD5LKvTbWUtibRC3oX+mddC5YWIW69C
aPv8Q4dkrCzsyPy9AleQ4fKnZpkT9t3AxsuJH3gWkhj2FgiGKWRV+vzvAptIXgWq
ohzv990Ugm8ZlyV2/PlD78MfUbkbdswkrakl7Pq9AEf3rjHHNYjvDVGyqPZ2uKn5
5r+yywFB7vtH2mUKXCmupovJVT7X2Flsnkuir8cJe9fVTlmW6lkFuNu1jaUZXGsQ
HXvdKQo2SJK30APv7UYfvntYek4KC95+IOF0MJkMd8BEI0btSzA0mc3oxU9q6HBY
Cfnlg4at6OIflvluJI1rbWzNGaYgefyaS6INKkY2oW5aqxXs7qPO6FDTMLAOHIwR
au5VSSDblsc92anPIB8BlGUfOGOe/cBHBB+WxoJr7Mb8AGH8PkjcVmmXsSSesc1Q
/3oVcaKjpD7FYnaUODA6nC+fAxiJWI4EBxx9sLfOTNOHN4BZsu2rWHhKpHNZFxEv
ud5I/sz7KtLiPH/kPGRGWKDhixLCysQdCsKUUFMVwQl8MBwQJmk=
=beWR
-----END PGP SIGNATURE-----

--yLaBmHMi4cq+C/u4--
