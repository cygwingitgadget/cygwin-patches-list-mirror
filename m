Return-Path: <cygwin-patches-return-10124-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 64395 invoked by alias); 26 Feb 2020 11:16:24 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 64092 invoked by uid 89); 26 Feb 2020 11:16:19 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-119.2 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.131) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 26 Feb 2020 11:16:17 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id 1M8hlZ-1j2lnr0s0v-004fwf for <cygwin-patches@cygwin.com>; Wed, 26 Feb 2020 12:16:14 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id F0077A82772; Wed, 26 Feb 2020 12:16:13 +0100 (CET)
Date: Wed, 26 Feb 2020 11:16:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] cpuinfo:power management: add proc_feedback, acc_power
Message-ID: <20200226111613.GT4045@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200225234415.37317-1-Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="h22Fi9ANawrtbNPX"
Content-Disposition: inline
In-Reply-To: <20200225234415.37317-1-Brian.Inglis@SystematicSW.ab.ca>
X-SW-Source: 2020-q1/txt/msg00230.txt


--h22Fi9ANawrtbNPX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1551

On Feb 25 16:44, Brian Inglis wrote:
> linux 4.6 x86/cpu: Add advanced power management bits
> Bit 11 of CPUID 8000_0007 edx is processor feedback interface.
> Bit 12 of CPUID 8000_0007 edx is accumulated power.
>=20
> Print proper names in /proc/cpuinfo
>=20
> [missed enabling this 2016 change during previous major cpuinfo update
> as no power related changes were made to the Linux files since then]
> ---
>  winsup/cygwin/fhandler_proc.cc | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/winsup/cygwin/fhandler_proc.cc b/winsup/cygwin/fhandler_proc=
.cc
> index 030ade68a..605a8443f 100644
> --- a/winsup/cygwin/fhandler_proc.cc
> +++ b/winsup/cygwin/fhandler_proc.cc
> @@ -1397,8 +1397,8 @@ format_proc_cpuinfo (void *, char *&destbuf)
>  /*	  ftcprint (features1,  8, "invariant_tsc"); */ /* TSC invariant */
>  	  ftcprint (features1,  9, "cpb");          /* core performance boost */
>  	  ftcprint (features1, 10, "eff_freq_ro");  /* ro eff freq interface */
> -/*	  ftcprint (features1, 11, "proc_feedback"); */ /* proc feedback if */
> -/*	  ftcprint (features1, 12, "acc_power"); */ /* core power reporting */
> +	  ftcprint (features1, 11, "proc_feedback");/* proc feedback if */
> +	  ftcprint (features1, 12, "acc_power");    /* core power reporting */
>  /*	  ftcprint (features1, 13, "connstby"); */  /* connected standby */
>  /*	  ftcprint (features1, 14, "rapl"); */	    /* running average power l=
imit */
>  	}
> --=20
> 2.21.0

Pushed.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--h22Fi9ANawrtbNPX
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl5WU30ACgkQ9TYGna5E
T6A8tg//eUnbqGLKosnf7L4e3ydcy879l1yVP23L7oTTWjsF5MJW2m7RqqRARH+A
/McwhizMBm5/HOOYJH2TjYcPdf5Xef1FpkCV8NqBTOrrOkjyy4RS5k1jdPkGAZE3
yzEnyfz5IVl4DItuu4iDYo4uqf8Eka011igrCOtEiGBU9c9OroGSOSWS5Zc9Qdpn
RBooHbINmFKMlouSzRjK+g2Wl78jOwDyk8CHbWmcLlJFI4Jdw1pa36KYSb5GxLb5
N7RjZ2r9AD1CzrbxhZy5JbkBeHf8okY8LvHhXNeaiVmNQ+Vukx4iwMV8444Kf2+6
sLC7vobg2avBJnTvqrel/AAhZ9x4e9pcCGfqhVwhbz6NzDqGBaJ1qpuV5Xn6ejpT
u6RYlfZKfBSPn0KTA4smYyipHxZi26nkvw0VK46pIxSuqR9zbjWOiBexI3ZxK0FX
R3i5kkKWciylY6FmXP/AQe9yiVX4nc5ZjAUS2HNgmU1TQQ9yY8V9X20bpb0wwAi6
eFAKXI5OGKBzKXrcRbmTwe2x/uBzLbl1bFSkWptMBr1EO/avw6xKKHeOaZS9NRul
/ehXL6TSmuM3k79VYwW9q1rgEnhhxuTz2UlfWxswK9xGcHZMJAGoWEewN62ixjhM
nxKmJs+cBtZ0xf9adbNWPwoFQ+CjrO7oBbk56FnCIfOTlzO5wnQ=
=jDk+
-----END PGP SIGNATURE-----

--h22Fi9ANawrtbNPX--
