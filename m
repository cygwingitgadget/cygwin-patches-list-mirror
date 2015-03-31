Return-Path: <cygwin-patches-return-8096-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 116610 invoked by alias); 31 Mar 2015 19:11:50 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 116599 invoked by uid 89); 31 Mar 2015 19:11:50 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-5.9 required=5.0 tests=AWL,BAYES_00 autolearn=ham version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 31 Mar 2015 19:11:49 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id E06F6A80A3F; Tue, 31 Mar 2015 21:11:45 +0200 (CEST)
Date: Tue, 31 Mar 2015 19:11:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 3/3] Add cygwin_internal() operation to convert siginfo_t * to EXCEPTION_RECORD *
Message-ID: <20150331191145.GE15852@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1427824014-19504-1-git-send-email-jon.turney@dronecode.org.uk> <1427824014-19504-4-git-send-email-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;	protocol="application/pgp-signature"; boundary="h56sxpGKRmy85csR"
Content-Disposition: inline
In-Reply-To: <1427824014-19504-4-git-send-email-jon.turney@dronecode.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2015-q1/txt/msg00051.txt.bz2


--h56sxpGKRmy85csR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2288

On Mar 31 18:46, Jon TURNEY wrote:
> 	* external.cc (cygwin_internal): Add operation to convert
> 	siginfo_t * to EXCEPTION_RECORD *.
> 	* include/sys/cygwin.h (cygwin_getinfo_types): Ditto.
> 	* exception.h (cygwin_exception): Add exception_record accessor.


> diff --git a/winsup/cygwin/external.cc b/winsup/cygwin/external.cc
> index 5fac4bb..3c6bab2 100644
> --- a/winsup/cygwin/external.cc
> +++ b/winsup/cygwin/external.cc
> @@ -27,6 +27,7 @@ details. */
>  #include "environ.h"
>  #include "cygserver_setpwd.h"
>  #include "pwdgrp.h"
> +#include "exception.h"
>  #include <unistd.h>
>  #include <stdlib.h>
>  #include <wchar.h>
> @@ -688,6 +689,18 @@ cygwin_internal (cygwin_getinfo_types t, ...)
>  	res =3D 0;
>  	break;
>=20=20
> +      case CW_EXCEPTION_RECORD_FROM_SIGINFO_T:
> +	{
> +	  siginfo_t *si =3D va_arg(arg, siginfo_t *);
> +	  res =3D 0;
> +	  if (si && si->si_cyg)
> +	    {
> +	      EXCEPTION_RECORD *er =3D ((cygwin_exception *)si->si_cyg)->except=
ion_record();
> +	      res =3D (uintptr_t)er;
> +	    }
> +	}
> +	break;

I would prefer if CW_EXCEPTION_RECORD_FROM_SIGINFO_T takes a buffer
address as additional parameter and then memcpy's the EXCEPTION_RECORD
over to this address.  This decouples the EXCEPTION_RECORDs in Cygwin
from the one in the application and no side is huffy if the other side
changes the contents.

> diff --git a/winsup/cygwin/include/sys/cygwin.h b/winsup/cygwin/include/s=
ys/cygwin.h
> index edfcc56..13f9866 100644
> --- a/winsup/cygwin/include/sys/cygwin.h
> +++ b/winsup/cygwin/include/sys/cygwin.h
> @@ -1,3 +1,4 @@
> +
>  /* sys/cygwin.h
>=20=20
>     Copyright 1997, 1998, 2000, 2001, 2002, 2003, 2004, 2005, 2006, 2007,=
 2008,
> @@ -153,7 +154,8 @@ typedef enum
>      CW_CYGNAME_FROM_WINNAME,
>      CW_FIXED_ATEXIT,
>      CW_GETNSS_PWD_SRC,
> -    CW_GETNSS_GRP_SRC
> +    CW_GETNSS_GRP_SRC,
> +    CW_EXCEPTION_RECORD_FROM_SIGINFO_T,
>    } cygwin_getinfo_types;
>=20=20
>  #define CW_LOCK_PINFO CW_LOCK_PINFO

There's a

#define CW_EXCEPTION_RECORD_FROM_SIGINFO_T CW_EXCEPTION_RECORD_FROM_SIGINFO=
_T

missing here.  With these changes, ok to apply.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--h56sxpGKRmy85csR
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVGvFxAAoJEPU2Bp2uRE+gQlIP/2QsJTXgd0zCigwYkCGpKRU6
h5mdUKbpLHk4q6XjKo4ltbs9KJaM/e6NzgnQ/njd104rHkkBjNlmPKr0p5PcdXMH
pJltNzg2JUUUsXZa6gMkKI2dmxWcj+MLkYWZR0OX7T9PJUvz2N+MkFiMPDOT6m8K
DVyGMsw4HmVadm5z0XqzaAu88snV8UDO3JpuT7pIaoG6hZ8anOfv7Zax1pzn9xmq
V10w63JYpeKyewa86D65f8zLLgfeccCv57bHs+zIwyXEx0xBB3EIAg6kPtTd6mih
Uo8mDpcfILKjyq3vPqJrZpOd7Fk9Yz1cNNMB62M/O9F7eYEm6bx/Mr70eZsljzpT
bh0K6fGoMpXck0Qnw2PBPBm2QvfhhNwTU/qDJP+QQhkYrQOqdnwnb/BNn0UTWDcN
OT7ihFWTbCHhvH6jap2/xZFlUHloNupi9RI6R9h6z9yWtv1r/hsZm5AHUlilxWLM
kP7Hr4f249F6KmGQ2xnZtS2vxpm/bNalN6UaboROsTRBKyDCtoe5nfbOJTp9vruI
6t1OEWpmLzwmH6PTGMWnn3D1wG3nXO79zRWPpQybm3yyFH0H+NJS1tNBx2e+f4Oh
Kxyl1bCb7fg5WpVTnCO20O0qbYz/CxOo0IFZI8qbNOUzr0sXEP6YJu1gz0YzmM3g
slPNX9AbJ2OpQOgaBCGp
=uBuw
-----END PGP SIGNATURE-----

--h56sxpGKRmy85csR--
