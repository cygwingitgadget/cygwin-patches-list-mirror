Return-Path: <cygwin-patches-return-9972-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 67828 invoked by alias); 22 Jan 2020 10:07:10 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 67818 invoked by uid 89); 22 Jan 2020 10:07:10 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-107.8 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*F:D*cygwin.com
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (217.72.192.74) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 22 Jan 2020 10:07:09 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id 1N1PPJ-1jb3li3MJH-012sW9 for <cygwin-patches@cygwin.com>; Wed, 22 Jan 2020 11:07:05 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 71885A82E8E; Wed, 22 Jan 2020 11:07:05 +0100 (CET)
Date: Wed, 22 Jan 2020 10:07:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Fix reopening slave in push_to_pcon_screenbuffer().
Message-ID: <20200122100705.GU20672@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200121144144.1598-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="vs0rQTeTompTJjtd"
Content-Disposition: inline
In-Reply-To: <20200121144144.1598-1-takashi.yano@nifty.ne.jp>
X-SW-Source: 2020-q1/txt/msg00078.txt


--vs0rQTeTompTJjtd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 391

On Jan 21 23:41, Takashi Yano wrote:
> - For programs compiled with -mwindows option, reopening slave is
>   needed in push_to_pcon_screenbuffer(), however, it was not at
>   appropriate place. This causes the problem reported in
>   https://www.cygwin.com/ml/cygwin/2020-01/msg00161.html. This
>   patch fixes the issue.

Pushed.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--vs0rQTeTompTJjtd
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl4oHskACgkQ9TYGna5E
T6DGdg/9EgR2Fe5YkyUIxNBFmrhNry1KnmVkpaZfMSVNWzB9VGghaB4umLNAJvIM
1YGCFHcTFy9XiRhjBThHhodMaJGDNmxIyKGiIDKoF7nU23NRJAecaaCIaDD77nnw
lS8uQCnWWczJ26UnLWqZclZ0IV2PTrhcW6nthGAFpUCiWwtax2sYBgAyB2xSSaZP
sEXzxG+b/o3TH/eXSNY7ymFHTAMnYKbHxENirzJY2yNEIJWqMWD8ob4k7itQZZIT
StQRKxzGM7C26SgyEugWdqkwBx14vZiZXbcqrCLFpxZqoOpfxwZ6JxK9ogOggWcj
n0qJNGzLO6OtSaCIQng/rB38lJoLtgCZIYSdoquVtq4yDPxbEi5FLUA0Gtuu1MJV
ZlleWwCDA5AAxNkPnQLiWRDjqMu0EIaeyWvzsGjUTymGl+2lN39DzFA5cCD1C1Bo
Xa3XQXo+FoS5xU/v58hSdC77TpkRDy3o19e2oqaSoN6br+purSyoquAODmozeSUP
vp8qG1E9zGUIW+miBTkwm+3hdiMbKnxTEtcl0FlBX8A+yTSBu+hQGVRdqCLk3zIK
lk6RoyMtfmlOfQKpp+lEibkcOeOITsMzUkvDwm7+JBaZ/h/nGrcwPe386BWOpIZA
U5t1kg7TVC4eZXhkvqGP3quaXtrnCFkCTeDZB495lFfoTTP+ONs=
=+suH
-----END PGP SIGNATURE-----

--vs0rQTeTompTJjtd--
