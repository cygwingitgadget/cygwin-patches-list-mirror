Return-Path: <cygwin-patches-return-10123-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 54305 invoked by alias); 26 Feb 2020 11:16:11 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 53837 invoked by uid 89); 26 Feb 2020 11:15:49 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-106.7 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=black
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.17.24) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 26 Feb 2020 11:15:27 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MxDck-1jMN9I1TIG-00xeH2 for <cygwin-patches@cygwin.com>; Wed, 26 Feb 2020 12:15:16 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 856A3A8276B; Wed, 26 Feb 2020 12:15:15 +0100 (CET)
Date: Wed, 26 Feb 2020 11:16:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/2] Cygwin: console: Add workaround for broken IL/DL in xterm mode.
Message-ID: <20200226111515.GS4045@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200225171438.1243-1-takashi.yano@nifty.ne.jp> <20200225171438.1243-2-takashi.yano@nifty.ne.jp> <20200226201223.f84202de00a3f4ec65ceb64a@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="X+8siUETKMkW99st"
Content-Disposition: inline
In-Reply-To: <20200226201223.f84202de00a3f4ec65ceb64a@nifty.ne.jp>
X-SW-Source: 2020-q1/txt/msg00229.txt


--X+8siUETKMkW99st
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 791

On Feb 26 20:12, Takashi Yano wrote:
> Hi Corinna,
>=20
> On Wed, 26 Feb 2020 02:14:37 +0900
> Takashi Yano wrote:
> > - Cygwin console with xterm compatible mode causes problem reported
> >   in https://www.cygwin.com/ml/cygwin-patches/2020-q1/msg00212.html
> >   if background/foreground colors are set to gray/black respectively
> >   in Win10 1903/1909. This is caused by "CSI Ps L" (IL), "CSI Ps M"
> >   (DL) and "ESC M" (RI) control sequences which are broken. This
> >   patch adds a workaround for the issue. Also, workaround code for
> >   "CSI3J" and "CSI?1049h/l" are unified into the codes handling
> >   escape sequences above.
>=20
> Hmm, this fix seems to be not enough...
> Could you please wait?

Sure, no hurry!


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--X+8siUETKMkW99st
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl5WU0MACgkQ9TYGna5E
T6A/Og/+PFTaaxveyk8iF7BdpCM8bHmzuZ6iJYv5n7yiPQIgxcF6h+FbZEGlDhiQ
4VbInHMTUD411Hxp8UT7ma/CXaWlnyuanZaqiPajPXrea+DAZmb4oICZjE6tGUh4
c+YGO7i3wnWFF0eK+WnuSbA0CQywvGuRgpNY86DQkbT0DbSJZy2noShKGt3kyZOU
Zkf3Sr+wPbBuvS/2NuKih/pXpwoiL4Zzhv4/INU6RVytuW8hlhvI2H4rpYQZ38nX
p/CL3Dv6G/OSYa7Tpz1Miun5CDAfutKfxYBt3JGBhfLPBxAgjzY/FS3bsm48IkTQ
hTj6Ure9ko2Ch5sjDLPDxlmMnAGoQ3Nm3T7ybmG/EXyoBCeBQ5U2BnjRQEha2Q35
G9Z263NKLtjtaPKK+bo75UNwjoCduvmqqL/EPvtLmAuBDnb/uektO73LBtr/TNVY
usgaVOuPBOfPw2m8COHUZc69c1SIrP4IAVAk5g3zsKXf0d7bs5Wxrxt6dUsyQ2lG
+mxOIXK9Pbp+4YI8ClSKufrAlwFYjDvGCgTQ2zgVWnkH2WqQtAAXMITlHYtCnEwL
0nBmljMisOSds7s3yx6Ed63jJPi/FqU+mj0XJNhoCdM5CkV9o6actiwY3YlOdtbb
ARklE4lugFi9vSuqS1H21iM7icSabJ6a81KIiXcodVHmft+v+m4=
=SmT/
-----END PGP SIGNATURE-----

--X+8siUETKMkW99st--
