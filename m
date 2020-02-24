Return-Path: <cygwin-patches-return-10107-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 98813 invoked by alias); 24 Feb 2020 10:12:04 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 98803 invoked by uid 89); 24 Feb 2020 10:12:04 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-119.3 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=Client, prod
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (217.72.192.73) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 24 Feb 2020 10:11:54 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MnItm-1jp6N13N9o-00jGYw for <cygwin-patches@cygwin.com>; Mon, 24 Feb 2020 11:11:51 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 76BCFA8276E; Mon, 24 Feb 2020 11:11:51 +0100 (CET)
Date: Mon, 24 Feb 2020 10:12:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] fhandler_proc/cpuinfo: support fast short REP MOVSB
Message-ID: <20200224101151.GE4045@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200221212807.61030-1-Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="LyciRD1jyfeSSjG0"
Content-Disposition: inline
In-Reply-To: <20200221212807.61030-1-Brian.Inglis@SystematicSW.ab.ca>
X-SW-Source: 2020-q1/txt/msg00213.txt


--LyciRD1jyfeSSjG0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1499

On Feb 21 14:28, Brian Inglis wrote:
> Added in Linux 5.6:
> Check FSRM and use REP MOVSB for short copies on systems that have it.
>=20
> >From the Intel Optimization Reference Manual:
>=20
> 3.7.6.1 Fast Short REP MOVSB
> Beginning with processors based on Ice Lake Client microarchitecture,
> REP MOVSB performance is enhanced with string lengths up to 128 bytes.
> Support for fast-short REP MOVSB is indicated by the CPUID feature flag:
> CPUID [EAX=3D7H, ECX=3D0H).EDX.FAST_SHORT_REP_MOVSB[bit 4] =3D 1.
> There is no change in the REP STOS performance.
> ---
>  winsup/cygwin/fhandler_proc.cc | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/winsup/cygwin/fhandler_proc.cc b/winsup/cygwin/fhandler_proc=
.cc
> index 78a69703d..030ade68a 100644
> --- a/winsup/cygwin/fhandler_proc.cc
> +++ b/winsup/cygwin/fhandler_proc.cc
> @@ -1346,6 +1346,7 @@ format_proc_cpuinfo (void *, char *&destbuf)
>=20=20
>            ftcprint (features1,  2, "avx512_4vnniw");	   /* vec dot prod =
dw */
>            ftcprint (features1,  3, "avx512_4fmaps");       /* vec 4 FMA =
single */
> +          ftcprint (features1,  4, "fsrm");		   /* fast short REP MOVSB =
*/
>            ftcprint (features1,  8, "avx512_vp2intersect"); /* vec intcpt=
 d/q */
>            ftcprint (features1, 10, "md_clear");            /* verw clear=
 buf */
>            ftcprint (features1, 18, "pconfig");		   /* platform config */
> --=20
> 2.21.0

Pushed.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--LyciRD1jyfeSSjG0
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl5ToWcACgkQ9TYGna5E
T6CTLg//XWoZB1rjLH8PB9PjOff+CnaPbvSgdwdQ5ARx9EDCnd4QC10c0jhPhBvZ
wwemuRZmRTtNy8/tC65gRFVi4ETTOdMnMm/Hcslz/lUY5z8pWYQG97tDQwfgYvKB
I6UcUe3Bg3ZzpwUMTO7YseowTyzRn4YExdnZ9GsRq08tY4NWMcbOFu5wPZL8mlhn
BN5+/M215rPsK6J8s2RQD/T+n4dr4izlq8/wJyfFrt3G06Mlj67ah+AdUMH4AMu6
PRJnsZiRKdiUWacVhtSJqGK8XlCDW3uFUejNDTB2Du3p2eYYHvgo6cZJ3Ofei0af
GUbsoXJxSMg61ayK+k+TIW7GaXjMIBUZ9qzfVMTKUTNEvHxxL6CATsw9csZ+iDFZ
s5ciYKkcs4elkzYVjo/KhOju/xN1CfB/Yh2dpu+YWzBaBXK+JuCpqUD28pk5jKcw
dKvZA83AAvdMf9DeMYALQ36OoQ/t0enF2YW2mDaXUR9Dzcu6mGGp+TepjFsT0cy/
76rU3v1tdjzDetL5wZhAq0GENZYhn8Ci03orb+Rm7AILBcZ9mYRlZ/c9q3kMBqta
Xy1JTZWlU6bl/0dUBJ6in/9gpbUT80F4wOa1lpHP9H9EnFbJs1dyi9dnyZIMW+Qt
hs4f0nTuE51qw6e6X8s70CK66lDSJoywSEReucdCEqYg7vWf/3s=
=HdbW
-----END PGP SIGNATURE-----

--LyciRD1jyfeSSjG0--
