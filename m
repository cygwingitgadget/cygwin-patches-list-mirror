Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
 by sourceware.org (Postfix) with ESMTPS id 0DC1D386F466
 for <cygwin-patches@cygwin.com>; Mon, 18 Jan 2021 12:50:40 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 0DC1D386F466
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MhlCg-1lexbT2z2m-00dlQw for <cygwin-patches@cygwin.com>; Mon, 18 Jan 2021
 13:50:39 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 2AFC7A80988; Mon, 18 Jan 2021 13:50:39 +0100 (CET)
Date: Mon, 18 Jan 2021 13:50:39 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Interim malloc speedup
Message-ID: <20210118125039.GC59030@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20201222045348.10562-1-mark@maxrnd.com>
 <20210111121828.GC59030@calimero.vinschen.de>
 <d75ea761-7243-5f8d-4959-082933b1d223@maxrnd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d75ea761-7243-5f8d-4959-082933b1d223@maxrnd.com>
X-Provags-ID: V03:K1:g7EL+IJobwRFy9TunrvBMQPV+aG8yf8b+yijWriwvjymq13daIy
 ppkewrbPQiXi+qgRqzNY1jaPXiZKyQHaLYpoTEWpRqUbEo3VZEirtopwEVVYxGlVhw+Z3FC
 LdSMCiq7yBK6rzO6EKfGoI+9hOMhksKouu99YuJqM1gFj53LINVPxijXrN6poqF64Cuu9sK
 7pm84AzzHCYrkwntTU2AA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dG84KnjwRWA=:jbk60iH+rKIGOzaKT0YkQo
 S/qhW8cg44I7sfnAvUXOCFwdF+ZklzxxUS4o9bEVo8xIro6tnUzysj+SlxU8nlwWpVDSMHLkq
 qhkw3mEjmj0l1Y1qZE35hNf0mhGdVz3lxqFQyUtNJlSCBLjnAgpfHLBpHkj4VAzFC4LAZspXF
 sceIndpqMAGtweV5J6FUUlJ0l08AeXRtT2/kDCII/vZyp2lyllCwSos/yvXGiBbaedB30O+2g
 HC2yrAZcEpGK2L8Lx+/1H66Xeb309pR1DdNKvuDH07Rlkq93qI8CmfV/dIfKqKxqE+4p69rQy
 9cu5ff66K+XUGF5kEz4RMzAuVeR9xEy774HC6h2tPEt5GMUjo5DR1OCRbh8uvNv8UgkOWgaDN
 lWSZ7cMkR2BNV5vZ6u8EDgrBS4VUp+24AL5X+Rbhn8/9mdM6UhnefjxIu2K+O/iwY81dAendL
 G47csqN+xg==
X-Spam-Status: No, score=-106.8 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_NONE, KAM_DMARC_STATUS,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
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
X-List-Received-Date: Mon, 18 Jan 2021 12:50:42 -0000

Hi Mark,

On Jan 17 22:47, Mark Geisert wrote:
> Hi Corinna,
> Happy New Year back at you!  I'm very glad to see you posting again!

Yeah, I took a longer timeout over the holiday season.

> Corinna Vinschen via Cygwin-patches wrote:
> > Hi Mark,
> > 
> > Happy New Year!
> > 
> > On Dec 21 20:53, Mark Geisert wrote:
> > > Replaces function-level lock with data-level lock provided by existing
> > > dlmalloc.  Sets up to enable dlmalloc's MSPACES, but does not yet enable
> > > them due to visible but uninvestigated issues.
> > > 
> > > Single-thread applications may or may not see a performance gain,
> > > depending on how heavily it uses the malloc functions.  Multi-thread
> > > apps will likely see a performance gain.
> [...]
> > > diff --git a/winsup/cygwin/cygmalloc.h b/winsup/cygwin/cygmalloc.h
> > > index 84bad824c..67a9f3b3f 100644
> > > --- a/winsup/cygwin/cygmalloc.h
> > > +++ b/winsup/cygwin/cygmalloc.h
> [...]
> > > +/* These defines tune the dlmalloc implementation in malloc.cc */
> > >   # define MALLOC_FAILURE_ACTION	__set_ENOMEM ()
> > >   # define USE_DL_PREFIX 1
> > > +# define USE_LOCKS 1
> > 
> > Just enabling USE_LOCKS looks wrong to me.  Before enabling USE_LOCKS,
> > you should check how the actual locking is performed.  For non WIN32,
> > that will be pthread_mutex_lock/unlock, which may not be feasible,
> > because it may break expectations during fork.
> 
> I did investigate this before setting it, and I've been running with
> '#define USE_LOCKS 1' for many weeks and haven't seen any memory issues of
> any kind. Malloc multi-thread stress testing, fork() stress testing, Cygwin
> DLL builds, Python and binutils builds, routine X usage; all OK.  (Once I
> straightened out sped-up mkimport to actually do what Jon T suggested,
> blush.)
> 
> > What you may want to do is setting USE_LOCKS to 2, and defining your own
> > MLOCK_T/ACQUIRE_LOCK/... macros (in the `#if USE_LOCKS > 1' branch of
> > the malloc source, see lines 1798ff), using a type which is non-critical
> > during forking, as well as during process initialization.  Win32 fast
> > R/W Locks come to mind and adding them should be pretty straight-forward.
> > This may also allow MSPACES to work OOTB.
> 
> With '#define USE_LOCKS 1' the tangled mess of #if-logic in malloc.cc
> resolves on Cygwin to using pthread_mutex_locks, so that seems to be OK
> as-is unless what you're suggesting is preferable for speed (or MSPACES when
> I get to that).

Admittedly, I'm not sure if pthread mutexes pose a problem here, I'm
just cautious.

Malloc locking is single-process only and pthread mutexes are adding some
unnecessary overhead (Event object, bookkeeping list, fixup_after_fork
handling).  Win32 SRW Locks, especially the exclusive type, is much
faster and also easy to use, unless you need recursive locking.


Thanks,
Corinna
