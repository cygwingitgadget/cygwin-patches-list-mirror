Return-Path: <cygwin-patches-return-9480-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 54638 invoked by alias); 1 Jul 2019 07:34:10 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 54629 invoked by uid 89); 1 Jul 2019 07:34:09 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-117.2 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=Three, newlib, FreeBSD, Geisert
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.135) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 01 Jul 2019 07:34:08 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MfbwW-1iAIsK2wmW-00fx4F; Mon, 01 Jul 2019 09:33:44 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 2B463A80666; Mon,  1 Jul 2019 09:33:42 +0200 (CEST)
Date: Mon, 01 Jul 2019 07:34:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Mark Geisert <mark@maxrnd.com>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Implement CPU_SET(3) macros
Message-ID: <20190701073342.GI5738@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Mark Geisert <mark@maxrnd.com>, cygwin-patches@cygwin.com
References: <20190630225904.812-1-mark@maxrnd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="g3W8FGNyQaC+nhss"
Content-Disposition: inline
In-Reply-To: <20190630225904.812-1-mark@maxrnd.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q3/txt/msg00000.txt.bz2


--g3W8FGNyQaC+nhss
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2274

Hi Mark,

On Jun 30 15:59, Mark Geisert wrote:
> This patch supplies an implementation of the CPU_SET(3) processor
> affinity macros as documented on the relevant Linux man page.
> ---
>  winsup/cygwin/include/sys/cpuset.h | 62 +++++++++++++++++++++++++++---
>  winsup/cygwin/sched.cc             |  8 ++--
>  2 files changed, 60 insertions(+), 10 deletions(-)
>=20
> diff --git a/winsup/cygwin/include/sys/cpuset.h b/winsup/cygwin/include/s=
ys/cpuset.h
> index 4857b879d..9c8417b73 100644
> --- a/winsup/cygwin/include/sys/cpuset.h
> +++ b/winsup/cygwin/include/sys/cpuset.h
> @@ -14,20 +14,70 @@ extern "C" {
>  #endif
>=20=20
>  typedef __SIZE_TYPE__ __cpu_mask;
> -#define __CPU_SETSIZE 1024  // maximum number of logical processors trac=
ked
> -#define __NCPUBITS (8 * sizeof (__cpu_mask))  // max size of processor g=
roup
> -#define __CPU_GROUPMAX (__CPU_SETSIZE / __NCPUBITS)  // maximum group nu=
mber
> +#define CPU_SETSIZE  1024  // maximum number of logical processors track=
ed
> +#define NCPUBITS     (8 * sizeof (__cpu_mask))  // max size of processor=
 group
> +#define CPU_GROUPMAX (CPU_SETSIZE / NCPUBITS)  // maximum group number
>=20=20
> -#define __CPUELT(cpu)   ((cpu) / __NCPUBITS)
> -#define __CPUMASK(cpu)  ((__cpu_mask) 1 << ((cpu) % __NCPUBITS))
> +#define CPU_WORD(cpu) ((cpu) / NCPUBITS)
> +#define CPU_MASK(cpu) ((__cpu_mask) 1 << ((cpu) % NCPUBITS))

I wouldn't do that.  Three problems:

- The non-underscored definitions should only be exposed #if __GNU_VISIBLE
  because otherwise they clutter the application namespace.

- CPU_WORD and CPU_MASK don't exist at all in glibc, so I don't see
  why you rename __CPUELT and __CPUMASK at all.

- CPU_GROUPMAX does not exist in glibc either. As a non-standard
  macro it should be kept underscored.

Keep (and use) the underscored variations throughout, and only expose
the non-underscored macro set #if __GNU_VISIBLE.

There's also the request from Sebastian on the newlib list to
consolidate the cpuset stuff from RTEMS and Cygwin into a single
definition.  It's not exactly straightforward given the different
definition of cpuset_t from FreeBSD, but it's probably not very
complicated either.  Maybe something for after your vaca?


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--g3W8FGNyQaC+nhss
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl0Zt1UACgkQ9TYGna5E
T6AM8Q/+OkBnaGc6AvZfpX89eREL2LPdvAnWQrUd9N9nRvMqZuB+hD9OVuh0wGtg
b11AdcVLoDt5kEzZhAiG6qkchtZ6BOUXZzhTkhYyBEvSBAt1sYMWxyi1u3Q6WaTZ
qUWAlEAUt2FekC+KUoRZCSUm6MzT9BT1Hk9g5GUZWxQNkYDoObIxXisjfSOJB27H
yWvaQV33EvkxnxLHo3ARKMQYNuWGMkg26KQgOfGhCV3shrPdcH/A9eIPCEkCtihS
OrBTr2YFAfQtULVRB8O5wgAtz4a1Q2SpQhklQ3i/DGwl/gZjLSOFFV5zokWoHcgA
F1n53U+TrZNDWekOfvgVMgkdwTXbaoh1ERO7s0+yiqZTceegjgpOKS4Z0kF0WszY
PAAlF2V/ZshgaRgMprnxExbdsE+Q8xk/vNV7WJAskuasv3NtFrD1rw5ucFCzwSnC
77EczYyVrlgA/7nLLlqk2XD7hwy4jAg30SL40wNB6EwMUymXixqIZGJ+SbRejtuA
5Oer07EswRr3wTygVbfTu4LEG7tjtpqfp7npvdUoBsCuWMhXiDtDmJ+3KKqFenwW
tmQW6NnY9jH7cHtKpCJKJEbqMd1TEVICrZ6Ydyi74j8k7Oc5Nn1VvqZ1ROMHS9Zn
gzDV3c03TKR49PJjg6pla8fSKwNfOBprUK10z3KLgIQqEq+HRU4=
=ttc2
-----END PGP SIGNATURE-----

--g3W8FGNyQaC+nhss--
