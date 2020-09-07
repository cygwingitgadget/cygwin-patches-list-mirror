Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
 by sourceware.org (Postfix) with ESMTPS id 1D839393C868
 for <cygwin-patches@cygwin.com>; Mon,  7 Sep 2020 09:39:46 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 1D839393C868
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([217.91.18.234]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MNwXA-1jvKES24QC-00OGA8 for <cygwin-patches@cygwin.com>; Mon, 07 Sep 2020
 11:39:44 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id EF79BA83A8B; Mon,  7 Sep 2020 11:39:43 +0200 (CEST)
Date: Mon, 7 Sep 2020 11:39:43 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v4 1/3] Cygwin: rewrite and make public cmdline parser
Message-ID: <20200907093943.GJ4127@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200905052711.13008-1-arthur2e5@aosc.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200905052711.13008-1-arthur2e5@aosc.io>
X-Provags-ID: V03:K1:bYPi1ZGmhTg2EmndkMuAj4/h+yTP0CyoikTGbViCVjBEmCqvLI6
 KaTbflATjKPo9AuDDR9IW7CBFaA5l+Qa0mUUdAqM9+Bxfj20t4C/5XomQrDUoAY9sP/Hbcf
 b9pEcaMLqe36dkAF2DrrNRx539vbpFL23jdTewwguEjZ/mq6PmNFrQBVs3lViFeudvkQM/G
 bwUTWW/+ZIjphWoTkiEMQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:74+COBDY2KY=:edHcbu2yPo6OVb3Higl84E
 0EoiK8kOOM+9EA3+JhjyMtNnR8DrHR1IEGNIYtY0txVJVp9XbaFrZ5osXG3rPzyC4WKj46eDv
 Dls3A8CaNZXfD+kdGgHCUotS1w3CrN1Q7NLaEQKkdF23u+KrWh1JyI9bnbJKpDRfHcvARwIYO
 XsaP0JOxHHZTsYlSU4fP4hmCXKbG28Po/hP/Y8o3X0o/cvPrFP/71DAWcl0XfwIw0llxH2rdr
 zfH2GAa3n8iGOG2kxPxdlzr+VMdmasxq7/OA101NqJceNrtIXuOUWYwbFXokvtCCYsJ9WqaC/
 wKDQ0Cs/XfPZce1AJL+pAsHiLgQ0yvYxN2RVEPhdeSqNwSV3ywyZtc/ChS4Ia5mxtvrZa7F28
 hel+cEPljJvT+7+GM/LTowTgi+Rq5VWP5kfiCRJia9oI0OvYf193lfWyg+/6n5wccUr+UFOXL
 PrjsXcdavKJHcTeL95mfgK0T0QY5Lt3QW+SR1h/PvYo9AYqvZheEXtHRwAwcnQlQmaBjmqFz/
 UGx7hgrfaRP1NfefJ2Rcw8JEt1fd7F2RLMkP0IBi5pJizYd/SJrSdccdiUwri8hP6KeDz6Z6j
 XZloN0oLG46tezrzxieu8oEb1zuuaC6tjMncI1Gk33ZV9wnZ3Q0Z39CIRT/udNps0OjoPeMo1
 7Ld7bxTJXBz7MpTTc5uwS7uTos4/ZCmryzOS6z5GN04OkQrobyQ2IYUYjBvkoObjqKi3w7Xqd
 ZSQE2loXtUns4uDEq6Lw6bdb7N+FWoJPcphRNnZeNqj22eWh3/zIXjrSp1p7oS4cXE6Nv3jS/
 NhmCyzgKjTxA/3K0tVo6S+gnDcFUfqqCUAw6fDsQDL9BLOOiRl1bo1Kny3Vk0pObu6CE5mjIG
 9Nz9GscHuciqiJS4rf5w==
X-Spam-Status: No, score=-105.6 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
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
X-List-Received-Date: Mon, 07 Sep 2020 09:39:47 -0000

On Sep  5 13:27, Mingye Wang wrote:
> This commit rewrites the cmdline parser to achieve the following:
> * MSVCRT compatibility. Except for the single-quote handling (an
>   extension for compatibility with old Cygwin), the parser now
>   interprets option boundaries exactly like MSVCR since 2008. This fixes
>   the issue where our escaping does not work with our own parsing.
> * Clarity. Since globify() is no longer responsible for handling the
>   opening and closing of quotes, the code is much simpler.
> * Sanity. The GLOB_NOCHECK flag is removed, so a failed glob correctly
>   returns the literal value. Without the change, anything path-like
>   would be garbled by globify's escaping.
> * A memory leak in the @file expansion is removed by rewriting it to use
>   a stack of buffers. This also simplifies the code since we no longer
>   have to move stuff. The "downside" is that tokens can no longer cross
>   file boundaries.
> 
> Some clarifications are made in the documentation for when globs are not
> expanded.  The functions are made public for testing, but my tcl setup
> is currently too messed up for running them!  I did test them as an
> isolated program on WSL-Debian.
> 
> The change fixes two complaints of mine:
> * That cygwin is incompatible with its own escape.[1]
> * That there is no way to echo `C:\"` from win32.[2]
>   [1]: https://cygwin.com/pipermail/cygwin/2020-June/245162.html
>   [2]: https://cygwin.com/pipermail/cygwin/2019-October/242790.html
> 
> (It's never the point to spawn cygwin32 from cygwin64. Consistency
> matters: with yourself always, and with the outside world when you are
> supposed to.)
> 
> This is the fourth version of the patch. I provide all my patches to
> Cygwin, including this one and all future ones, under the 2-clause BSD
> license.

Great, thanks.  A couple of (mostly minor) nits, though.

> diff --git a/winsup/cygwin/common.din b/winsup/cygwin/common.din
> index a7b4aa2b0..f15dc6a9e 100644
> --- a/winsup/cygwin/common.din
> +++ b/winsup/cygwin/common.din
> @@ -393,6 +393,8 @@ cygwin_split_path NOSIGFE
>  cygwin_stackdump SIGFE
>  cygwin_umount SIGFE
>  cygwin_winpid_to_pid SIGFE
> +cygwin_cmdline_parse SIGFE
> +cygwin_cmdline_build SIGFE

Nope, we won't do that.  The command line parsing is an internal
thing, and we won't export arbitrary internal functions using
their own symbol.  *If* we should export this stuff at all, which
I highly doubt as necessary, it should use the cygwin_internal API.

> diff --git a/winsup/cygwin/include/sys/cygwin.h b/winsup/cygwin/include/sys/cygwin.h
> index 805671ef9..e19ac0cd2 100644
> --- a/winsup/cygwin/include/sys/cygwin.h
> +++ b/winsup/cygwin/include/sys/cygwin.h
> @@ -86,6 +86,8 @@ extern void *cygwin_create_path (cygwin_conv_path_t what, const void *from);
>  extern pid_t cygwin_winpid_to_pid (int);
>  extern int cygwin_posix_path_list_p (const char *);
>  extern void cygwin_split_path (const char *, char *, char *);
> +extern int cygwin_cmdline_parse (char *, char ***, char **, int, int);
> +extern char *cygwin_cmdline_build (const char * const *, int, int);

Ditto.

> +static char* __reg1
> +read_file (const char *name)
> +{
> +#ifndef WINF_STDIO_TEST

Please drop this, together with the else branch for WSL.

> +      // For anything else, sort out backslashes first.
> +      // All backslashes are literal, except these before a quote.
> +      // Single-quote is our addition.  Would love to remove it.

Pleae use /* */ coments for multiline comments.

> +/* Perform a glob on word if it contains wildcard characters.
> +   Also quote every character between quotes to force glob to
> +   treat the characters literally.
> +
> +   Call glob(3) on the word, and fill argv accordingly.
> +   If the input looks like a DOS path, double up backslashes.
> + */

Please join the last two lines.  The closing */ should be on the
last comment line.

> +extern "C" int
> +extern "C" char *
> +extern "C"
> +{
> +  int cygwin_cmdline_parse (char *, char ***, char **, int, int);
> +  char *cygwin_cmdline_build (const char * const *, int, int);
> +}

Bzz.

> --- a/winsup/doc/misc-funcs.xml
> +++ b/winsup/doc/misc-funcs.xml

Ditto.

> diff --git a/winsup/testsuite/Makefile.in b/winsup/testsuite/Makefile.in
> index a86a35b88..bdc116d12 100644
> --- a/winsup/testsuite/Makefile.in
> +++ b/winsup/testsuite/Makefile.in

Skip it.  Just add this as a standalone testcase as attachement, that's
sufficient.


Thanks,
Corinna
