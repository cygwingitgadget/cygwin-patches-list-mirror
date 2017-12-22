Return-Path: <cygwin-patches-return-8991-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 115446 invoked by alias); 22 Dec 2017 19:24:00 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 115435 invoked by uid 89); 22 Dec 2017 19:23:59 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-104.9 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_BRBL_LASTEXT,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=H*Ad:U*cygwin-patches, HTo:U*cygwin-patches, site
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 22 Dec 2017 19:23:58 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id 5944A721E281C	for <cygwin-patches@cygwin.com>; Fri, 22 Dec 2017 20:23:55 +0100 (CET)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id 045D45E008B	for <cygwin-patches@cygwin.com>; Fri, 22 Dec 2017 20:23:55 +0100 (CET)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id EAE41A802EA; Fri, 22 Dec 2017 20:23:54 +0100 (CET)
Date: Fri, 22 Dec 2017 19:24:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 2/2] cleanup winsup/doc/etc.{postinstall,preremove}.cygwin-doc.sh quote test variables, correct utility paths, define site in preremove
Message-ID: <20171222192354.GC4063@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20171220230153.8512-1-Brian.Inglis@SystematicSW.ab.ca> <20171222183556.4268-1-Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="qtZFehHsKgwS5rPz"
Content-Disposition: inline
In-Reply-To: <20171222183556.4268-1-Brian.Inglis@SystematicSW.ab.ca>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-SW-Source: 2017-q4/txt/msg00121.txt.bz2


--qtZFehHsKgwS5rPz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 384

On Dec 22 11:35, Brian Inglis wrote:
> ---
>  winsup/doc/etc.postinstall.cygwin-doc.sh | 10 +++++-----
>  winsup/doc/etc.preremove.cygwin-doc.sh   |  5 +++--
>  2 files changed, 8 insertions(+), 7 deletions(-)

Pushed.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--qtZFehHsKgwS5rPz
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlo9W8oACgkQ9TYGna5E
T6A40g//QXIDPur2xA340dWxe4fSzMt7maR0gh3gclTSG9fQTs80D/tA+cgfSok1
x0U7ccCEpFy8wRMT3G1PAuTZZF5OhxH07oX+0/LYJV0jFZPSYuKcrj47mrIQI/re
0Pc2I8A6Dc2ChmKaiAr6oWW3dVNeHt6TwtLHcsNwqTlGxKCL9NmOqtVy9fNKraWf
YBPvXsxVmN3zD9Ns8Xc5SSZDsHp12tm4387acqg5bTyDy0HmmT1d2XuTLrps6inu
Yhke/yeIfioDBkSmlWRRdTaIMR2mFEk5loIjzlhXmnzwIkEnDzpKI+dpKjEUJ3FI
aYNh7rSVKbGT4LiaZd445Imdp34KQPTqrc6RLTl5YEwALFwiPHEPHQiV6TeR2Vzc
bor6VsWveTz53S/s/CfdQhxct4vGpUxZhWCucC1XQ3NvQBTlvQ2ErcEGdPbDH59Q
9n/nBxhfAw23JpgwnV+Np+QgLTMRy/UGe97Ft6cHRShIBoCg280x9FmF55z/nrGU
CNX7ScS5//4NSZmdaGV7SazdAlCoIxk0r6S6qNcu8JO+z2IuwM5S8iT7cP7asvi8
1mHaGWm2LYUagJ+JY+tqKv+U6LSBaDIsduJXGsPr5hoLVygzKARgSN9v/FYj95m4
iWwt6swS55Fsi8Bu6tNo0voJ0liww0MT/pYMj8ZEeb8szYSegX0=
=ftSb
-----END PGP SIGNATURE-----

--qtZFehHsKgwS5rPz--
