Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
 by sourceware.org (Postfix) with ESMTPS id F2F11385AC3C
 for <cygwin-patches@cygwin.com>; Wed, 10 Aug 2022 07:49:12 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org F2F11385AC3C
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MeCYx-1nmtwO1Yvv-00bGoX for <cygwin-patches@cygwin.com>; Wed, 10 Aug 2022
 09:49:11 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 94476A80BA7; Wed, 10 Aug 2022 09:49:10 +0200 (CEST)
Date: Wed, 10 Aug 2022 09:49:10 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: fix return value of symlink_info::check
Message-ID: <YvNi9pnVkw6B22PG@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <ba223591-0c96-d61c-36df-4f450abb9957@cornell.edu>
 <5bb753d7-a56a-d551-c675-26e4f822068e@cornell.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5bb753d7-a56a-d551-c675-26e4f822068e@cornell.edu>
X-Provags-ID: V03:K1:uYHVmCvULypt0Gna7o1/IXuWr8papsQ5aK46xd9hl9/bifP9swn
 GqNYIvW39hQIxDIejVXCkx8tuKCaQ5qLIcLjBBim5hHl+AGT+Fv8apPhZZPBaYqVuu7QE3v
 wwmvkhAFVLC/Ou+ehalcbTR7jWkYRYvHaUaajJ+JTNVyAKb1zNjYqHpctp04vmvB9/OxLiM
 mZFIpr+O5kTAyvBC2Uk6w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UDv4sWc1/kA=:FLUjEOH90SJDk0Qsyj/dl0
 NSBjWLq8SyokW05v5/8poD/0PxwZ7ETAzPhBB0yZy1puqqLBQRyxK0/PeYPTDclC/uoFOtvLx
 guJ5Loc8MqxMDAwqvdmtccJhqK9qvnzZuLdOI2Z8plG7JE/oreY+68aFqID1YpC+06ff/P+c/
 xsoBAcZRtCeNxSlcqbWu3k4yaMTi0VwRYLQ6Gm7HlPfA9YMB6U5CF/JxDz70Lpb1n6dKXEmnb
 3+TDn2jtY4KPUD6GDpObAH62sVO3zJ+egvNIEnK12l3lB8rm9c+ZXVbqmUO7B0yPi4VN6S1Ok
 2W4uljMqbMwy1fgRTksuTFf54AU0nYLQGOn6fc6ATaoge1PaLc1ShnWpRVjqIi1uhj6SKrLI2
 lMSH5eheHodaZLvlV6K7nDoq2HXuiBpF8M53cSO39BaXFBiYhzcbQeuMQNpMv2xjVRvA8b5aM
 qy8b1O78y7/tgUqDzFRG4yy4eQppjKelRcA5HomPnxoQlGH6FNh4yQDNa+x4VqfLjFfnZz5GU
 yfz+wXNB6sudcgUFMdQP1xIETCTycYLKc7EEXnL6Y1uckTbR6FVNLFIsf5SQ0zksTCewTb8JW
 /n9zeIeBa7gvojby8gF8i55KrM90yv4uwqecbpBxPKtAWTm2ZUJ1dhDk+i6GpCxjhJvFqthPu
 h4oAjdRRNyu7GZX3Bj02X+JxP2bqV71zyh1iX3u0/OHYS7Wb0W/k588+Lk5Xof92muklAEAOA
 1q2FE4nGlf4Q3uzvNjDRs5WemCsmf1/HlMKZhpEfbgsiBSRPAro27T94508=
X-Spam-Status: No, score=-101.8 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_FAIL, SPF_HELO_NONE, TXREP,
 T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
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
X-List-Received-Date: Wed, 10 Aug 2022 07:49:14 -0000

On Aug  9 16:52, Ken Brown wrote:
> v2 attached with a more accurate commit message.

LGTM, please push.


Thanks,
Corinna

> 
> Ken
> 
> On 8/9/2022 3:52 PM, Ken Brown wrote:
> > Patch attached.  Please check my changes to the commentary preceding
> > symlink_info::check to make sure I got it right.
> > 
> > I've written the patch against the master branch, but I think it should
> > be applied to cygwin-3_3-branch also.
> > 
> > Ken

> From d1aee2f7e022497d57d55ffcd69ddaa7d7b123b2 Mon Sep 17 00:00:00 2001
> From: Ken Brown <kbrown@cornell.edu>
> Date: Tue, 9 Aug 2022 15:14:07 -0400
> Subject: [PATCH v2] Cygwin: fix return value of symlink_info::check
> 
> Currently it is possible for symlink_info::check to return -1 in case
> we're searching for foo and find foo.lnk that is not a Cygwin symlink.
> This contradicts the new meaning attached to a negative return value
> in commit 19d59ce75d.  Fix this by setting "res" to 0 at the beginning
> of the main loop and not seting it to -1 later.
> 
> Also fix the commentary preceding the function definition to reflect
> the current behavior.
> 
> Addresses: https://cygwin.com/pipermail/cygwin/2022-August/252030.html
> ---
>  winsup/cygwin/path.cc       | 22 +++++++++-------------
>  winsup/cygwin/release/3.3.6 |  4 ++++
>  2 files changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/winsup/cygwin/path.cc b/winsup/cygwin/path.cc
> index 3e436dc65..227b99d0f 100644
> --- a/winsup/cygwin/path.cc
> +++ b/winsup/cygwin/path.cc
> @@ -3027,19 +3027,16 @@ symlink_info::parse_device (const char *contents)
>  /* Check if PATH is a symlink.  PATH must be a valid Win32 path name.
>  
>     If PATH is a symlink, put the value of the symlink--the file to
> -   which it points--into BUF.  The value stored in BUF is not
> -   necessarily null terminated.  BUFLEN is the length of BUF; only up
> -   to BUFLEN characters will be stored in BUF.  BUF may be NULL, in
> -   which case nothing will be stored.
> +   which it points--into CONTENTS.
>  
> -   Set *SYML if PATH is a symlink.
> +   Set PATH_SYMLINK if PATH is a symlink.
>  
> -   Set *EXEC if PATH appears to be executable.  This is an efficiency
> -   hack because we sometimes have to open the file anyhow.  *EXEC will
> -   not be set for every executable file.
> -
> -   Return -1 on error, 0 if PATH is not a symlink, or the length
> -   stored into BUF if PATH is a symlink.  */
> +   If PATH is a symlink, return the length stored into CONTENTS.  If
> +   the inner components of PATH contain native symlinks or junctions,
> +   or if the drive is a virtual drive, compare PATH with the result
> +   returned by GetFinalPathNameByHandleA.  If they differ, store the
> +   final path in CONTENTS and return the negative of its length.  In
> +   all other cases, return 0.  */
>  
>  int
>  symlink_info::check (char *path, const suffix_info *suffixes, fs_info &fs,
> @@ -3094,6 +3091,7 @@ restart:
>  
>    while (suffix.next ())
>      {
> +      res = 0;
>        error = 0;
>        get_nt_native_path (suffix.path, upath, mount_flags & MOUNT_DOS);
>        if (h)
> @@ -3345,8 +3343,6 @@ restart:
>  	  continue;
>  	}
>  
> -      res = -1;
> -
>        /* Reparse points are potentially symlinks.  This check must be
>  	 performed before checking the SYSTEM attribute for sysfile
>  	 symlinks, since reparse points can have this flag set, too. */
> diff --git a/winsup/cygwin/release/3.3.6 b/winsup/cygwin/release/3.3.6
> index 078e6e520..364e0cb0d 100644
> --- a/winsup/cygwin/release/3.3.6
> +++ b/winsup/cygwin/release/3.3.6
> @@ -35,3 +35,7 @@ Bug Fixes
>  - Fix a problem that prevented some symbolic links to /cygdrive/C,
>    /cygdrive/./c, /cygdrive//c, etc. from working.
>    Addresses: https://cygwin.com/pipermail/cygwin/2022-July/251994.html
> +
> +- Fix a path handling bug that could cause a non-existing file to be
> +  treated as the current directory.
> +  Addresses: https://cygwin.com/pipermail/cygwin/2022-August/252030.html
> -- 
> 2.37.1
> 

