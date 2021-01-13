Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
 by sourceware.org (Postfix) with ESMTPS id C64AB3851C17
 for <cygwin-patches@cygwin.com>; Wed, 13 Jan 2021 08:56:41 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org C64AB3851C17
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N8oOk-1jtqIQ0N6c-015my1 for <cygwin-patches@cygwin.com>; Wed, 13 Jan 2021
 09:56:40 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 1844BA80D3A; Wed, 13 Jan 2021 09:56:39 +0100 (CET)
Date: Wed, 13 Jan 2021 09:56:39 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: fstatat: call fstat64 instead of fstat
Message-ID: <20210113085639.GK59030@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210112194514.564-1-kbrown@cornell.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210112194514.564-1-kbrown@cornell.edu>
X-Provags-ID: V03:K1:/42NTJLKSwweZyOcWu8yxJFweNBERQRomT/SvsZ4GkRVrjeSLoS
 PdpPx1hlqHwqA5xMh+qHLTA+Ha9FifmzDuhhUiroNqHGkx2Fsc8u8noX75F5uXu/NLHSuK7
 jMeKeMXJpCptzV6q+EpdGo3oJfjnvtH6O8tB+ZrNuAOuE7mhK504KV2a2vN90ub7FCpkx7n
 Nccu8Nn6C7fVygIq5VNmQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZjBbFLmco28=:6P08XwXja07ihZ8zzzTo1b
 T0+ayzfSxiTLscteTc/RUqj1X0Wcl3tVw7lxggbY2wosgse33ko7DXrM3GvnLz6zAYBAfQTrd
 5NtQFYRqDRKEKyQhtBXSi47+c9570rfQbQRYe0lGQLpx/gRx9jAalhxEYPwOqzDi9kCa8eZ+G
 aalriYod3XACu2MDhGX029x3SmhYjNERcQNzvgeIEsKuCEPi0DZtthxQn6xoV3DG9ES7cf8PI
 S+sooDAyGQl/nfrURI1V7H7VHddJgztAzmf0kGM/IDKL1k5X+/6zBgvIj/9xqB1vXdeii/UrN
 sWlFz4doNBhyt0kYcS37cn1B4YhBZ9xA82/wdewYhWAPbirQ2P2myFROHs212xzD7y0VXiG4e
 Y8lYHvnqh5sCzUmCYY8iLayqtkCD5APABHUR4bKSM1A64+HfWcfE8w8J2YcuEbGKg8DICfoYX
 7beFvnm62w==
X-Spam-Status: No, score=-106.8 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H3, RCVD_IN_MSPIKE_WL, SPF_HELO_NONE, SPF_NEUTRAL,
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
X-List-Received-Date: Wed, 13 Jan 2021 08:56:43 -0000

Hi Ken,

Happy New Year, btw :)

On Jan 12 14:45, Ken Brown via Cygwin-patches wrote:
> This fixes a bug on 32-bit Cygwin that was introduced in commit
> 84252946, "Cygwin: fstatat, fchownat: support the AT_EMPTY_PATH flag".
> 
> Add a comment explaining why fstat should not be called.
> 
> Addresses: https://cygwin.com/pipermail/cygwin/2021-January/247399.html
> ---
>  winsup/cygwin/release/3.2.0 | 3 +++
>  winsup/cygwin/syscalls.cc   | 5 ++++-
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/winsup/cygwin/release/3.2.0 b/winsup/cygwin/release/3.2.0
> index 22f78e7a7..132d5c810 100644
> --- a/winsup/cygwin/release/3.2.0
> +++ b/winsup/cygwin/release/3.2.0
> @@ -42,3 +42,6 @@ Bug Fixes
>  
>  - Fix return value of sqrtl on negative infinity.
>    Addresses: https://cygwin.com/pipermail/cygwin/2020-October/246606.html
> +
> +- Fix a bug in fstatat(2) on 32 bit that could cause it to return garbage.
> +  Addresses: https://cygwin.com/pipermail/cygwin/2021-January/247399.html
> diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
> index 885ca375a..525efecf3 100644
> --- a/winsup/cygwin/syscalls.cc
> +++ b/winsup/cygwin/syscalls.cc
> @@ -1929,6 +1929,9 @@ _fstat64_r (struct _reent *ptr, int fd, struct stat *buf)
>  }
>  
>  #ifdef __i386__
> +/* This entry point is retained only to serve old 32 bit applications
> +built under Cygwin 1.3.x or earlier.  Newer 32 bit apps are redirected
> +to fstat64; see NEW_FUNCTIONS in Makefile.in. */
>  extern "C" int
>  fstat (int fd, struct stat *buf)
>  {
> @@ -4852,7 +4855,7 @@ fstatat (int dirfd, const char *__restrict pathname, struct stat *__restrict st,
>  	      cwdstuff::cwd_lock.release ();
>  	    }
>  	  else
> -	    return fstat (dirfd, st);
> +	    return fstat64 (dirfd, st);
>  	}
>        path_conv pc (path, ((flags & AT_SYMLINK_NOFOLLOW)
>  			   ? PC_SYM_NOFOLLOW : PC_SYM_FOLLOW)
> -- 
> 2.30.0

Sure, please go ahead.


Thanks,
Corinna
