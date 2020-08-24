Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout-xforward.kundenserver.de (mout-xforward.kundenserver.de
 [82.165.159.44])
 by sourceware.org (Postfix) with ESMTPS id 538753857C64
 for <cygwin-patches@cygwin.com>; Mon, 24 Aug 2020 09:48:46 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 538753857C64
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([217.91.18.234]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N79q6-1kiDEF2fUa-017UYj for <cygwin-patches@cygwin.com>; Mon, 24 Aug 2020
 11:48:43 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 0D3D8A82B8D; Mon, 24 Aug 2020 11:48:43 +0200 (CEST)
Date: Mon, 24 Aug 2020 11:48:43 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: malloc tune-up
Message-ID: <20200824094843.GZ3272@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200824045913.1216-1-mark@maxrnd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200824045913.1216-1-mark@maxrnd.com>
X-Provags-ID: V03:K1:O0Q3mF+5Qqsor9b4sp8bB5vo4akgNujg4NPguS3nIVP3cMkDO3j
 FCUCmwAttRHdRsD0gXMGG3Z1PuQBRPBW89wtudmVRr1fCSkIRvHCpOTNFhcTiMyDJ9vDfn3
 BbpF9OLnFxObui9eYCUIY/AX/tQtr9tFV4521fpnB9srLZ+y5mcWemt8OwNsOTJdYlfoPSs
 RO1e3W5rvj8EaRaTM/3bw==
X-UI-Out-Filterresults: junk:10;V03:K0:Eh0vH2B+SmU=:/VEQBTHaVXifB3v7sBwPuG53
 lIjOAb7urLLIG8AU1gfQqrU+12wRAKYixB4F4A+wfkPBbSJLWKJT77ydwnejv3I0Nhbz7Vk27
 chmL0zRKEKgiJraMXYklOKs8JiLHGoppn+T6eHYvj8rBwfLPL2eiXi1YMg1hiRNfD3DYcrXPj
 mXfrb/SGeniaAx9zKSEnYhvx7pI8EjgBzgbxy3KRw4SSg0xmUIm3vfAZwwIytu34p0ADKvBXt
 ZLr/w7tZuCj/de/kqVvB8FLx6A9cIZFp/PrOgtM955j34bhAiA0V5D7BiiYl1IcsCUIWNK96u
 xREpZ45tlKvlRiZbVOv9fFs4PtQR0mLfl7p/qTU+66NuXtYLb9xIFBCqwyW3NXxIzum0Ftq3W
 C4tA/s7ONgEVCAYu1hFcrSvZj+xrq0djheOtXE1faFaBFxGSZdysRknL8x55Ld3YbugzqJCb8
 Oze4fWNuWSNRz2Rh94agTJXBNhj7qZJQa/il0+szheFujj6amsdwtQyjpdvm2fYWRn3bjsoPE
 wYVvbuM8tQABUxaJLdfXslT/gwU/5HD9rxtmW5ml/PMZW4aBEw47oJeFe5gw0l2XmfYM+e6/X
 DYoFeY1yLlYAEmNNqNlw62cov/XkyhwnGwGY23ekXWGAIeISMkXKvFTuhUs7/dkBmq5EH9/Kf
 fFxfdV+UidaY3BMyYrq1IDgJxMF+vlLiRwWQVVtIHJZCFYilCN/4gog26H9t6OygYBvGeXh/l
 Qav772kTRuDJn5hi07CVz8tfJbhz3dyOpbTWlxRt3o3J3FkmA/Lmn1nNewF7dewdDZKVoFEP/
 /lBmAO+CWDMtANVzwil+OWDfzaxY7andyhimeUA9IbUmZ7c95Ks+/bawgQzRIdQK6oNIgNFuL
 NjpVMcKoTvvZbi+H8Z4vnpu4hLkkxZGru9qLTGFo4blLz2ItGMnaFRX13xBb7apqSULe75Lsj
 PyrFPU8mBGaw/GF7wHQW85o11iwJ3mtbM8rJhGKvZznXns9udxZL0rDRFb2cVtC2zVLLbJUIH
 PRPErMNOL8L6EgFYW6+qE=
X-Spam-Status: No, score=-105.8 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_STATUS, RCVD_IN_MSPIKE_BL,
 RCVD_IN_MSPIKE_L3, RCVD_IN_SBL, SPF_HELO_NONE, SPF_NEUTRAL,
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
X-List-Received-Date: Mon, 24 Aug 2020 09:48:48 -0000

Hi Mark,

On Aug 23 21:59, Mark Geisert wrote:
> 1. Replace global malloc lock with finer-grained internal locks.
> 2. Enable MSPACES, i.e. thread-specific memory pools.
> 
> Porting and testing of several dlmalloc-related malloc implementations
> (ptmalloc, ptmalloc2, ptmalloc3, nedalloc) shows that they are no faster
> than the current dlmalloc used by Cygwin, when the latter is tuned.  This
> could be because the others are forks of earlier dlmalloc versions.  For

That also means, there may be a point to update dlmalloc to a newer
version at one point again.  If you have fun to do so...

> the record, I could not get jemalloc or tcmalloc running at all due to
> chicken-egg issues, nor could I get a Win32 Heap-based malloc to work
> across fork(), which was expected.
> 
> I think I can see a way to get Win32 Heap-based malloc to work across
> fork()s, but it would depend on undocumented info and would likely be
> subject to breakage in future Windows versions.  Too bad, because that
> form of malloc package would be 2 to 8 times faster in practice.

Which is kind of strange, given malloc is all about heap management.
Given a sufficiently big heap, how can a well-written malloc be slower
than Win32 HeapAlloc?  Puzzeling...

> ---
>  winsup/cygwin/cygmalloc.h       |  21 +++-
>  winsup/cygwin/fork.cc           |   7 --
>  winsup/cygwin/malloc_wrapper.cc | 163 +++++++++++++++++++-------------
>  3 files changed, 113 insertions(+), 78 deletions(-)

I think this is a great idea.  I have a few nits, though:

> diff --git a/winsup/cygwin/cygmalloc.h b/winsup/cygwin/cygmalloc.h
> index 84bad824c..302ce59c8 100644
> --- a/winsup/cygwin/cygmalloc.h
> +++ b/winsup/cygwin/cygmalloc.h
> @@ -33,15 +33,30 @@ void *mmap64 (void *, size_t, int, int, int, off_t);
>  # define mmap mmap64
>  # define MALLOC_FAILURE_ACTION	__set_ENOMEM ()
>  # define USE_DL_PREFIX 1
> +# define USE_LOCKS 1
> +# define MSPACES 1
> +# define FOOTERS 1
>  
>  #elif defined (__INSIDE_CYGWIN__)
>  
> -# define __malloc_lock() mallock.acquire ()
> -# define __malloc_unlock() mallock.release ()
> -extern muto mallock;
> +# define MSPACES 0

That means MSPACES is 0 in malloc_wrapper.cc.  This code is not building
the MSPACES stuff into malloc_wrapper.cc, but the now non-thread-safe
direct dlfoo calls.  Just add `#error foo' to some of the `#if MSPACES'
code and you'll see you're (probably) not building what you think you're
building.

>  #endif
>  
> +#if MSPACES
> +void __reg2 *create_mspace (size_t, int);
> +void __reg2 mspace_free (void *m, void *p);
> +void __reg2 *mspace_malloc (void *m, size_t size);
> +void __reg3 *mspace_realloc (void *m, void *p, size_t size);
> +void __reg3 *mspace_calloc (void *m, size_t nmemb, size_t size);
> +void __reg3 *mspace_memalign (void *m, size_t alignment, size_t bytes);
> +void __reg2 *mspace_valloc (void *m, size_t bytes);
> +size_t __reg1 mspace_usable_size (const void *p);
> +int __reg2 mspace_malloc_trim (void *m, size_t);
> +int __reg2 mspace_mallopt (int p, int v);
> +void __reg1 mspace_malloc_stats (void *m);
> +#endif
> +
>  #ifdef __cplusplus
>  }
>  #endif
> diff --git a/winsup/cygwin/fork.cc b/winsup/cygwin/fork.cc
> index 38172ca1e..82f95dafe 100644
> --- a/winsup/cygwin/fork.cc
> +++ b/winsup/cygwin/fork.cc
> @@ -296,8 +296,6 @@ frok::parent (volatile char * volatile stack_here)
>    si.lpReserved2 = (LPBYTE) &ch;
>    si.cbReserved2 = sizeof (ch);
>  
> -  bool locked = __malloc_lock ();
> -

You're guarding the new code below with #if MSPACES and keep the calling
dlmalloc and friends here in fork as well as in the #else branches.  But
these code branches would need the old __malloc_lock/__malloc_unlock stuff,
otherwise they are broken.

Either we can go entirely without the #if MSPACES bracketing, or the
the code must keep using the global lock in the #if !MSPACES case.

>    /* Remove impersonation */
>    cygheap->user.deimpersonate ();
>    fix_impersonation = true;
> @@ -448,9 +446,6 @@ frok::parent (volatile char * volatile stack_here)
>  		   "stack", stack_here, ch.stackbase,
>  		   impure, impure_beg, impure_end,
>  		   NULL);
> -
> -  __malloc_unlock ();
> -  locked = false;
>    if (!rc)
>      {
>        this_errno = get_errno ();
> @@ -533,8 +528,6 @@ cleanup:
>  
>    if (fix_impersonation)
>      cygheap->user.reimpersonate ();
> -  if (locked)
> -    __malloc_unlock ();
>  
>    /* Remember to de-allocate the fd table. */
>    if (hchild)
> diff --git a/winsup/cygwin/malloc_wrapper.cc b/winsup/cygwin/malloc_wrapper.cc
> index 3b245800a..f1c23b4a8 100644
> --- a/winsup/cygwin/malloc_wrapper.cc
> +++ b/winsup/cygwin/malloc_wrapper.cc
> @@ -27,6 +27,33 @@ extern "C" struct mallinfo dlmallinfo ();
>  static bool use_internal = true;
>  static bool internal_malloc_determined;
>  
> +/* If MSPACES (thread-specific memory pools) are enabled, use a
> +   thread-local variable to store a pointer to that thread's mspace.
> + */
> +#if MSPACES
> +static DWORD tls_mspace; // index into thread's TLS array
> +#define MSPACE_SIZE (8 * 1024 * 1024)
> +
> +static void *
> +get_current_mspace ()
> +{
> +  if (unlikely(tls_mspace == 0))
> +    api_fatal ("a malloc-related function was called before malloc_init");
> +
> +  void *m = TlsGetValue (tls_mspace);

Why do we need a Win32 TLS value here?  We're usually having our own tls
area as defined in cygtls.h.  You could just add a

  void *mspace_ptr;

or so to class _cygtls.  The only downside is that the first build will
be very likely broken.  It regenerates tlsoffsets{64}.h, but then newlib
potentially uses wrong offsets.  Therefore, after changing class _cygtls
and regenerating the tls offsets once, a full rebuild should be
performed to be on the safe side.

In terms of using TlsAlloc and friends I have a problem with fork
safety.  The _cygtls area is on the thread's stack, and the stack of the
forking thread is copied over to the child, so the value of mspace_ptr
is intact after fork.  This isn't the case for the TlsAlloc'ed void
pointer, given the TlsAlloc is called anew in every process.  So it
looks like the forked process is losing a pointer.


Thanks,
Corinna
