Return-Path: <cygwin-patches-return-9530-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 38584 invoked by alias); 26 Jul 2019 07:11:07 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 38575 invoked by uid 89); 26 Jul 2019 07:11:06 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-109.6 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*f:sk:6ac7173, H*i:sk:6ac7173
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (217.72.192.73) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 26 Jul 2019 07:11:05 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id 1Mgefy-1iKUU90MY8-00h3uP; Fri, 26 Jul 2019 09:10:17 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id D6068A808BB; Fri, 26 Jul 2019 09:10:13 +0200 (CEST)
Date: Fri, 26 Jul 2019 07:11:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Mark Geisert <mark@maxrnd.com>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Implement CPU_SET(3) macros
Message-ID: <20190726071013.GF11632@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Mark Geisert <mark@maxrnd.com>, cygwin-patches@cygwin.com
References: <20190630225904.812-1-mark@maxrnd.com> <20190701073342.GI5738@calimero.vinschen.de> <b84163da-9b09-94bd-3043-7d47a1fffefb@maxrnd.com> <20190725143030.GC11632@calimero.vinschen.de> <6ac71730-75a7-5fa0-bc85-99f00a45c22a@maxrnd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="AH+kv8CCoFf6qPuz"
Content-Disposition: inline
In-Reply-To: <6ac71730-75a7-5fa0-bc85-99f00a45c22a@maxrnd.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q3/txt/msg00050.txt.bz2


--AH+kv8CCoFf6qPuz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2030

On Jul 25 14:15, Mark Geisert wrote:
> Corinna Vinschen wrote:
> > Hi Mark,
> >=20
> > On Jul  1 01:55, Mark Geisert wrote:
> > > Corinna Vinschen wrote:
> > > > On Jun 30 15:59, Mark Geisert wrote:
> > > > > This patch supplies an implementation of the CPU_SET(3) processor
> > > > > affinity macros as documented on the relevant Linux man page.
> > > > > ---
> > > > >    winsup/cygwin/include/sys/cpuset.h | 62 ++++++++++++++++++++++=
+++++---
> > > > >    winsup/cygwin/sched.cc             |  8 ++--
> > > > >    2 files changed, 60 insertions(+), 10 deletions(-)
> > > > > [...]
> > > > > +#define CPU_SETSIZE  1024  // maximum number of logical processo=
rs tracked
> > > > > +#define NCPUBITS     (8 * sizeof (__cpu_mask))  // max size of p=
rocessor group
> > > > > +#define CPU_GROUPMAX (CPU_SETSIZE / NCPUBITS)  // maximum group =
number
> > > > > -#define __CPUELT(cpu)   ((cpu) / __NCPUBITS)
> > > > > -#define __CPUMASK(cpu)  ((__cpu_mask) 1 << ((cpu) % __NCPUBITS))
> > > > > +#define CPU_WORD(cpu) ((cpu) / NCPUBITS)
> > > > > +#define CPU_MASK(cpu) ((__cpu_mask) 1 << ((cpu) % NCPUBITS))
> > > >=20
> > > > I wouldn't do that.  Three problems:
> > > > [...]
> > > > There's also the request from Sebastian on the newlib list to
> > > > consolidate the cpuset stuff from RTEMS and Cygwin into a single
> > > > definition.
> > > > [...]
> > > I've also found that taskset isn't working properly on my build syste=
m with
> > > the new CPU_SET code, though my other testcases are.  So even as subm=
itted,
> > > and fixed per your comments here, there's a bit more to be done.
> > >=20
> > > ..mark
> >=20
> > any chance to pick this up again?
>=20
> Hi; yes, certainly. I'm back but ill.

I hope it's nothing serious.  Please make sure you're getting well
before diving too deep into code again :)

> It may be a week or so before I have
> an update/fix. Top of my list of pending items that require concentration
> ;-).
>=20
> ..mark

Sounds good to me.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--AH+kv8CCoFf6qPuz
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl06p1UACgkQ9TYGna5E
T6Dz+g//RVcE1x3vjJA+HJPFGL5aHcej/CahvctDQ/Z657+18q+8xF53tU+vG742
GeWSjnRNmm4tnWhFszFtSz0HoHMWPhoMDWWidEixBGEU/uQKt7j/mLeCS0Bgnhsb
/T0FjAkyCAgbSStF9P7mvx+7DeXyRMvGMxKb0D6DfHestFKRnmgNXSl0fbOevI+n
785kUBiHL8dKH9vh/VOCBwxOBUhtFJOqGz9PFooTtYC6S1PuY9J/rTnhEJARn3YA
3l8ZoE7yN7m6GzcRJc7TNlF3CIqzPDF+GTjBo5934HhOc6rCB0A6hUQCF6sUaQTT
eIpcvtf5nheg59PRtZDypcGFqTaTxPOy4eU7tinxgy9EiRx29SUQUEKt2uzj44XP
ioIlrfFoEug5eVzpfoUmm0DjOpLcMbzCnp1cOmG6FFict/2iKawXkzHjZtTfB4ym
XvyOig1TD4bkKGawSbW/GgPNsZMAoLrN7EQ47JJEQIj8VvDaFMB173qyJ2QB4WkP
IA8W1umgsUzj1MrKYxJmDfgU86nLa84neGKCd+Ntw5HOJDcihlaV5t6VaB96k+Bv
BuWyjzABP9VrjgCFfrEF41zLLO/nzywSFwIePGL27xrhQ6TUeJGm6/kXx6D8ZcW/
1n3oi0xOFr1EhvKWzFWGa+6jxw0uOz8S6CZ6SCl989+caV5qOxM=
=88FJ
-----END PGP SIGNATURE-----

--AH+kv8CCoFf6qPuz--
