Return-Path: <cygwin-patches-return-9519-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 119755 invoked by alias); 24 Jul 2019 16:20:54 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 119743 invoked by uid 89); 24 Jul 2019 16:20:54 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-114.4 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=8.2.1, HX-Languages-Length:1059, UD:cygwin.com, cygwincom
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (217.72.192.75) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 24 Jul 2019 16:20:53 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id 1M2OEq-1hpmIy17fC-003xA8; Wed, 24 Jul 2019 18:20:46 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 8A289A80871; Wed, 24 Jul 2019 18:20:45 +0200 (CEST)
Date: Wed, 24 Jul 2019 16:20:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Ken Brown <kbrown@cornell.edu>
Cc: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] Cygwin: fhandler_termios::tcsetpgrp: check that argument is non-negative
Message-ID: <20190724162045.GY21169@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Ken Brown <kbrown@cornell.edu>,	"cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
References: <20190724153438.1240-1-kbrown@cornell.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="iBHcHRCIarfY7C0j"
Content-Disposition: inline
In-Reply-To: <20190724153438.1240-1-kbrown@cornell.edu>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q3/txt/msg00039.txt.bz2


--iBHcHRCIarfY7C0j
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1038

On Jul 24 15:34, Ken Brown wrote:
> Return -1 with EINVAL if pgid < 0.  This fixes the gdb problem
> reported here:

Why does it fix the issue?

>   https://cygwin.com/ml/cygwin/2019-07/msg00166.html
> ---
>  winsup/cygwin/fhandler_termios.cc | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/winsup/cygwin/fhandler_termios.cc b/winsup/cygwin/fhandler_t=
ermios.cc
> index 4ce53433a..5b0ba5603 100644
> --- a/winsup/cygwin/fhandler_termios.cc
> +++ b/winsup/cygwin/fhandler_termios.cc
> @@ -69,6 +69,11 @@ fhandler_termios::tcsetpgrp (const pid_t pgid)
>        set_errno (EPERM);
>        return -1;
>      }
> +  else if (pgid < 0)
> +    {
> +      set_errno (EINVAL);
> +      return -1;
> +    }
>    int res;
>    while (1)
>      {
> --=20
> 2.21.0

Looks good with GDB 8.2.1.  A bit of description why this fixes the
problem and it's GTG.

Unfortunately it doesn't fix what I'm seeing under GDB 8.1.1, but I'm
more and more convinced this is GDB's fault.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--iBHcHRCIarfY7C0j
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl04hV0ACgkQ9TYGna5E
T6CybQ//QFLL+ZQul5fV3eRbYOnjV2iugmkReIs1sXCVDc9l3ntMkDVEbkofLqwA
lw7BmqYG7bXZ/XW3KQSQ5AjncwCJcITxzQxrlbT95Eh+ja7cPvodNeqwIkKuofym
5g8EvEOHg55oVaUaaaXhtKNjI8NtT2xqd3FC7CMFNJSo3Hd5084R1pj1DKizSTQe
xu6wv1/EjNeXba+h0M1Xy50+lkNBtLOG9zXkbt3ocr1v0TKwSzopLQCwCBaZ/GUr
j40ABVtiCfjrshdlbv8+6ZxKBPs533E/4sGkjm3bQUGFcwqKb2Ms2lcwhA1YZx2B
OwJev/o654dKe2s79D5P3Hm1bYD8iCyGS0IAfFBFeYk1cnCZHYNd3wrjEtUJGg9h
FU5JKKYa8gkUjYdkrP1kWILPKi0HV2a4atg56gjWxoVWvGzIoILo5P7RKGmA0hnL
/f0+1/qWwCNIi9X684rR82tYxpmgani+zb/MaEuD7gQqwUVcT/xyL4jKVcJtIUXo
ThwMKSazS+Do2IC4gw94Xu8C8OMWq2anLVLCSG1i54yocRFrxvd3BIoOYeO0dEVI
TMej/lCqpoqbBJ3OMKTlgHR3y/+vPSn0nSspTbQZXdU2Wg+yiQ1y6C4ZA7SvVQNe
o5P/gRkT3sBKfd2AwBUuZguhMZQQ1muJqxlafmaA0Dh49w3IAM4=
=SwWA
-----END PGP SIGNATURE-----

--iBHcHRCIarfY7C0j--
