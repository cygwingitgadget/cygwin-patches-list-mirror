Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
 by sourceware.org (Postfix) with ESMTPS id EF6DD3857C4C
 for <cygwin-patches@cygwin.com>; Thu, 28 Jan 2021 16:13:06 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org EF6DD3857C4C
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MiaLn-1lafFG0KHf-00ffmn for <cygwin-patches@cygwin.com>; Thu, 28 Jan 2021
 17:13:05 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 23F6BA80B92; Thu, 28 Jan 2021 17:13:04 +0100 (CET)
Date: Thu, 28 Jan 2021 17:13:04 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: getdtablesize: always return OPEN_MAX_MAX
Message-ID: <20210128161304.GC4393@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210128025150.46708-1-kbrown@cornell.edu>
 <20210128102029.GY4393@calimero.vinschen.de>
 <151a4199-92f2-43aa-dd91-5d86c2e1d3c6@cornell.edu>
 <20210128160749.GB4393@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210128160749.GB4393@calimero.vinschen.de>
X-Provags-ID: V03:K1:FzGI8M4qCixpOpGhcPpIOybmIlXGG72Wq1C9yiAyaPlzkWcN+IR
 1QRpo7Pq/ES13ZG94sF8FyWSOtwHEwpKiBp6zBGjdx5/cS2MeqCoXslI9Ko1HQD8p2mvsaN
 OHbPPyM2Pjv/3LIZlfRRhoc8QNgYc9ynCg08reiX1fqhTPttQWqnAr9c2yef/EdatmWsmtR
 lkMmdsM2W0YNCqQVTywxQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:L/W3tLB8ESk=:yxY5ihmS2NWhnUjtqvRyTY
 DLpCtX/b4fGWGgstCCWhj7ueCwD21kadutz8dCpezp3qA8TsN0x7BmgDxR99Tr7008o/PYATo
 wYXJAjAwtLEiipx5jJduA0ZOuOAy/lQND44gCGmPa6sogNfMUbMyWUfJjGZ7TZdVVsZlFa7Cq
 9e4mFZPN+7GFBc9LvuSRkJsk5kh6oE5oGIhcFRmDqcmSMXUAp0en+sRKFGv0pC5A8MgZuCgiu
 KUhDfRbp+NU1H8cwlQxEJGtUC989JkVQItbqRPvEZ8DBE8+v+oyFzoXO4X3PigHnIasfZ/tjx
 OZcTjRCWzKW9Ato6Dp8nPsBOlG+oT2b5o/zH95jcQlPV+CltRn8++JKi6ZlGwycpsaHxzX76W
 dWEGdDFOwT/Kk1TuRDLYc4Kyvara7GHm5EpDk9z8JKPTtGodX6wemC2/bDOL/Zfbpe5wSfvj1
 7teo7uN+fg==
X-Spam-Status: No, score=-107.3 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Thu, 28 Jan 2021 16:13:08 -0000

On Jan 28 17:07, Corinna Vinschen via Cygwin-patches wrote:
> On Jan 28 08:42, Ken Brown via Cygwin-patches wrote:
> > On 1/28/2021 5:20 AM, Corinna Vinschen via Cygwin-patches wrote:
> > > On Jan 27 21:51, Ken Brown via Cygwin-patches wrote:
> > > > According to the Linux man page for getdtablesize(3), the latter is
> > > > supposed to return "the maximum number of files a process can have
> > > > open, one more than the largest possible value for a file descriptor."
> > > > The constant OPEN_MAX_MAX is the only limit enforced by Cygwin, so we
> > > > now return that.
> > > > 
> > > > Previously getdtablesize returned the current size of cygheap->fdtab,
> > > > Cygwin's internal file descriptor table.  But this is a dynamically
> > > > growing table, and its current size does not reflect an actual limit
> > > > on the number of open files.
> > > > 
> > > > With this change, gnulib now reports that getdtablesize and
> > > > fcntl(F_DUPFD) work on Cygwin.  Packages like GNU tar that use the
> > > > corresponding gnulib modules will no longer use gnulib replacements on
> > > > Cygwin.
> > > > ---
> > > >   winsup/cygwin/syscalls.cc | 2 +-
> > > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
> > > > index 5da05b18a..1f16d54b9 100644
> > > > --- a/winsup/cygwin/syscalls.cc
> > > > +++ b/winsup/cygwin/syscalls.cc
> > > > @@ -2887,7 +2887,7 @@ setdtablesize (int size)
> > > >   extern "C" int
> > > >   getdtablesize ()
> > > >   {
> > > > -  return cygheap->fdtab.size;
> > > > +  return OPEN_MAX_MAX;
> > > >   }
> > > 
> > > getdtablesize is used internally, too.  After this change, the values
> > > returned by sysconf and getrlimit should be revisited as well.
> > 
> > They will now return OPEN_MAX_MAX, as I think they should.  The only
> > question in my mind is whether to simplify the code by removing the calls to
> > getdtablesize, something like this (untested):
> 
> But then again, what happens with OPEN_MAX in limits.h?  Linux removed
> it entirely.  Given we have such a limit and it's not flexible as on
> Linux, should we go ahead, drop OPEN_MAX_MAX entirely and define
> OPEN_MAX as 3200?

...ideally by adding a file include/cygwin/limits.h included by
include/limits.h, which defines __OPEN_MAX et al, as required.


Corinna
