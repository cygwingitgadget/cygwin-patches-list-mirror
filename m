Return-Path: <cygwin-patches-return-9106-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 72618 invoked by alias); 3 Jul 2018 13:40:58 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 72607 invoked by uid 89); 3 Jul 2018 13:40:58 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-101.3 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2 spammy=
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (217.72.192.75) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 03 Jul 2018 13:40:57 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue103 [212.227.15.183]) with ESMTPSA (Nemesis) id 0Lmel1-1g8rLy3SD5-00aCTH for <cygwin-patches@cygwin.com>; Tue, 03 Jul 2018 15:40:53 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 5D807A806E2; Tue,  3 Jul 2018 15:40:53 +0200 (CEST)
Date: Tue, 03 Jul 2018 13:40:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: perror() changes the orientation of stderr to byte-oriented mode if stderr is not oriented yet.
Message-ID: <20180703134053.GL3111@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20180627200116.ddd80f78597f8fd3f09d5d4b@nifty.ne.jp> <20180627125503.GV28757@calimero.vinschen.de> <20180628201421.8f395c712f2fe5b3504d63f1@nifty.ne.jp> <20180628183157.GC32575@calimero.vinschen.de> <20180629213458.a39b9d4114bdf778deed8f49@nifty.ne.jp> <20180702102838.GB3111@calimero.vinschen.de> <20180703191818.5ee7b9c7338deb479d4a774c@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="451BZW+OUuJBCAYj"
Content-Disposition: inline
In-Reply-To: <20180703191818.5ee7b9c7338deb479d4a774c@nifty.ne.jp>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SW-Source: 2018-q3/txt/msg00001.txt.bz2


--451BZW+OUuJBCAYj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 746

On Jul  3 19:18, Takashi Yano wrote:
> Hi Corinna,
>=20
> On Mon, 2 Jul 2018 12:28:38 +0200
> Corinna Vinschen wrote:
> > > By the way, I have noticed that psignal() and psiginfo() also have the
> > > same problem. psignal() belongs to newlib, so the same strategy can
> > > be applied. However, what can we do for psiginfo()? Only the FreeBSD
> > > route may be the answer...
> >=20
> > I guess the simplest solution is to use the FreeBSD/OpenBSD method
> > all the time.
>=20
> This is for fixing psiginfo().

Thanks, LGTM.  I'll push this depending on the discussion on newlib.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--451BZW+OUuJBCAYj
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAls7fOUACgkQ9TYGna5E
T6C1Hg//SqwMf8lgV0pl0mc7YcLGNNuNTK2XpgZ+kS6Xofy6YK62FD6E9XNPIS7I
EJw9Lvb/ZO7SHSYuoQ6eo8DmPN26Plm3Y/uZFASNAoMwxSEg5MCnUGHT37IjwwAv
AaV+vK8H+6eI/cFePACjAiUdImklJ8+f1ujcQx6mureJAw4FTvFFnaJbngNMVAWo
MUULWJKSl6YsUAIuhbYiNqoMfc43lM5Gz13hApXuwa7IBB6gVTHZlVdhee0+vAqR
FVoMncx+fYBYAkXI9osWY70Y16piPY58vyCMkL+x06WXKU+GnowBWHS/YF+rtxLJ
skeaaTG9/zeUZfguVGk6DrhQAmJ9+RGKHlHgUJtUvDy8ZBWioEWcxzR7b3c5cYih
/opSCBgfh/Exge7f2ozD+8ZinGXmX+ZfLiyR6RH3nREXmlIN2/YDkZYodSkeUZKi
EEE7B+w2t+LmS8Q8rVSBtmyMEeTGYCuA0S//Yg73f+H/AsyFTe7rJua7P3wlXgrP
pmM5pBJw2x2ZfelHzlqlxYHx4CaaL54f508xUCXPGqnOvJjx2jibV7q9XEyV30+e
xk+3+06qU4hzME84DRX4SUioZ2oW+M6C7UyI8s9B5WkeoclayH2MAjMQw+ojz06E
7zdD88+JM86kp0uEI3oF3MCExkK7fZJ4JofGZO1awQ5Mj4lS5EM=
=BquR
-----END PGP SIGNATURE-----

--451BZW+OUuJBCAYj--
