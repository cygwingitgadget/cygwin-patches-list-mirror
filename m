Return-Path: <cygwin-patches-return-8717-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22084 invoked by alias); 20 Mar 2017 10:37:22 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 22040 invoked by uid 89); 20 Mar 2017 10:37:20 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-124.2 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=w32api-headers, w32apiheaders, HTo:U*cygwin-patches, D*org.uk
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 20 Mar 2017 10:37:19 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id AEBD9721E280C;	Mon, 20 Mar 2017 11:37:16 +0100 (CET)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id 0CFF35E049E;	Mon, 20 Mar 2017 11:37:16 +0100 (CET)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id DECE3A80CF2; Mon, 20 Mar 2017 11:37:15 +0100 (CET)
Date: Mon, 20 Mar 2017 10:37:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Cc: JonY <10walls@gmail.com>
Subject: Re: [PATCH] Implement getloadavg()
Message-ID: <20170320103715.GH16777@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com, JonY <10walls@gmail.com>
References: <20170317175032.26780-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="7cm2iqirTL37Ot+N"
Content-Disposition: inline
In-Reply-To: <20170317175032.26780-1-jon.turney@dronecode.org.uk>
User-Agent: Mutt/1.8.0 (2017-02-23)
X-SW-Source: 2017-q1/txt/msg00058.txt.bz2


--7cm2iqirTL37Ot+N
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2751

Hi Jon,

neat!  But...

On Mar 17 17:50, Jon Turney wrote:
> Signed-off-by: Jon Turney <jon.turney@dronecode.org.uk>
> ---
>  winsup/cygwin/Makefile.in              |   5 +-
>  winsup/cygwin/common.din               |   1 +
>  winsup/cygwin/fhandler_proc.cc         |  10 ++-
>  winsup/cygwin/include/cygwin/stdlib.h  |   4 +
>  winsup/cygwin/include/cygwin/version.h |   3 +-
>  winsup/cygwin/loadavg.cc               | 135 +++++++++++++++++++++++++++=
++++++
>  winsup/doc/posix.xml                   |   1 +
>  7 files changed, 154 insertions(+), 5 deletions(-)
>  create mode 100644 winsup/cygwin/loadavg.cc
>=20
> diff --git a/winsup/cygwin/Makefile.in b/winsup/cygwin/Makefile.in
> index c8652b0..5e719a6 100644
> --- a/winsup/cygwin/Makefile.in
> +++ b/winsup/cygwin/Makefile.in
> @@ -147,7 +147,9 @@ EXTRA_OFILES:=3D
>=20=20
>  MALLOC_OFILES:=3Dmalloc.o
>=20=20
> -DLL_IMPORTS:=3D${shell $(CC) -print-file-name=3Dw32api/libkernel32.a} ${=
shell $(CC) -print-file-name=3Dw32api/libntdll.a}
> +DLL_IMPORTS:=3D${shell $(CC) -print-file-name=3Dw32api/libkernel32.a} \
> +	${shell $(CC) -print-file-name=3Dw32api/libntdll.a} \
> +	${shell $(CC) -print-file-name=3Dw32api/libpdh.a}

No, that's not right.  Please add the new functions to autoload.cc and
drop static linking to libpdh.a.

> +static double _loadavg[3] =3D { 0.0, 0.0, 0.0 };

The load average is global, non-critical data.  So what about storing it
in shared_info instead?  This way, only the first call of the first
Cygwin process returns all zero.

> +static bool load_init (void)
> +{
> +  static bool tried =3D false;
> +  static bool initialized =3D false;
> +
> +  if (!tried) {
> +    tried =3D true;
> +
> +    if ((PdhOpenQueryA (NULL, 0, &query) =3D=3D ERROR_SUCCESS) &&
> +	(PdhAddEnglishCounterA (query, "\\Processor(_Total)\\% Processor Time",
> +				0, &counter1) =3D=3D ERROR_SUCCESS) &&
> +	(PdhAddEnglishCounterA (query, "\\System\\Processor Queue Length",
> +				0, &counter2) =3D=3D ERROR_SUCCESS)) {
> +      initialized =3D true;
> +    } else {
> +      debug_printf("loadavg PDH initialization failed\n");
> +    }
> +  }
> +
> +  return initialized;
> +}

How slow is that initialization?  Would it {make sense|hurt} to call it
once in the initalization of Cygwin's shared mem in shared_info::initialize?

As for the declaration problem on x86, what about moving the declarations
to the start of loadavg.cc, until we get a new w32api-headers package?

JonY, any chance for a quick update of w32api-headers to include the
patch from https://sourceforge.net/p/mingw-w64/mailman/message/35727667/?


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--7cm2iqirTL37Ot+N
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYz7DbAAoJEPU2Bp2uRE+gCewQAKHG4TJGuvL9qVb/+7imN+rB
s4v/QEJcdS29uGN/Bd7GH4Dchs0wcT86moftCIzU2Uqid+nhiZqdGVp+mgI8vDoE
5xeSIf8X0HOSJz4qFM3uD+gey5s9VOJkvN9OKyQ/1louC85a9jgsAulkLEZMxI9Q
OLSqxXIVa2hmPfCip+T4wthNefrzcJbBnj0OxZMMLiZJ/UPy9Us78DTPar/fCLYn
09IegRR033XPIrtVdEB4eulzCA4KHCXPs1dCEndaTKUNV9PSpcnkUzSJByICauNZ
yU3qruRNffyf7kP0ZzSw703U6Y+aFmPUCuQkF4FI4BMkGXu5dwSrACTOURctPaT9
H3lhzrKa488umSiYRPPwn9tJSJR73w7MANizP2SeyV2R2m2fxaHKWLIFQ5gPI/rw
g46Kv7VH90mszviRD13rd9mDO0qwETZTadJVwr2c6FhmhNeBKPQfBl6CzW/Sx1OE
OHZYkxg2lRUMaZNyg2XmTox+yju1ojWp5z7TTNnQeGUF0eIDKsQNEhlQlRgyIiZ2
H8oFAjhnGr4WfRoUHMJkJXf2Iedpujsjneg73bs/Z25YzV6TwxTzbipzEcH3rKTM
LEOMNOPWfb5A7qclSFVIvy2n0cDpaH9eQvDXS9bq+k82kneeCxbArdlLb55zpEZT
BL3abmBYx/px1ttoeOww
=Capi
-----END PGP SIGNATURE-----

--7cm2iqirTL37Ot+N--
