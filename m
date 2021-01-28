Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
 by sourceware.org (Postfix) with ESMTPS id C0DBB385782C
 for <cygwin-patches@cygwin.com>; Thu, 28 Jan 2021 16:07:53 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org C0DBB385782C
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MzhWp-1lrdiQ0sfB-00vgs5 for <cygwin-patches@cygwin.com>; Thu, 28 Jan 2021
 17:07:51 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id EC070A80B92; Thu, 28 Jan 2021 17:07:49 +0100 (CET)
Date: Thu, 28 Jan 2021 17:07:49 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: getdtablesize: always return OPEN_MAX_MAX
Message-ID: <20210128160749.GB4393@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210128025150.46708-1-kbrown@cornell.edu>
 <20210128102029.GY4393@calimero.vinschen.de>
 <151a4199-92f2-43aa-dd91-5d86c2e1d3c6@cornell.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <151a4199-92f2-43aa-dd91-5d86c2e1d3c6@cornell.edu>
X-Provags-ID: V03:K1:Cj5NwkX1fYUzuxHnyhQLg1Ovm3eJ+ZcORiScp55Q0+KiTPE+mgv
 KTW27i2V1FT8MkespctPI/Zdg/i1TbNEaWWZrhphpxP+NyCXIV5Rm7wAz3hpx1/nxW0PemQ
 lQtuRSUp+7FGk+m8b8zQPP9fHvHvWgYXhpHwXPPzVgISUWqdh2m4dgEwuwwHqrIr7AKSkZW
 9XIkr7mgPLVwMAujEqp/g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VoHrdDAmgao=:uMpthenY99Gxu4vFNDy7kG
 g04ZTFr5DHhUwIjAhkB1P4k8WnEVAZ5W6m2V7EABl+Gr7C88ESBNGzZ1mEo4Kbhio2v8Xe/O0
 4MlH2eLkeuzSDvabxUCUJyzZbQ/ooOh3ekTWxuVk+NFN5mUTf/mkRXfBjONJp/m0Mag3cYB/v
 1U1j5QOZh0N1rd2axm8yu57hkYzanm8EzLaGdO2fjyFyQ7ye2I4wjKyLmrGO0CFrbqzCMeGm1
 NQsgbe/2KeqWotFvSVvwvA5hSR3yI/wQ546ytMmmZA005noOWkUa56D4Ff09TA+wgSssY+5PX
 HVVPhvUKZOXlHobFZ7Riody4YGIzFVESHaWhMdWyK9v7vxApON8F06oLT48flM1Pxr1Yrf7x2
 mgUcLatkRMBlAN+snI/aELKhTLnG4AAfW+25LNrbS3Ao3yTurFk5l3xTTGo+OUOUhegla9gT2
 vHXkP0RGQQ==
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
X-List-Received-Date: Thu, 28 Jan 2021 16:07:57 -0000

On Jan 28 08:42, Ken Brown via Cygwin-patches wrote:
> On 1/28/2021 5:20 AM, Corinna Vinschen via Cygwin-patches wrote:
> > On Jan 27 21:51, Ken Brown via Cygwin-patches wrote:
> > > According to the Linux man page for getdtablesize(3), the latter is
> > > supposed to return "the maximum number of files a process can have
> > > open, one more than the largest possible value for a file descriptor."
> > > The constant OPEN_MAX_MAX is the only limit enforced by Cygwin, so we
> > > now return that.
> > > 
> > > Previously getdtablesize returned the current size of cygheap->fdtab,
> > > Cygwin's internal file descriptor table.  But this is a dynamically
> > > growing table, and its current size does not reflect an actual limit
> > > on the number of open files.
> > > 
> > > With this change, gnulib now reports that getdtablesize and
> > > fcntl(F_DUPFD) work on Cygwin.  Packages like GNU tar that use the
> > > corresponding gnulib modules will no longer use gnulib replacements on
> > > Cygwin.
> > > ---
> > >   winsup/cygwin/syscalls.cc | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
> > > index 5da05b18a..1f16d54b9 100644
> > > --- a/winsup/cygwin/syscalls.cc
> > > +++ b/winsup/cygwin/syscalls.cc
> > > @@ -2887,7 +2887,7 @@ setdtablesize (int size)
> > >   extern "C" int
> > >   getdtablesize ()
> > >   {
> > > -  return cygheap->fdtab.size;
> > > +  return OPEN_MAX_MAX;
> > >   }
> > 
> > getdtablesize is used internally, too.  After this change, the values
> > returned by sysconf and getrlimit should be revisited as well.
> 
> They will now return OPEN_MAX_MAX, as I think they should.  The only
> question in my mind is whether to simplify the code by removing the calls to
> getdtablesize, something like this (untested):

But then again, what happens with OPEN_MAX in limits.h?  Linux removed
it entirely.  Given we have such a limit and it's not flexible as on
Linux, should we go ahead, drop OPEN_MAX_MAX entirely and define
OPEN_MAX as 3200?

One problem is that there are some applications in the wild which run
loops up to either sysconf(_SC_OPEN_MAX) or OPEN_MAX to handle open
descriptors.  tcsh is one of them.  It may slow done tcsh quite a bit
if the loop runs to 3200 now every time.


Corinna
