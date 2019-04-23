Return-Path: <cygwin-patches-return-9375-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13163 invoked by alias); 23 Apr 2019 08:48:03 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 13140 invoked by uid 89); 23 Apr 2019 08:48:03 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-104.2 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*R:U*cygwin-patches, H*F:D*cygwin.com
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.187) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 23 Apr 2019 08:48:02 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MFsER-1h271f3eVr-00HNV1; Tue, 23 Apr 2019 10:47:56 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id AD450A804A5; Tue, 23 Apr 2019 10:47:55 +0200 (CEST)
Date: Tue, 23 Apr 2019 08:48:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Ken Brown <kbrown@cornell.edu>
Cc: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH 0/5] More FIFO bug fixes
Message-ID: <20190423084755.GB30041@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Ken Brown <kbrown@cornell.edu>,	"cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
References: <20190420185834.4228-1-kbrown@cornell.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="qlTNgmc+xy1dBmNv"
Content-Disposition: inline
In-Reply-To: <20190420185834.4228-1-kbrown@cornell.edu>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q2/txt/msg00082.txt.bz2


--qlTNgmc+xy1dBmNv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 794

On Apr 20 18:58, Ken Brown wrote:
> I'll be glad to commit these myself, but I thought I should send them
> here first for the record and for review.
>=20
> Ken Brown (5):
>   Cygwin: FIFO: stop the listen_client thread on an opening error
>   Cygwin: FIFO: duplicate the i/o handle when opening a duplexer
>   Cygwin: FIFO: avoid WFMO error in listen_client_thread
>   Cygwin: FIFO: close connect_evt handles as soon as possible
>   Cygwin: FIFO: stop the listen_client thread before fork/exec
>=20
>  winsup/cygwin/fhandler.h       |  3 ++
>  winsup/cygwin/fhandler_fifo.cc | 55 ++++++++++++++++++++++++----------
>  2 files changed, 42 insertions(+), 16 deletions(-)

Reviewed.  I don't see anything evidently wrong.  Please push.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--qlTNgmc+xy1dBmNv
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAly+0TsACgkQ9TYGna5E
T6Dr4g/9FEeGl85/cZsp0ODd4vvi64/jVFS2yEdYK4yIOaDTC48XQ+F9oym6rMSG
kogDp2zp11/5d8MlGZR6XAWOvSeGWH+VXRLRk0RE4uZbqLUYMyS7oB6fXuRQP1s0
NHGAdW58qZ6YXkKyLqtKpa/vKrDyXi9v/hFIZZh93yVGvzro/kdqu0gpwGima2IF
KElqfjgwpZ3wWnnG7093lqPxjnNZ5BsYd2htj7pIHPTK1Q53gr4EXJ/6RBjzHzU9
VDGxu+AxAEIlVEjnjIqLfVIWlY4/dJmSdNicwZEcYPRoFVL82c5w5DywhPrQe3or
1BtTjJffiLVbSEFacVFVONY9BvxITm9ffg9SAS0SoGZrqkVtvQF4YRWcx0nJDYNH
YCh5ELJarqrf2J9f0uxE26V3BKHW9hnuBScXyP1dejHLSiZcQPegGDEy7Uv4QZkY
jFg4tnfn1CxSidIDDMiM5An9lTewJ4rExrD8jdlqZNQvI41/9zs1XiSJ6jtYG5nX
3aCbzQL92CGUGgNawSxQel1p3hUaGPXIJW8EUQPff4KtlpheGgVo19VUf5br+CDY
59O0TYZ/dgczBnCiMEPlGTHDUOwmm0qimjlKebvxdrziwWyI4pe1uCjj+Ck5Uo3L
X3F8rhXPvnSfflyVm29K9i7EieYiTb8bRA7LzxxSPr+ZmgRZZi4=
=lJN0
-----END PGP SIGNATURE-----

--qlTNgmc+xy1dBmNv--
