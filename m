Return-Path: <cygwin-patches-return-9526-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 113108 invoked by alias); 25 Jul 2019 14:31:26 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 113004 invoked by uid 89); 25 Jul 2019 14:31:25 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-112.4 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.17.24) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 25 Jul 2019 14:31:24 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id 1Mq2Wi-1iD1ER0ovS-00nDBQ; Thu, 25 Jul 2019 16:30:33 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 2653DA8090E; Thu, 25 Jul 2019 16:30:30 +0200 (CEST)
Date: Thu, 25 Jul 2019 14:31:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Mark Geisert <mark@maxrnd.com>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Implement CPU_SET(3) macros
Message-ID: <20190725143030.GC11632@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Mark Geisert <mark@maxrnd.com>, cygwin-patches@cygwin.com
References: <20190630225904.812-1-mark@maxrnd.com> <20190701073342.GI5738@calimero.vinschen.de> <b84163da-9b09-94bd-3043-7d47a1fffefb@maxrnd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="OBd5C1Lgu00Gd/Tn"
Content-Disposition: inline
In-Reply-To: <b84163da-9b09-94bd-3043-7d47a1fffefb@maxrnd.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q3/txt/msg00046.txt.bz2


--OBd5C1Lgu00Gd/Tn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1516

Hi Mark,

On Jul  1 01:55, Mark Geisert wrote:
> Corinna Vinschen wrote:
> > On Jun 30 15:59, Mark Geisert wrote:
> > > This patch supplies an implementation of the CPU_SET(3) processor
> > > affinity macros as documented on the relevant Linux man page.
> > > ---
> > >   winsup/cygwin/include/sys/cpuset.h | 62 +++++++++++++++++++++++++++=
---
> > >   winsup/cygwin/sched.cc             |  8 ++--
> > >   2 files changed, 60 insertions(+), 10 deletions(-)
> > > [...]
> > > +#define CPU_SETSIZE  1024  // maximum number of logical processors t=
racked
> > > +#define NCPUBITS     (8 * sizeof (__cpu_mask))  // max size of proce=
ssor group
> > > +#define CPU_GROUPMAX (CPU_SETSIZE / NCPUBITS)  // maximum group numb=
er
> > > -#define __CPUELT(cpu)   ((cpu) / __NCPUBITS)
> > > -#define __CPUMASK(cpu)  ((__cpu_mask) 1 << ((cpu) % __NCPUBITS))
> > > +#define CPU_WORD(cpu) ((cpu) / NCPUBITS)
> > > +#define CPU_MASK(cpu) ((__cpu_mask) 1 << ((cpu) % NCPUBITS))
> >=20
> > I wouldn't do that.  Three problems:
> > [...]
> > There's also the request from Sebastian on the newlib list to
> > consolidate the cpuset stuff from RTEMS and Cygwin into a single
> > definition.
> > [...]
> I've also found that taskset isn't working properly on my build system wi=
th
> the new CPU_SET code, though my other testcases are.  So even as submitte=
d,
> and fixed per your comments here, there's a bit more to be done.
>=20
> ..mark

any chance to pick this up again?


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--OBd5C1Lgu00Gd/Tn
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl05vQUACgkQ9TYGna5E
T6DbDg//U4Ur8WWc9Z5XTw24hp0NfubRkCqBjcCJilnxBrlQMVd4mXNBr+NbVR97
9hatk3h213tX6QZZPclpjSzUqPyt2Rrx3NK9dqi2Dyd4ojzbkV2kT/p4PRP4TdHc
ghGC5Nq7G7IyKjuBD3GRH2asZ1wu9OtQKswtJyU/Og6m1lPCTa8HLNv37CjXjynE
f1xFLL++Yu8mNUKsu8C+MPBBrARMoyiautvrdy7fZcH9zuFPcWlZDQXBWdEsmFwK
ZgIn/AlfpQ2BGMlG38O/CoF07NW6esrYVolm5XUDXGz0LcVJjZCpy5f8DjKZ5/EW
y67FSRvnZSNyPjXvSNvGialIMh+V5+b4+T53vOuGFGUM1N2pRASipCARyYMHtk3h
o8FnKbjxP2+FyAQOs2ZxmdlJ8A2EFcOGr/4ocMj4e2nO1Ts0PmlL5ztzIDlvsyZd
2rJGrg3r0v4EKABFBrrltgqiSKX4GUe7d3kYQLT2IEJcKkz2Z/JyuAq2ugEi5/Ps
jFyxxKoq7RlE12AZYsnGc+DYQKlDfO8g1KUwfSBx1pxeg2VD6xIJs98ocR72HKPW
E+C6o88pLFW2cioTV4Wi19xtiiwVFzlfDXUaNtjXs1d5C/0LQovBLiJoAwq+Mvjw
eommtui3+WJwYsmVN1gZWfyhu4wjjckUBEfBzm7RbUvqsMhSecI=
=VTT7
-----END PGP SIGNATURE-----

--OBd5C1Lgu00Gd/Tn--
