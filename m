Return-Path: <cygwin-patches-return-9982-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 107284 invoked by alias); 23 Jan 2020 12:44:33 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 107263 invoked by uid 89); 23 Jan 2020 12:44:31 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-120.3 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,KAM_SHORT,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*F:D*cygwin.com
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.17.10) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 23 Jan 2020 12:44:28 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id 1N5mOb-1jf2Yb0P6Z-017CFT for <cygwin-patches@cygwin.com>; Thu, 23 Jan 2020 13:44:26 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id C3424A80BA7; Thu, 23 Jan 2020 13:44:25 +0100 (CET)
Date: Thu, 23 Jan 2020 12:44:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] fhandler_proc.cc:format_proc_cpuinfo add rdpru flag
Message-ID: <20200123124425.GB263143@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200123090626.58604-1-Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="DKU6Jbt7q3WqK7+M"
Content-Disposition: inline
In-Reply-To: <20200123090626.58604-1-Brian.Inglis@SystematicSW.ab.ca>
X-SW-Source: 2020-q1/txt/msg00088.txt


--DKU6Jbt7q3WqK7+M
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1468

On Jan 23 02:06, Brian Inglis wrote:
> rdpru flag is cpuid xfn 80000008 ebx bit 4 added in linux 5.5;
> see AMD64 Architecture Programmer=C3=A2=C2=80=C2=99s Manual Volume 3:
                                   ^^^^^^^^^
This came over already broken.  No idea if that's a problem of
your MUA or of the mailing list software.  I fixed it to an
ordinary quote char locally.

> General-Purpose and System Instructions
> https://www.amd.com/system/files/TechDocs/24594.pdf#page=3D329
> and elsewhere in that document
>=20
> ---
>  winsup/cygwin/fhandler_proc.cc | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/winsup/cygwin/fhandler_proc.cc b/winsup/cygwin/fhandler_proc=
.cc
> index 8c331f5f4..78a69703d 100644
> --- a/winsup/cygwin/fhandler_proc.cc
> +++ b/winsup/cygwin/fhandler_proc.cc
> @@ -1255,6 +1255,7 @@ format_proc_cpuinfo (void *, char *&destbuf)
>  	  ftcprint (features1,  0, "clzero");	    /* clzero instruction */
>  	  ftcprint (features1,  1, "irperf");       /* instr retired count */
>  	  ftcprint (features1,  2, "xsaveerptr");   /* save/rest FP err ptrs */
> +	  ftcprint (features1,  4, "rdpru");	    /* user level rd proc reg */
>  /*	  ftcprint (features1,  6, "mba"); */	    /* memory BW alloc */
>  	  ftcprint (features1,  9, "wbnoinvd");     /* wbnoinvd instruction */
>  /*	  ftcprint (features1, 12, "ibpb" ); */	    /* ind br pred barrier */
> --=20
> 2.21.0

Pushed.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--DKU6Jbt7q3WqK7+M
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl4plSkACgkQ9TYGna5E
T6BbiA//fYtlz0+bTfxldV/tfMSNL6nLoqG5GnreUI4q+EtJlnTJmjcgbccDFSMe
lmmywxkEG0dRoE6F93UfL4ZMCysE7rqpqrk+IimWMvMT5th1ljFj4Kcq6p/IlUS6
vO7jPH4H9o6hUpQtHvj9e1cKz12zlVRqQZj2hXAvd4kh+URysCX4bClxrlu1uRs8
8wGirxy3BN9jwus3RUT8YdpFWhN+UFtf51EV9GdsoMsNbPH6SVQlxwrv/1MhDYKe
gwt3pObXGkvxthTNPFgycRKAqaNp67pRfk8tJaS2Kq5yHGLK8A8FlIQv+VQNvdYS
IcT2bcMir6teRIQtgK8igyuRfQu7MGo03aHPXEGBHhGQXbXeaTAbRYIHRFdW0PhY
tH75uCSD75Zs6dSdzxzaurLCRZTMWI3bRPri36upAMj7er5YHRcIdCO/vXGldAQb
xEvj4DYTvd9fVARsiu883m07nx8nIbmBBdRo8BbGPSTUjfuWhW1LzIHS/37JQo2s
6RsVqY/aS8iNURtfVwlNBmzFsrhdPpefQwUKzzugwQ7GaIr6dhF/tn9zVEhw2oxI
bg4cAVhwpbBEIlSYDQSKErwPlvkwZSv4etyUe0tdR2AKyLZiXFGHjuF/L3bupz9u
iTcnurhwXupcVrpH4Y9hL8i8wJQ/xu5TiJ+1KyYK+ZFh1DBjNrc=
=uIYv
-----END PGP SIGNATURE-----

--DKU6Jbt7q3WqK7+M--
