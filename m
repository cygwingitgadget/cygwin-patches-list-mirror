Return-Path: <cygwin-patches-return-9122-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 106158 invoked by alias); 17 Jul 2018 14:51:53 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 106025 invoked by uid 89); 17 Jul 2018 14:51:52 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-105.7 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_1,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2 spammy=asynchronous, interval
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.17.13) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 17 Jul 2018 14:51:50 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue101 [212.227.15.183]) with ESMTPSA (Nemesis) id 0MeBaA-1fOUJR3cBq-00PvJq for <cygwin-patches@cygwin.com>; Tue, 17 Jul 2018 16:51:47 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 60509A80559; Tue, 17 Jul 2018 16:51:46 +0200 (CEST)
Date: Tue, 17 Jul 2018 14:51:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3 1/3] POSIX Asynchronous I/O support: aio files
Message-ID: <20180717145146.GA23667@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20180715082025.4920-1-mark@maxrnd.com> <20180715082025.4920-2-mark@maxrnd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline
In-Reply-To: <20180715082025.4920-2-mark@maxrnd.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SW-Source: 2018-q3/txt/msg00017.txt.bz2


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2507

Hey Mark,

I just belatedly noticed a few problems in aiosuspend:

On Jul 15 01:20, Mark Geisert wrote:
> +static int
> +aiosuspend (const struct aiocb *const aiolist[],
> +         int nent, const struct timespec *timeout)
> +{
> +  /* Returns lowest list index of completed aios, else 'nent' if all com=
pleted.
> +   * If none completed on entry, wait for interval specified by 'timeout=
'.
> +   */
> +  DWORD     msecs =3D 0;
> +  int       res;
> +  sigset_t  sigmask;
> +  siginfo_t si;
> +  DWORD     time0, time1;
     ^^^^^^^^^^^^^^^^^^^^^^^
     see below

> +  struct timespec *to =3D (struct timespec *) timeout;
> +
> +  if (to)
> +    msecs =3D (1000 * to->tv_sec) + ((to->tv_nsec + 999999) / 1000000);

You're not checking the content of timeout for validity, tv_sec >=3D 0 and
0 <=3D tv_nsec <=3D 999999999.

I'm not sure why you break the timespec down to msecs anyway.  The
timespec value is ultimately used for a timer with 100ns resolution.
Why not stick to 64 bit 100ns values instead?  They are used in a
lot of places.

Last but not least, please don't use numbers like 1000 or 999999 or
1000000 when converting time values.  We have macros for that defined
in hires.h:

  /* # of nanosecs per second. */
  #define NSPERSEC (1000000000LL)
  /* # of 100ns intervals per second. */
  #define NS100PERSEC (10000000LL)
  /* # of microsecs per second. */
  #define USPERSEC (1000000LL)
  /* # of millisecs per second. */
  #define MSPERSEC (1000L)

> +  [...]
> +  time0 =3D GetTickCount ();
> +  //XXX Is it possible have an empty signal mask ...

No, because some signals are non-maskable.

> +  //XXX ... and infinite timeout?

Yes, if timeout is a NULL pointer.

> +  res =3D sigtimedwait (&sigmask, &si, to);
> +  if (res =3D=3D -1)
> +    return -1; /* Return with errno set by failed sigtimedwait() */
> +  time1 =3D GetTickCount ();

This is unsafe.  As a 32 bit function GetTickCount wraps around roughly
every 49 days.  Use ULONGLONG GetTickCount64() instead.

> +  /* Adjust timeout to account for time just waited */
> +  msecs -=3D (time1 - time0);
> +  if (msecs < 0)

This can't happen then.

> +  to->tv_sec =3D msecs / 1000;
> +  to->tv_nsec =3D (msecs % 1000) * 1000000;

Uh oh, you're changing caller values, despite timeout being const.
`to' shouldn't be a pointer, but a local struct timespec instead.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAltOAoIACgkQ9TYGna5E
T6BJYQ/7Bg7PZvg4N/Un3QGAf2c82hX5tq4ahGs3SkUwNAkYMgp/edUrs/HDQgaD
QLg0BSqo/2+sK0ziuQtE4lMbiba/wYuJStxiOlo7WI/bY6avFy53C3TUG8uc7w/Y
U3fl0m/sp1vCpkgpFbZewV6swbQyuJzJdaRSxp7npCfYim6d4zoc3ybBYYF+5rv5
9pYcZ31V3vnlNQqsUEeS/JGR5uCprGp0CUuuqdl13Qd53vu6Xjs01AAbVJVrcXZA
fH+T/Uide7fD163y/ELTiEdEsKxg5vzVP5MLKSrDVeiRjlkXl88LclLoEc+48mts
RaB7PEqbCT2gjfFMKM3sAR9LKvgZFRf05vwDful7tfsITd0hIJVaWyQJ/vDPkm7W
sAWlZWrS1oeHSqmUJ2IDT1LeJyiUsolOeD68QZ36hN8B8cwtjvqDLNroLPAafkBs
cZW9JFC1qjIdRoNwQLL+uN0ijRJBu0nr/yCW2Iw0kmFqZEq0jiD38JR33UXP7KDj
hFI8d/cM+0xJfV2kAuQMqNBJvNgY87YVvpep08TBEImQKzeEt2oESUbCIndx8bcw
Lkfev3mkeq9lcPGIT0RD7jMH+MSzglxrYdlvIirquwTpp/bbmcL62J9ng+3+ZNpH
CehpRGHSawQikmVlXM91wLrxOReh31stySHMK6y5X/ZIHxv4pes=
=Xyr0
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--
