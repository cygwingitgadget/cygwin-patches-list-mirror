Return-Path: <cygwin-patches-return-9545-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 62035 invoked by alias); 5 Aug 2019 11:25:36 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 62023 invoked by uid 89); 5 Aug 2019 11:25:35 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-106.7 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=HX-Languages-Length:699, H*F:D*cygwin.com
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.133) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 05 Aug 2019 11:25:34 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id 1M6UuX-1hx45W2aAj-006zhh; Mon, 05 Aug 2019 13:24:55 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id B35D9A806B7; Mon,  5 Aug 2019 13:24:52 +0200 (CEST)
Date: Mon, 05 Aug 2019 11:25:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Mark Geisert <mark@maxrnd.com>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: Implement CPU_SET(3) macros
Message-ID: <20190805112452.GK11632@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Mark Geisert <mark@maxrnd.com>, cygwin-patches@cygwin.com
References: <20190730121212.GV11632@calimero.vinschen.de> <20190804224546.59957-1-mark@maxrnd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="/T5g/TLNXpBPJeG6"
Content-Disposition: inline
In-Reply-To: <20190804224546.59957-1-mark@maxrnd.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q3/txt/msg00065.txt.bz2


--/T5g/TLNXpBPJeG6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 661

On Aug  4 15:45, Mark Geisert wrote:
> This patch supplies an implementation of the CPU_SET(3) processor
> affinity macros as documented on the relevant Linux man page.
>=20
> There is a different implementation of cpusets under libc/sys/RTEMS that
> has FreeBSD compatibility and is built on top of FreeBSD bitsets.  This
> implementation can be combined with that one if necessary in the future.
>=20
> ---
>  winsup/cygwin/include/sys/cpuset.h | 64 +++++++++++++++++++++++++++++-
>  1 file changed, 62 insertions(+), 2 deletions(-)

Pushed with the commit message tweak and additional doc changes.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--/T5g/TLNXpBPJeG6
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl1IEgQACgkQ9TYGna5E
T6AWPg/7BoHjHcfIBrV8z7bscIhAswrl4MV1NLXyC3NC1kMPnNxoiuXVNAQCAI/x
+eNFkUcrTvsb0WTNdLFYuxBUbxSU0lopnQFbhovcp5ztnCCcJ0LWUU1T6khREct+
JeHyyLPndkvcKpFCJ5tik5DCQPuPeos3rLG2iN7Z4E2A7y3WVMo3b0duxKqsnWJX
XmrynmAJlC/Umt2PCmtktXYUjU7zozOERc2fCjq1WNl1Nrqawx0MXNT14iVm9Ccc
IK03L7SRRfsoTHqdeun2RlppY6zGTHwkegOMT3wGLUl60+D5PN5Hm/xrYnyl1cmS
3dIYRjCWYd3yxasB1J8aARmSjqxU5XT0L4QEdgs08BXawqZIDse1LmFAD3Bx+J99
HJMfVi8x4zikxdso5wdiT/+50ur9bpN8Gt9Vbyjz3p6HA/iks6mpCTyLa9frbysL
wVaRke3TB56oChea7wevdQVxugL+P9PFFPBOfYMcjcG4nu4G18DZoP9PidAou8YN
qnO2PmI4ppNb2q4JP6hfLA15Y+EEXi9NSSQufDSuCFicHgjUjADjlGyw3T5gfyps
KLa/WywTgCvY9+2dal9Z6QfVPKUEhGUS1pI2Ei25v5FzReBNAYjQnB/f1I70ItF9
zMVvQaW2ZFY9J0TVi+b0TTclOoVqZFGYXqg6LMF75RouZjeZGXo=
=XEkA
-----END PGP SIGNATURE-----

--/T5g/TLNXpBPJeG6--
