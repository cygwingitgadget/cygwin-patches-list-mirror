Return-Path: <cygwin-patches-return-9424-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 93167 invoked by alias); 3 Jun 2019 16:39:19 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 93158 invoked by uid 89); 3 Jun 2019 16:39:19 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-104.7 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*F:D*cygwin.com
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.187) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 03 Jun 2019 16:39:18 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id 1M2Nm2-1hZTcT2VRO-003ru5; Mon, 03 Jun 2019 18:39:15 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 4A377A80414; Mon,  3 Jun 2019 18:39:15 +0200 (CEST)
Date: Mon, 03 Jun 2019 16:39:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: dll_list: no recursive use of nt_max_path_buf
Message-ID: <20190603163915.GM3437@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>,	cygwin-patches@cygwin.com
References: <e41869fa-977e-4b5e-c749-f3c4ba314c29@ssi-schaefer.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="umrsQkkrw7viUWFs"
Content-Disposition: inline
In-Reply-To: <e41869fa-977e-4b5e-c749-f3c4ba314c29@ssi-schaefer.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q2/txt/msg00131.txt.bz2


--umrsQkkrw7viUWFs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 409

On May 13 16:36, Michael Haubenwallner wrote:
> Querying the ntlength and existence of the /var/run/cygfork directory in
> the very first Cygwin process should not use nt_max_path_buf, as that
> one is used by dll_list::alloc already.
> ---
>  winsup/cygwin/forkable.cc | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)

Pushed.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--umrsQkkrw7viUWFs
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlz1TTMACgkQ9TYGna5E
T6DmkQ//RJSeLLDO57hgNQyXcCQ/ZAuic4CgsJWMXa87NPjLwcnQWz/Uq9qAU5rI
F2nhpw+BooymCtmUzGwf3/Jn/2KXzM+MkzSTS/39FEe7KLq6bNi9J9cY0g3PPog6
RaXhjHt7N+9VgsqrZlW0U/d8EWelKExyKRvz7FSGdn76GVU8DIdQvLhdmuNIryy/
HgRofXrZMei7l3QN8EGRrLvOcNbAYUCU9U+pVy1XDRvqvTehXIoI2wTt64Rjjhce
HO8P0rVUgd5qJ+IfhgfxwsSCr3Hr4nYrzuw1qYEpgGnjofyx1kDgYMr4oW2ni3/L
gd4YkV2Z6B2flIqkmFBCTXHXxp9TKJNXZQLXn6vLLkds6RcwYPGzx6l+wwsFEP2Y
5IeHrboftmcuJhGljXtHyhTf3GIqB2x2ug1GYD1utjA75KxDoCkz27XfgR7z38yi
gPAGJzBoYQ5MgUHzlVazPSAtM9uUQmAnFYh1+qzO+aCgzxcujWf1n3Vhe+2FwuUO
uZP35ZL9RUcAGWkS0xbCgogCpgUZcD0Xz6U2mhjIedbE/qhMMnlBlMzuZCL6+/LS
OkDYlWfyJgPkgwGXALoxd06xGaNuS7gTIEHGU00S8GTUxKktzJr4rFOrPxRhiC+R
WrXBhyC7+izYs7Xr+U2eaviD6hd1tc9VEVIAeSSF0J899b9/1SE=
=CKkn
-----END PGP SIGNATURE-----

--umrsQkkrw7viUWFs--
