Return-Path: <cygwin-patches-return-10019-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 62029 invoked by alias); 28 Jan 2020 17:06:55 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 62019 invoked by uid 89); 28 Jan 2020 17:06:55 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-112.2 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=acls, ACLs, H*F:D*cygwin.com, our
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (217.72.192.73) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 28 Jan 2020 17:06:54 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MKt3r-1jHady28oX-00LGb5 for <cygwin-patches@cygwin.com>; Tue, 28 Jan 2020 18:06:51 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 1DC3FA80BC1; Tue, 28 Jan 2020 18:06:51 +0100 (CET)
Date: Tue, 28 Jan 2020 17:06:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/3] Some O_PATH fixes
Message-ID: <20200128170651.GG3549@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200127132050.4143-1-kbrown@cornell.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="10jrOL3x2xqLmOsH"
Content-Disposition: inline
In-Reply-To: <20200127132050.4143-1-kbrown@cornell.edu>
X-SW-Source: 2020-q1/txt/msg00125.txt


--10jrOL3x2xqLmOsH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 890

On Jan 27 13:21, Ken Brown wrote:
> Ken Brown (3):
>   Cygwin: fhandler_base::fstat_fs: accomodate the O_PATH flag
>   Cygwin: fhandler_disk_file::fstatvfs: refactor
>   Cygwin: FIFO::fstatvfs: use our handle if O_PATH is set
>=20
>  winsup/cygwin/fhandler.h            |  1 +
>  winsup/cygwin/fhandler_disk_file.cc | 24 +++++++++++++++++-------
>  winsup/cygwin/fhandler_fifo.cc      |  8 ++++++++
>  3 files changed, 26 insertions(+), 7 deletions(-)
>=20
> --=20
> 2.21.0

Patches are looking good to me.

As outlined on IRC, I found a problem with the ACLs created on new
FIFOs and frixed that (I think).  However, Cygwin doesn't actually
return the real permissions in stat(), only the constant perms 0666,
kind of like for symlinks.  I didn't have time to look into that yet,
but it would be great if we could fix that, too.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--10jrOL3x2xqLmOsH
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl4waioACgkQ9TYGna5E
T6Baqg/+InKJAYhiUqUQxSpSoPIvbGJEJPnHk4mzPs263CED6rvrzIGQVL5RdUFc
e3WwccBQU0wtImoXcHzg2n/EfjsSZdw8LTn6jp2sB7G1+OtxsDWdP4qTYna0JhKf
bAzs2SdlL3PAiI4ogieP11mEOi8JkoWk536VJsUL+/YRMNvoA9/VMsLoqoAQR5XP
WCK+1opo6So7Rr4lKtRcQURgGhtBexWa/0ixSwFmVsUPR64c4M49uC9IpIl5dNcf
BEtBDV2evhOnuAkl3gr25TejiNUUv3uEKrwmVI2dPXtYLNw0Ppdh6JGKLzV2Ur7X
r8x3B8dSwyDgCtazkCM3CFi3ust4/Ii0c492Z/vQyBjfOc2l9gxFFTgpseL1QQse
1RUfapDJK29rV9lbFR/Pfx9zSGQ2mr901T+YC8ENt7/91anq+rCpyVTuGFUp14rf
po2sY9V6PZFW050srp8OUmWgD0vNuaX76nk9c+5imj0zU/1ZNTkq92wT5f4q1LS7
V5LUYJaRAI1CzXkC8cur2tswvh9lV9z/w/Tixq+PTofG52rHkTmRFvEumDml+swn
Nqowxb8ghoHx+mFxTIP/Pug8GKFOGVy+R2SRLdp1ILjrTj5p9ReSD14rHaiEwZ1B
3sSNSG7kD3tWqYQZXBNhenv6FzAMC6LuPajPFMRDIRrYYCefuIw=
=NB0z
-----END PGP SIGNATURE-----

--10jrOL3x2xqLmOsH--
