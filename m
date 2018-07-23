Return-Path: <cygwin-patches-return-9135-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8611 invoked by alias); 23 Jul 2018 12:59:59 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 8597 invoked by uid 89); 23 Jul 2018 12:59:58 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-123.9 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2 spammy=Cygwin, POSIX, mails, completed
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.187) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 23 Jul 2018 12:59:56 +0000
Received: from calimero.vinschen.de ([217.91.18.234]) by mrelayeu.kundenserver.de (mreue002 [212.227.15.167]) with ESMTPSA (Nemesis) id 0MDYoX-1fmqBA2n6L-00Gr5S for <cygwin-patches@cygwin.com>; Mon, 23 Jul 2018 14:59:53 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id AF08DA809C3; Mon, 23 Jul 2018 14:59:52 +0200 (CEST)
Date: Mon, 23 Jul 2018 12:59:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v4 1/2] POSIX Asynchronous I/O support: aio files
Message-ID: <20180723125952.GA3312@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20180716142128.GZ27673@calimero.vinschen.de> <20180717145146.GA23667@calimero.vinschen.de> <20180720084416.4256-1-mark@maxrnd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
In-Reply-To: <20180720084416.4256-1-mark@maxrnd.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SW-Source: 2018-q3/txt/msg00030.txt.bz2


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 3113

Hi Mark,

there's just one problem left:

On Jul 20 01:44, Mark Geisert wrote:
> This is the core of the AIO implementation: aio.cc and aio.h.  The
> latter is used within the Cygwin DLL by aio.cc and the fhandler* modules,
> as well as by user programs wanting the AIO functionality.
> ---
>  winsup/cygwin/aio.cc        | 1006 +++++++++++++++++++++++++++++++++++
>  winsup/cygwin/include/aio.h |   82 +++
>  2 files changed, 1088 insertions(+)
>  create mode 100644 winsup/cygwin/aio.cc
>  create mode 100644 winsup/cygwin/include/aio.h
>=20
> diff --git a/winsup/cygwin/aio.cc b/winsup/cygwin/aio.cc
> new file mode 100644
> index 000000000..0244edf60
> --- /dev/null
> +++ b/winsup/cygwin/aio.cc
> [...]
> +static int
> +aiosuspend (const struct aiocb *const aiolist[],
> +         int nent, const struct timespec *timeout)
> +{
> +  /* Returns lowest list index of completed aios, else 'nent' if all com=
pleted.
> +   * If none completed on entry, wait for interval specified by 'timeout=
'.
> +   */
> +  int       res;
> +  sigset_t  sigmask;
> +  siginfo_t si;
> +  ULONGLONG ticks =3D 0;
> +  ULONGLONG time0, time1;
> +  struct timespec to =3D {0};
> +
> +  if (timeout)
> +    {
> +      to =3D *timeout;
> +      if (to.tv_sec < 0 || to.tv_nsec < 0 || to.tv_nsec > NSPERSEC)
> +        {
> +          set_errno (EINVAL);
> +          return -1;
> +        }
> +      ticks =3D (NS100PERSEC * to.tv_sec) +
> +              ((to.tv_nsec + (NSPERSEC/NS100PERSEC) - 1) /
> +                             (NSPERSEC/NS100PERSEC));
> +    }
> +
> +retry:
> +  sigemptyset (&sigmask);
> +  int aiocount =3D 0;
> +  for (int i =3D 0; i < nent; ++i)
> +    if (aiolist[i] && aiolist[i]->aio_liocb)
> +      {
> +        if (aiolist[i]->aio_errno =3D=3D EINPROGRESS ||
> +            aiolist[i]->aio_errno =3D=3D ENOBUFS ||
> +            aiolist[i]->aio_errno =3D=3D EBUSY)
> +          {
> +            ++aiocount;
> +            if (aiolist[i]->aio_sigevent.sigev_notify =3D=3D SIGEV_SIGNA=
L ||
> +                aiolist[i]->aio_sigevent.sigev_notify =3D=3D SIGEV_THREA=
D)
> +              sigaddset (&sigmask, aiolist[i]->aio_sigevent.sigev_signo);
> +          }
> +        else
> +          return i;
> +      }
> +
> +  if (aiocount =3D=3D 0)
> +    return nent;
> +
> +  if (timeout && ticks =3D=3D 0)
> +    {
> +      set_errno (EAGAIN);
> +      return -1;
> +    }
> +
> +  QueryUnbiasedInterruptTime (&time0);

Nice idea to use QueryUnbiasedInterruptTime.  The problem here is just
that QueryUnbiasedInterruptTime has been introduced with Windows 7, but
we still support Windows Vista :}

We could just drop Vista support (is anybody actually using it?) but
there's an alternative: Include hires.h and use ntod, a global ns
counter object using Windows performance counters under the hood:

  #include "hires.h"

  time0 =3D ntod.nsecs ();  /* ns, *not* 100ns */
  ...

With that single change I think your patch series can go in.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAltV0UgACgkQ9TYGna5E
T6Cadg/6AuQVe/Tkz94Wl6nxe3RzPy7ERrWPlysOByq+KoMD+BVm4fb20T3RJKPU
/0weDn/T6UiwFHIXMQjY7/ETMmxz3v4x6YLT3SKdyLHugG63HhFkGJvya+4rvhvN
JNHEgTFTZWKjQqhfriAgkCFK2lFYl04iJrX85i8EGwIjTr7AVtPljZM2Lj3V32nN
LJz2JuzKSHz5is9TCTC2vwhyBQZkWBZm0n2zPzUK7Dy4iX9wqCK2LLJhiI6+YlyZ
e+kdPTt+inpO9WNS0heIkU05X64Nt+aMwCfjb85LpTFPlGo8pcrbJYdwuIsGkFAL
3jw3sz2KJ9JI5A6sqOZgCXPHjARpGSyHFn/PwGgR5Cjo8ndMjCVnVnlHySOTEoET
zJ3/ouaPhliWFovNmYDGxeZTk2PjrBT8WGYNW94DowLMvI6PhdJS5o1n0UBi52Dj
exVPpGJGt+OhnIrDtXcH9Y8qvlXPN4aiXYSCwGOVdCaX+XnMVzXcUOoO7yrFhiHL
41g7cp55W6LijboQ16fLVpZP+ri+qfQfX6UtYf4Ou4XAXjq2csjqBZqyIU/Cq3eq
e0Gn+QompqLBX3idl6C3br/ua+kXbit9l8ew9cZK/B0tB4IDhuaTsCHm574Lyl5H
bLgUSkxwKU8fElNrVAnIYJ+GVrwXZDkB8l6RpiDkO8JAcBNlWuU=
=7bEs
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--
