Return-Path: <cygwin-patches-return-9532-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 45353 invoked by alias); 30 Jul 2019 12:13:07 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 45344 invoked by uid 89); 30 Jul 2019 12:13:06 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-107.4 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=PS, P.S, UD:P.S, ps
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.134) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 30 Jul 2019 12:13:05 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id 1M72bv-1i0wud3zgN-008eCC; Tue, 30 Jul 2019 14:12:17 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 1660BA80668; Tue, 30 Jul 2019 14:12:12 +0200 (CEST)
Date: Tue, 30 Jul 2019 12:13:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Mark Geisert <mark@maxrnd.com>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Implement CPU_SET(3) macros
Message-ID: <20190730121212.GV11632@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Mark Geisert <mark@maxrnd.com>, cygwin-patches@cygwin.com
References: <20190630225904.812-1-mark@maxrnd.com> <20190701073342.GI5738@calimero.vinschen.de> <b84163da-9b09-94bd-3043-7d47a1fffefb@maxrnd.com> <20190725143030.GC11632@calimero.vinschen.de> <6ac71730-75a7-5fa0-bc85-99f00a45c22a@maxrnd.com> <20190726071013.GF11632@calimero.vinschen.de> <Pine.BSF.4.63.1907300211260.83956@m0.truegem.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="K3vkeaB0MlFjg8U+"
Content-Disposition: inline
In-Reply-To: <Pine.BSF.4.63.1907300211260.83956@m0.truegem.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q3/txt/msg00052.txt.bz2


--K3vkeaB0MlFjg8U+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 3997

On Jul 30 02:25, Mark Geisert wrote:
> On Fri, 26 Jul 2019, Corinna Vinschen wrote:
> > On Jul 25 14:15, Mark Geisert wrote:
> > > Corinna Vinschen wrote:
> > > > Hi Mark,
> > > >=20
> > > > On Jul  1 01:55, Mark Geisert wrote:
> > > > > Corinna Vinschen wrote:
> > > > > > On Jun 30 15:59, Mark Geisert wrote:
> > > > > > > This patch supplies an implementation of the CPU_SET(3) proce=
ssor
> > > > > > > affinity macros as documented on the relevant Linux man page.
> > > > > > > ---
> > > > > > >    winsup/cygwin/include/sys/cpuset.h | 62 ++++++++++++++++++=
+++++++++---
> > > > > > >    winsup/cygwin/sched.cc             |  8 ++--
> > > > > > >    2 files changed, 60 insertions(+), 10 deletions(-)
> > > > > > > [...]
> > > > > > > +#define CPU_SETSIZE  1024  // maximum number of logical proc=
essors tracked
> > > > > > > +#define NCPUBITS     (8 * sizeof (__cpu_mask))  // max size =
of processor group
> > > > > > > +#define CPU_GROUPMAX (CPU_SETSIZE / NCPUBITS)  // maximum gr=
oup number
> > > > > > > -#define __CPUELT(cpu)   ((cpu) / __NCPUBITS)
> > > > > > > -#define __CPUMASK(cpu)  ((__cpu_mask) 1 << ((cpu) % __NCPUBI=
TS))
> > > > > > > +#define CPU_WORD(cpu) ((cpu) / NCPUBITS)
> > > > > > > +#define CPU_MASK(cpu) ((__cpu_mask) 1 << ((cpu) % NCPUBITS))
> > > > > >=20
> > > > > > I wouldn't do that.  Three problems:
> > > > > > [...]
> > > > > > There's also the request from Sebastian on the newlib list to
> > > > > > consolidate the cpuset stuff from RTEMS and Cygwin into a single
> > > > > > definition.
> > > > > > [...]
> > > > > I've also found that taskset isn't working properly on my build s=
ystem with
> > > > > the new CPU_SET code, though my other testcases are.  So even as =
submitted,
> > > > > and fixed per your comments here, there's a bit more to be done.
> > > > >=20
> > > > > ..mark
> > > >=20
> > > > any chance to pick this up again?
>=20
> I've been looking at this suggestion to consolidate the cpuset stuff from
> RTEMS and Cygwin.  There is no location common to both platforms to put t=
his
> stuff other than Newlib's libc directory or maybe a non-sys subdir of lib=
c.
> If situated there, it could impact other newlib platforms, possibly.  It
> also seems a little messy to me to have to put four include files there..
> cpuset.h, _cpuset.h, bitset.h, and _bitset.h.  Maybe I'm overthinking it.

Well, the files are already there, just in the rtems subdir instead of the
generic one.  They just have to be moved, and the _cpuset.h file needs
a duplicate in cygwin's include dir to account for the Cygwin-specific part=
s.
It's not that you generate a lot of new files.

> RTEMS' cpuset.h is built on bitset.h, which is fine but the cpuset.h I wr=
ote
> is self-contained and makes use of gcc builtins rather than C library cal=
ls
> for malloc, free, popcount, etc.  Mine is 32/64 agnostic, I believe RTEMS=
 is
> too but I'm not totally sure; it depends on the length of 'long' items.
>=20
> RTEMS' implementation includes some code modules needing to be linked into
> libc while the one I wrote is all in header files with some inline code.
>=20
> These are all just minor implementation differences but I'm still hung up=
 on
> the question of just where a common implementation could be placed in the
> source tree so both RTEMS and Cygwin can use them but other newlib platfo=
rms
> won't be tripped up.

They won't.  The rtems/FreeBSD implementation is CPU agnostic so the stuff
could go into the generic tree.  If your platform doesn't implement it,
just don't include it in your target code.

However, it sounds like you're pretty uncomfortable with the rtems/FreeBSD
implementation.  If so, combining them is not required.  It would just
be a nice-to-have since it also leads to more people interested in keeping
it in a good shape.

> ..mark
>=20
> P.S. IRC would be better for this kind of discussion. I'm waiting for my
> freenode registration to be processed.....

Great!


Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--K3vkeaB0MlFjg8U+
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl1ANBsACgkQ9TYGna5E
T6BQehAAho/j31YURoCSZKhdAUX/RRAxMclV9e3yBzLRj1zh2ThBzPLfiAm/6szj
H7NKQiqU3BF9ne4mxzLTcyHf/xuYsM4z7xgGq3+CPHMbKW8yd3dES5ypJfjnIOKk
4KrcappZvs9Axd2iyHkDzMx+E0BwNo6Nq5mLwRYZ0jzXWyt28HBTOGlwQGQIe8mL
cKgokF60V3GPFuKOqveDc9a232EG7UhZ0qeBHSApfKFJIWvYCgT83qlg1e4VqxjZ
bWUY/cKpHfG3+kS+j44FbDLgngiw4cYh5Fab6/5i/XU33eTRt/+EOgyCPpHEMW9Z
zezhhr65nSCfw+MFJY8n4uU9+j/2LadgJHiDPcK1dhCJMOc2Z0lApYErESfT521y
TIX862rvA+EzBNaUd8SgMIYkeDFkC0gKDPlnJPr8ZQwmVQyMXUgpkRIlhmlvci+7
owSZR2eQly9Xjg93cSdWCnr7WXYcIP8lO8myxAGpo1ZOU+Vx/QvJZUGRxaU6yGzH
/Yy/OTEvUKm3OXNrchHSQ6kLgLDcN/tg08ndnRWzSG4WdzZPcxUR5Rn9tlKrrRO4
eILAj9WpIBpD2dJGAJSWl97rGEFXWi04zmpx5xEMWH8OkHI9rvXBmYc/PchrgL1s
k1v+U82w1f6GEuyiof/sWnGxbr+xx8kTsnY95cIxA6gYigz/AOo=
=vDCq
-----END PGP SIGNATURE-----

--K3vkeaB0MlFjg8U+--
