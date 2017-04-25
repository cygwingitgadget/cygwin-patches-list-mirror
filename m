Return-Path: <cygwin-patches-return-8764-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 124888 invoked by alias); 25 Apr 2017 12:27:30 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 124863 invoked by uid 89); 25 Apr 2017 12:27:30 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-106.4 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=wondering, HTo:U*cygwin-patches
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 25 Apr 2017 12:27:27 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id 9B133721E281A;	Tue, 25 Apr 2017 14:27:24 +0200 (CEST)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id E887F5E0463;	Tue, 25 Apr 2017 14:27:23 +0200 (CEST)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id C7A84A80410; Tue, 25 Apr 2017 14:27:23 +0200 (CEST)
Date: Tue, 25 Apr 2017 12:27:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Cc: Daniel Santos <daniel.santos@pobox.com>
Subject: Re: [PATCH] Possibly correct fix to strace phantom process entry
Message-ID: <20170425122723.GA12712@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com,	Daniel Santos <daniel.santos@pobox.com>
References: <20170424093754.536-1-daniel.santos@pobox.com> <20170424121922.GA5622@calimero.vinschen.de> <58cd89a9-4efe-ce8c-320e-a843839e59a7@pobox.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
Content-Disposition: inline
In-Reply-To: <58cd89a9-4efe-ce8c-320e-a843839e59a7@pobox.com>
User-Agent: Mutt/1.8.0 (2017-02-23)
X-SW-Source: 2017-q2/txt/msg00035.txt.bz2


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 3534

On Apr 24 18:14, Daniel Santos wrote:
> On 04/24/2017 07:19 AM, Corinna Vinschen wrote:
> > Hi Daniel,
> >=20
> > On Apr 24 04:37, Daniel Santos wrote:
> > > The root cause of problem with strace causing long delays when any
> > > process enumerates the process database appears to be calling
> > > myself.thisproc () from child_info_spawn::handle_spawn() when we've
> > > dynamically loaded cygwin1.dll.  It definately fixes the problem, but=
 I
> > > don't konw what other processes dynamically load cygwin1.dll and, thu=
s,
> > > what other side-effects that this may have.  Please verify correctnes=
s.
> > >=20
> > > Please see discussion here: https://cygwin.com/ml/cygwin/2017-04/msg0=
0240.html
> > >=20
> > > Daniel
> > >=20
> > > Signed-off-by: Daniel Santos <daniel.santos@pobox.com>
> > > ---
> > I was just looking into this myself, but I was looking into the weird
> > Sleep loop itself and was wondering if that makes any sense at all.
> >=20
> > Assuming pinfo::init is called from process enumeration (winpids::add)
> > then there's no good reason to handle this procinfo block at all.  It
> > doesn't resolve into an existing "real" Cygwin process.  And that's
> > exactly the case that hangs.
>=20
> Yeah, and it doesn't represent a unique windows process either.

Right.  The problem is, I didn't look too deeply into the pinfo
implementation yet (except for /proc and signal stuff), so I'm quite
fuzzy on why this is done this way myself.  This was originally cgf's
domain (my ex-co-maintainer).

Here's another interesting observation: If you start ps under strace
from another Cygwin process like this:

  $ strace -o xyz ps

then strace is in the process list with filled out data like any other
process.  However, if you do the same from cmd:

  C:\> strace -o xyz ps

then strace is not in the list of Cygwin processes.  The reason is
apparently that a parent creates a child procinfo on fork (in
frok::parent), while the standalone start of strace only creates the
minimal procinfo via the thisproc call in child_info_spawn::handle_spawn.

I wonder if the handling of processes like strace isn't a bit lacking.
I appreciate any effort to improve this code.

> > So my curent fix would have been this:
> > [...]
>=20
> Yeah, I hacked this loop up many times, mostly to diagnose the problem.  I
> presume that it was originally added for a reason, but as I said before, I
> know that on x86 procinfo->ppid is almost certain to compile into a mov t=
hat
> will be atomic, but when I expect another thread to change something larg=
er
> than one byte, I prefer to use a macro or function that is always atomic =
and
> conveys the intention.

I don't think this is the problem here.  The test in done only to
check if ppid is written at all under the assumption that the ppid
value is always written last.  The actual value doesn't matter as long
as it's !=3D 0.

> > Btw., would you mind to send a BSD waiver per
> > https://cygwin.com/contrib.html and
> > https://cygwin.com/git/?p=3Dnewlib-cygwin.git;f=3Dwinsup/CONTRIBUTORS;h=
b=3DHEAD
> > Your patches are covered by the "trivial patch" rule yet, but if you
> > look into providing more patches you don't have to care anymore.
>=20
> Thanks, I had overlooked that.  Is this sufficient?
>=20
> I am providing my patches to the Cygwin sources under the 2-clause BSD
> license.

Yep, that's ok.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY/0CrAAoJEPU2Bp2uRE+g3RcP/3of5L42U5LBb2wEf+VVuWQk
4AS8rZCw8HtZRfAI/ZETQanBLPDg5TOwFNqAkUmy1jOfWtZaq1SVZgo3N5WyhM9l
UiwBG4M9QAkgbF15Am/Q8j/o+BCmZ1O/NXVbYCRnAqbYNvJR5Am16aRqsIZHWcFp
pvrOTg13Gd09r8S7QMk+yziiL5ViqLTaVscWGlzTJZaadVczWzADGDYIglJuWYkL
8L72cKM0gHkC5KFj6PBcWB+eGFR1UJl6Gb54MmoUD88bXv9Q4hhPugC4N4Vyh2dy
kts1HAFLOpia+8n0FZjQ2SBrCt427PHQJ9WWJA23EJPonraR0GTQTI9xkXWGEEqE
UtPXbHzCCA9HHus6aNgJjT8yig+cCe/YGLookt1RVLlUC38tT7K69vynXM6zUWrs
fzvWtrIuFmbO0pUrpWYKYEbp+NzZ4rLLZLcfhemlT7pOJ7PuWZWxpdKWgIv7xrFo
7S8qhzTBgb38q5/QkWPKeF2dHxcnEDMpbjXAfvcB9epDe2pAEdK+ovtQZvPIIZzL
85F7scDo0WH6HdAP3c6VqvIsFAJLfisYuwAGv40VrYUUEZDHi4qr3lL1UoN99pSK
pf2VmiQvv5GUN6bK2Z8RHSQM+XaDEw2EdnH7JhJoDbc+58y6y2J328xHYf7JKDN3
r8tl/5T0O6f2RPbdpKnL
=i6Io
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--
