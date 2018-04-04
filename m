Return-Path: <cygwin-patches-return-9046-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 126025 invoked by alias); 4 Apr 2018 09:15:53 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 125966 invoked by uid 89); 4 Apr 2018 09:15:46 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-124.4 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,KAM_NUMSUBJECT,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2 spammy=consult, held, H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.134) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 04 Apr 2018 09:15:45 +0000
Received: from calimero.vinschen.de ([217.91.18.234]) by mrelayeu.kundenserver.de (mreue003 [212.227.15.167]) with ESMTPSA (Nemesis) id 0LhAId-1ehFaE2xaZ-00oTEc for <cygwin-patches@cygwin.com>; Wed, 04 Apr 2018 11:15:41 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 1FCE1A818CB; Wed,  4 Apr 2018 11:15:41 +0200 (CEST)
Date: Wed, 04 Apr 2018 09:15:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Posix asynchronous I/O support, part 3
Message-ID: <20180404091541.GL2833@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20180329053217.1100-1-mark@maxrnd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="J5MfuwkIyy7RmF4Q"
Content-Disposition: inline
In-Reply-To: <20180329053217.1100-1-mark@maxrnd.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-UI-Out-Filterresults: notjunk:1;V01:K0:EJVnKYf2XnI=:3yEID6CbBCh33MG9T5fWX7 GvsPWVeXv4S4bPjfMHW2DsCWF5Bb0ZXsmHla2JZmAzM/5jM4eSdn4GL/01iAV9gsAWsRN82wz iyxFpfZwnlQXQixxWkLdq7eWvWj9bxgDu13b3sGv5i/HrFxdf7YfwHB+lBAU54QjdQp9MmOad wvTSioD8NwuIFDRhk+WDmoqVZqkvyhpnPljhTk5nD9vl8Vf/pv8CrPNlMdd8LG2Xz/e8sRBP0 ZD4I7wxzmFqdKK7ZP+wpXxtdj+KzT0dFUEPVhPAn+YZRPM9XSgXbuTpa7Dpav4RJLcSrPTmLr Khg/12fdm4n0BjyQx8HD1B3b5X1hS6lo3duuJbEdoEEmzjL5crh+X6sMFeZaFry3/dIIHeix/ yz9jfatxN+nOowKCg7OqyhncNElSuoldb5IhJBWmQNI8FdGOKP9qfOOBfH1Vqjf7okj64hREw 0tMnmRIRoLaR1lnI487kpWnEeR9Us+h4Pd4AXCYAMp6a5IBCLnghjx2re1bV/t8soIeaQUcW/ JCzxWnXcyG4GzmPtfsGB11Ek/Zqq7orgArpRzhAwBMGOoh9zhpEC9g/emycj0GgZ0G3REz9Tp 9y2G9JQ7lY1uvdXxYPMlZRz1PvTEQDrQaGmKrG9jDX8bPmATA/ME0x58qZkguhVCw6kYKYYSM JPHVsuNkeZgx6Yh5qfo1E3Dkz3Tz8KSxqJ1fAoIT5su5Z6YVqXVo4bo42ZCwWNZkBi/NX+UJi j3dsKgBry+O4JJfVjpYgLiF/cXE15doThkw9VQ==
X-SW-Source: 2018-q2/txt/msg00003.txt.bz2


--J5MfuwkIyy7RmF4Q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1942

On Mar 28 22:32, Mark Geisert wrote:
> ---
>  winsup/cygwin/aio.cc | 580 +++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 580 insertions(+)
>  create mode 100644 winsup/cygwin/aio.cc

Only scanning for minor stuff for now:

> diff --git a/winsup/cygwin/aio.cc b/winsup/cygwin/aio.cc
> new file mode 100644
> index 000000000..01bf2e479
> --- /dev/null
> +++ b/winsup/cygwin/aio.cc
> @@ -0,0 +1,580 @@
> +/* aio.cc: Posix asynchronous i/o functions.
> +
> +This file is part of Cygwin.
> +
> +This software is a copyrighted work licensed under the terms of the
> +Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
> +details. */
> +
> +#undef AIODEBUG
> +
> +#include "winsup.h"
> +#include <aio.h>
> +#include <fcntl.h>
> +#include <semaphore.h>
> +#include <unistd.h>
> +
> +#ifdef __cplusplus
> +#define restrict /* meaningless in C++ */

Just use __restrict

> +extern "C" {
> +#endif
> +
> +static NO_COPY pid_t         mypid;
> +static NO_COPY sem_t         worksem;   /* indicates whether AIOs are qu=
eued */
> +static NO_COPY struct aiocb *worklisthd =3D NULL;  /* head of pending AI=
O list */
> +static NO_COPY struct aiocb *worklisttl =3D NULL;  /* tail of pending AI=
O list */

May I suggest to use the types and macros from sys/queue.h instead of
implementing queues all by yourself?  TAILQ might be what you're
looking for.

> +static NO_COPY CRITICAL_SECTION  workcrit;      /* lock for pending AIO =
list */
> +
> +#ifdef AIODEBUG
> +static void
> +showqueue ()
> +{
> +  /* critical section 'workcrit' is held on entry */
> +  struct aiocb *aio =3D worklisthd;
> +
> +  small_printf ("%p", aio);

Better use debug_printf here so the debug output is only generated
under strace

Otherwise the code looks pretty neat already.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--J5MfuwkIyy7RmF4Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlrEl7wACgkQ9TYGna5E
T6Ad+Q//VVW4/msjgp6EjOeWnYJWl5vs61A5Y31nV6VhHfxKmkR222dRIla9vX+c
NEyR022aAc/EqSe3x6dPHP78JNj/j6UvY0fYPZVSAD+t/IzBSVDoMg3IvEW7NpyZ
UkrJMVWi3DtRO7b1UPQxL4X8w1bxFbUSY8nktja9plEorKqrRv8dP5euzAyy4Ba7
5/4RH2ctvDUamuzfFXYdnujsfYLRIxIpPc3EEnW0t9ljxOH8VksFgN39Na8i4lvS
cetM57b+wG8cluAWFaAjnLvmQEJB5ebpQcqDza7nh2J8Od9Xnx6HeV06crTpaS2j
NB1pp2zUTN40tUJAU0Tu4FdEQZJRQV3WYe3mblhHruqxRN6c/nrAZZ4+9aFGovWD
IVhBbEmAZJ2txCWgEJgv5r4/7t+LCqLUTZbNGNcNzfE3+e2R7jJKq27h2KRJk3if
JKXPwz66VbZbRU0mvB99kY3H8t8e/fXav7Uj39tDpNBWX281z6MNFv17Ph9NZS1Q
1QVkvSUGZC2uxFXsdd2Gt6aRbLHSsU6YpmDfJB0DYGrbzOmQl1ZMH0bts4R9a98e
EZk41xw77VE7KGopxWZOsdA+4w0qlyfOOQYj1g0YBgqkYbL6K3FtlArZeGRRCls9
542d+I+U7COWNiNWqO2AlKhcRS/PabYf0VdTNyZfAM/gKgs39E8=
=chNJ
-----END PGP SIGNATURE-----

--J5MfuwkIyy7RmF4Q--
