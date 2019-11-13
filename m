Return-Path: <cygwin-patches-return-9841-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 38513 invoked by alias); 13 Nov 2019 09:18:40 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 38479 invoked by uid 89); 13 Nov 2019 09:18:40 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-107.2 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=screen
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.133) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 13 Nov 2019 09:18:39 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MekrN-1hwJWT1xuH-00aphO for <cygwin-patches@cygwin.com>; Wed, 13 Nov 2019 10:18:36 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id ADC88A809F3; Wed, 13 Nov 2019 10:18:35 +0100 (CET)
Date: Wed, 13 Nov 2019 09:18:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Use redraw screen instead of clear screen.
Message-ID: <20191113091835.GM3372@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20191112130023.1730-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="2+IDmuKgu0wSQZlt"
Content-Disposition: inline
In-Reply-To: <20191112130023.1730-1-takashi.yano@nifty.ne.jp>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SW-Source: 2019-q4/txt/msg00112.txt.bz2


--2+IDmuKgu0wSQZlt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 750

On Nov 12 22:00, Takashi Yano wrote:
> - Previously, pty cleared screen at startup for synchronization
>   between the real screen and console screen buffer for pseudo
>   console. With this patch, instead of clearing screen, the screen
>   is redrawn when the first native program is executed after pty
>   is created. In other words, synchronization is deferred until
>   the native app is executed. Moreover, this realizes excluding
>   $TERM dependent code.
> ---
>  winsup/cygwin/fhandler_tty.cc | 30 ++++++++++++++++--------------
>  winsup/cygwin/tty.cc          |  2 +-
>  winsup/cygwin/tty.h           |  2 +-
>  3 files changed, 18 insertions(+), 16 deletions(-)

Great!  Pushed.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--2+IDmuKgu0wSQZlt
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl3LymsACgkQ9TYGna5E
T6AwEA/+IzJHFNX+lHXVuge7gcHojKZJvueWBlEeK4rMrMS1ZAr0D2AaM6L6HbZh
3ZkHMvxnkUN8XyUeGYVpo+LzU+EH2lqOKQ1giNaJ+A8qx2ap04NiUrXbuiME0mxk
ci05b7iatI7qOs0H3YFgArk3zCtILjrXXQnhgZQ4Fs8lAtQv+HKVz+Vd8CGw2hRf
8W2tSojGsPVTjXzzgkfYETUfs+HmsgILCcoC06G8U4oLjm9npZNeQNgvahh9gGFx
9wV5UByP47bxK7WGoBwX2NDgPFyA/B0fj0y9VFJTqoqdRKtZkvnVwMF0U2IvltKw
irye9Rwh5J59T+j6aldLCCpvegEk4PQUg86D3WfBoC3VD30Yzirt60OBjNeZBJI3
l+w0R7zrLUfGu89170qaAyTBYvUdGCAOkULnEXyA3mR/RNitossS51hjh0P3UB0W
Lvz7g4z66kk84EXsXGMh1gBsZcM+nol4dzsKZqt4yEtzqa/0NbiZe9DEm53cSl+q
uQ6pjFgzPZAnn1X9t/7trD/S6lJEVtaELaA4bJMsomkXGkggL7MfNwriqO2qWLlu
l6tzsl/ZBEBg1XoMpxj3SWMfgqohMxEzVcALIgLEt/rteom6yF0tG5Ec7iKKPXZd
x2sMQhoUKMe6ig+FZ71ki4ZNv6FMeR3XZ/D/4cF6emjgG0AvXiI=
=iEdR
-----END PGP SIGNATURE-----

--2+IDmuKgu0wSQZlt--
