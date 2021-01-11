Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout-xforward.kundenserver.de (mout-xforward.kundenserver.de
 [82.165.159.39])
 by sourceware.org (Postfix) with ESMTPS id 5C8DD38618B8
 for <cygwin-patches@cygwin.com>; Mon, 11 Jan 2021 12:18:30 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 5C8DD38618B8
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MS4WT-1kX8Zi079X-00TWFu for <cygwin-patches@cygwin.com>; Mon, 11 Jan 2021
 13:18:29 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 34D35A80D33; Mon, 11 Jan 2021 13:18:28 +0100 (CET)
Date: Mon, 11 Jan 2021 13:18:28 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Interim malloc speedup
Message-ID: <20210111121828.GC59030@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20201222045348.10562-1-mark@maxrnd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201222045348.10562-1-mark@maxrnd.com>
X-Provags-ID: V03:K1:n+EGrufxLIhJvLdb5d+iAbDGLqxzsAKVdE30HUBwCRzGXweP2Zd
 U2vfrM4EW0M8KjhwptzjCRKI3AS4Nygv3KQ4s6xcuMyqF0WPpkelP4IljzpMOjNMGCrFCFV
 ODivgeWJPJcd+sJfZ9A9ekINIW3MxSxd0s2FjL3ZDZNTFOIKWltwn694uoiHPO31LT3HtJS
 Nmd5xIp/ZF4zc+7f5dYbw==
X-UI-Out-Filterresults: junk:10;V03:K0:vsZxUbozoP0=:5ivyRARtfZC9eSmcsR8vYqZw
 FvdfUkZj9snrKbups8/C919ljKwKGcl19kGofLWki6kLW28/sMboQcl0hZcDs4FKabXJ6Lp/w
 4KVLlNnTmaFSlbEmQYTi9Njm/SzC2fOIgbJ/9+/P3VpSjjUG/FHzek3Im/1QpW6GyP7Gl1Qv/
 +cxfprjlq4sJ7c62n9mxaJNy7x2u7Gq+SLkeqCnLk5nsaFplJFRCx5AnBprRQkvPyMTohT7+F
 djeAdNuUjWEaWHlyE+P55GYcfS/PBcTPJU21tM/9Jlc8Tq0ae6G/KJh1MftCTR7y6PZFIpWBv
 K1JHY2lkvLq96R8hjwHMAfOEnCUXDJ3YT8afnW91QRrvCk5YngUrbmLxtxAzDTW39BGf+CnUo
 X8q1NkjflEl0zJtkqpSPwzq2reynBt52nn2/QV1hRZjwoVoggvtdUGl3QjSRP/jjKOsH6PBZL
 l+ul9Gr3tsAMIAk8x/U3Jeh2Uemv1VdbrQVUBbE70RXjINdFnc4l7qSVtP5OMzuFfOnhzrh1k
 9sbzUxZutZ18sj/sigpU=
X-Spam-Status: No, score=-108.0 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_MSPIKE_BL,
 RCVD_IN_MSPIKE_L5, RCVD_IN_SBL, SPF_HELO_NONE, SPF_NEUTRAL,
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
X-List-Received-Date: Mon, 11 Jan 2021 12:18:32 -0000

Hi Mark,

Happy New Year!

On Dec 21 20:53, Mark Geisert wrote:
> Replaces function-level lock with data-level lock provided by existing
> dlmalloc.  Sets up to enable dlmalloc's MSPACES, but does not yet enable
> them due to visible but uninvestigated issues.
> 
> Single-thread applications may or may not see a performance gain,
> depending on how heavily it uses the malloc functions.  Multi-thread
> apps will likely see a performance gain.
> 
> ---
>  winsup/cygwin/cygmalloc.h       |  28 +++-
>  winsup/cygwin/fork.cc           |   8 -
>  winsup/cygwin/malloc_wrapper.cc | 274 +++++++++++++++++++++-----------
>  3 files changed, 202 insertions(+), 108 deletions(-)
> 
> diff --git a/winsup/cygwin/cygmalloc.h b/winsup/cygwin/cygmalloc.h
> index 84bad824c..67a9f3b3f 100644
> --- a/winsup/cygwin/cygmalloc.h
> +++ b/winsup/cygwin/cygmalloc.h
> @@ -26,20 +26,36 @@ void dlmalloc_stats ();
>  #define MALLOC_ALIGNMENT ((size_t)16U)
>  #endif
>  
> +/* As of Cygwin 3.2.0 we could enable dlmalloc's MSPACES */
> +#define MSPACES 0 // DO NOT ENABLE: cygserver, XWin, etc will malfunction
> +
>  #if defined (DLMALLOC_VERSION)	/* Building malloc.cc */
>  
>  extern "C" void __set_ENOMEM ();
>  void *mmap64 (void *, size_t, int, int, int, off_t);
>  # define mmap mmap64
> +
> +/* These defines tune the dlmalloc implementation in malloc.cc */
>  # define MALLOC_FAILURE_ACTION	__set_ENOMEM ()
>  # define USE_DL_PREFIX 1
> +# define USE_LOCKS 1

Just enabling USE_LOCKS looks wrong to me.  Before enabling USE_LOCKS,
you should check how the actual locking is performed.  For non WIN32,
that will be pthread_mutex_lock/unlock, which may not be feasible,
because it may break expectations during fork.

What you may want to do is setting USE_LOCKS to 2, and defining your own
MLOCK_T/ACQUIRE_LOCK/... macros (in the `#if USE_LOCKS > 1' branch of
the malloc source, see lines 1798ff), using a type which is non-critical
during forking, as well as during process initialization.  Win32 fast
R/W Locks come to mind and adding them should be pretty straight-forward.
This may also allow MSPACES to work OOTB.

> +# define LOCK_AT_FORK 0

This looks dangerous.  You're removing the locking from fork entirely
*and* the lock isn't re-initialized in the child.  This reinitializing
was no problem before because mallock was NO_COPY, but it's a problem
now because the global malloc_state _gm_ isn't (and mustn't).  The
current implementation calling

  #if LOCK_AT_FORK
      pthread_atfork(&pre_fork, &post_fork_parent, &post_fork_child);
  #endif

should do the trick, assuming the USE_LOCKS stuff is working as desired.

> [...]
> +#if MSPACES
> +/* If mspaces (thread-specific memory pools) are enabled, use a thread-
> +   local variable to store a pointer to the calling thread's mspace.
> +
> +   On any use of a malloc-family function, if the appropriate mspace cannot
> +   be determined, the general (non-mspace) form of the corresponding malloc
> +   function is substituted.  This is not expected to happen often.
> +*/
> +static NO_COPY DWORD tls_mspace; // index into thread's TLS array
> +
> +static void *
> +get_current_mspace ()
> +{
> +  if (unlikely (tls_mspace == 0))
> +    return 0;
> +
> +  void *m = TlsGetValue (tls_mspace);
> +  if (unlikely (m == 0))
> +    {
> +      m = create_mspace (MSPACE_SIZE, 0);
> +      if (!m)
> +        return 0;
> +      TlsSetValue (tls_mspace, m);
> +    }
> +  return m;
> +}
> +#endif

Please define a new slot in _cygtls keeping the memory address returned
by create_mspace.  You don't have to call TlsGetValue/TlsSetValue.


Thanks,
Corinna
