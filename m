Return-Path: <cygwin-patches-return-9639-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 61748 invoked by alias); 5 Sep 2019 12:11:52 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 61731 invoked by uid 89); 5 Sep 2019 12:11:52 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-106.3 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.133) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 05 Sep 2019 12:11:50 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id 1Mc1hn-1ij1aP3BQl-00dXZY for <cygwin-patches@cygwin.com>; Thu, 05 Sep 2019 14:11:46 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 5F6ADA80666; Thu,  5 Sep 2019 14:11:46 +0200 (CEST)
Date: Thu, 05 Sep 2019 12:11:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/1] Cygwin: pty: Fix select() with pseudo console support.
Message-ID: <20190905121146.GD4136@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20190905042254.1954-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="jy6Sn24JjFx/iggw"
Content-Disposition: inline
In-Reply-To: <20190905042254.1954-1-takashi.yano@nifty.ne.jp>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SW-Source: 2019-q3/txt/msg00159.txt.bz2


--jy6Sn24JjFx/iggw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 667

On Sep  5 13:22, Takashi Yano wrote:
> - select() did not work correctly when both read and except are
>   polled simultaneously for the same fd and the r/w pipe is switched
>   to pseudo console side. This patch fixes this isseu.
>=20
> Takashi Yano (1):
>   Cygwin: pty: Fix select() with pseudo console support.
>=20
>  winsup/cygwin/fhandler.h      |  15 +++
>  winsup/cygwin/fhandler_tty.cc |  13 ++-
>  winsup/cygwin/select.cc       | 192 ++++++++++++++++++++++++++++++++--
>  winsup/cygwin/select.h        |   2 +
>  4 files changed, 207 insertions(+), 15 deletions(-)
>=20
> --=20
> 2.21.0

Pushed.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--jy6Sn24JjFx/iggw
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl1w+4IACgkQ9TYGna5E
T6Dq5RAAhPkygRkSjRAZspGER5uWoCiN3GsQ/S3ylgsp3rUlP87YWiME65vU6MGJ
+zeYauNsj21MfEwDvk7v7Kth5RVbI/ebMAfW4on3yZ378K4FL1jRr+rz1eG73B0H
gbG4wggU9jU2sWWdUAAJK54nazr9X1rtkcZIfzON7teL+nrJy3rOoatM80KyMHeL
bB76RQWYkbPBgBzM8DPhSQfD0/2MhJ0eNDPU3Y8qYHenrpOH1bD0LCL0ZmJEyfgS
/evXhWwedz9SjB31S1W6LBEcMOMlCkQKyoj4aSrDQumO5+IdMyKP57fhI++urzR9
dbgXJNFJBQ8aKAvpW4DxWbM3dprBsMj8qroVnqBG+YC2hDeBPST1YtYeOPhZyBhK
cP7iQUyETNsoyaSBDjd8IgCf5JFxQpP59CERfakPnEGJsc/SCGktZo98imhkPOzW
ofE6RMrLcIuDWw06nI6Mcd/TV+8XVb+xh7jPI+3WsdwCxaog9jtT2cMNE3VW3O4p
o+naRJsU0ghYgxj5YPEIa1kVjVtCP1Uo48pp6q59py/gqBTepkzQktuUfFxx0pH2
V+VMOq6Vi+NUUY2YG1fgxKONbiLOSWPUYT47AvOvTaPbI/Zlr0QhBgwV2bI67LgQ
DZuGP3MKmAUfFUwAgoYXmaE/pboPYKqH2Y7S7YntRZdeJWcKx3Y=
=//Tq
-----END PGP SIGNATURE-----

--jy6Sn24JjFx/iggw--
