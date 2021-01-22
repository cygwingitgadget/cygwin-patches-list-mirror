Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
 by sourceware.org (Postfix) with ESMTPS id 8A5FB3890406
 for <cygwin-patches@cygwin.com>; Fri, 22 Jan 2021 09:44:54 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 8A5FB3890406
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MFsER-1lEiJ00eJ5-00HPid for <cygwin-patches@cygwin.com>; Fri, 22 Jan 2021
 10:44:53 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id C6DB2A80D50; Fri, 22 Jan 2021 10:44:52 +0100 (CET)
Date: Fri, 22 Jan 2021 10:44:52 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: normalize_posix_path: fix error handling when ..
 is encountered
Message-ID: <20210122094452.GB810271@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210120154006.53040-1-kbrown@cornell.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210120154006.53040-1-kbrown@cornell.edu>
X-Provags-ID: V03:K1:2UM6sCEjZodYTzB/laT0XPodWzcEo1IZOyKFl/Bh8zj3c5iNGLT
 Dib02mr728D2Gw5xQz9dIKBnG1i7maDBXTp+xQHqRv5l1fuTHKGT12sUcbsY3G3AX0oFYdY
 8nrYdKFxMNt+LgsIKFlKVdfNJLlJFuDPLf22GcP5o4KgIqQ7gFYCYCD1RqeqXL+J8aJ2/xz
 4LgV5skLyIxzaS+BWwSIg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XJ1r/dU53pI=:EOuf9O3bZptowpWzux7pFO
 W6z3oqsPbD7CDemJ2pwkTpFR1F3t3NhMgL5q1XKJhrd3HVO/IT+rnFPRa57GPAhX4fHJmqFxC
 QM7AL+9KNvgx0fWkMQZ+onbC1W331sgG0/OWwMuWkIm06RxoutCgTPfRspfGHgvQvwSMAYW6J
 RICidVvfbtd6V4aozJl8gf1RbSmIxXItQVHuTYywS0qcmFiWunz/LzPSEMCc4lGju0Y0bc4Og
 m9DfRS5LvdvwiviJRVTk/XilIdkRNdSBTwiVtboYkmzvIa7fc6ibDVORHgzJrY1t1CYO287vR
 k98U9/PhIK3cZFLHstC0OD3+7Z89ZBRblaaHKN4VWMQPG/a6fUXcZiSih2+T2N0xvRrZbZGbi
 0fitsGDwwebj0M3wO1qyksdsTVkKCZFUwgnVzxdCBEQ+YalzleOhjxW+3Lph1MuWmgqlKJjga
 +ECbBkVPMP6vVO6taNUj4zv0dwrgcWM=
X-Spam-Status: No, score=-107.1 required=5.0 tests=BAYES_00, GIT_PATCH_0,
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
X-List-Received-Date: Fri, 22 Jan 2021 09:44:56 -0000

On Jan 20 10:40, Ken Brown via Cygwin-patches wrote:
> When .. is in the source path and the path prefix exists but is not a
> directory, return ENOTDIR instead of ENOENT.  This fixes a failing
> gnulib test of realpath(3).
> 
> Addresses: https://lists.gnu.org/archive/html/bug-gnulib/2021-01/msg00214.html
> ---
>  winsup/cygwin/path.cc       | 4 +++-
>  winsup/cygwin/release/3.2.0 | 4 ++++
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/winsup/cygwin/path.cc b/winsup/cygwin/path.cc
> index abd3687df..6dc162806 100644
> --- a/winsup/cygwin/path.cc
> +++ b/winsup/cygwin/path.cc
> @@ -323,8 +323,10 @@ normalize_posix_path (const char *src, char *dst, char *&tail)
>  			  if (!tp.check_usage (4, 3))
>  			    return ELOOP;
>  			  path_conv head (dst, PC_SYM_FOLLOW | PC_POSIX);
> -			  if (!head.isdir())
> +			  if (!head.exists ())
>  			    return ENOENT;
> +			  if (!head.isdir ())
> +			    return ENOTDIR;
>  			  /* At this point, dst is a normalized path.  If the
>  			     normalized path created by path_conv does not
>  			     match the normalized path we're just testing, then
> diff --git a/winsup/cygwin/release/3.2.0 b/winsup/cygwin/release/3.2.0
> index c18a848de..43725cec2 100644
> --- a/winsup/cygwin/release/3.2.0
> +++ b/winsup/cygwin/release/3.2.0
> @@ -48,3 +48,7 @@ Bug Fixes
>  
>  - Fix a bug in fstatat(2) on 32 bit that could cause it to return garbage.
>    Addresses: https://cygwin.com/pipermail/cygwin/2021-January/247399.html
> +
> +- Fix the errno when a path contains .. and the prefix exists but is
> +  not a directory.
> +  Addresses: https://lists.gnu.org/archive/html/bug-gnulib/2021-01/msg00214.html
> -- 
> 2.30.0

Ok, please push.


Thanks,
Corinna
