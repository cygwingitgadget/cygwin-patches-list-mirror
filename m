Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
 by sourceware.org (Postfix) with ESMTPS id 437E63854824
 for <cygwin-patches@cygwin.com>; Mon, 19 Oct 2020 11:49:48 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 437E63854824
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MGiF0-1kiB3Y3OGA-00Dmx2 for <cygwin-patches@cygwin.com>; Mon, 19 Oct 2020
 13:49:46 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 72BF7A8102A; Mon, 19 Oct 2020 13:49:46 +0200 (CEST)
Date: Mon, 19 Oct 2020 13:49:46 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Use aclocal option --system-acdir rather than --acdir
Message-ID: <20201019114946.GE5492@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20201016134615.36159-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201016134615.36159-1-jon.turney@dronecode.org.uk>
X-Provags-ID: V03:K1:CZmL0MpG0iemXq6w7/ou53Yf49BTkTmJ2uPHJPqAAeQmKfp4qwn
 zO1k36SkjfjWvGXe8VImJ1MjOx2+i8CKu3mTgzdtZIuIDAHzHEd50wlF4iu6tWPVEKdtRW6
 I/55lPGsIX6IMk4jXBxRq6224RQP9MMTu0B5FgfS9lsaey8saWW+o/QPhyYmgTd14fbav4C
 z1oZbvdu1ibxvJpRCnbow==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qxSAto9V/Xs=:buCZx2jggv6Ca7nI+uRojw
 j8P1m4LqL2JwpfsM4zArU+JKwV6UJbMnPZH5yttbC5YutKgFfamFm8xFa7LNDVevlopXJtPzX
 jleMcYuFsHMj5ytw/e+bJF357Dx/aLbTU38CySrbsgCZZ0MYIlXbchc2w3Q3dr0rDqRETWBqG
 s2ajZdu7R3yal0K1X5DQPwqXIXWVXVJ76DkEaAS7E8C73AiRE+Bi9F773SltMdZe3T5I1FW0m
 l/VWsv2ANvP/Cv5vm6+mruIjqW2LUiq1W0BECh3pR1uoo2j8AJ7RyU0cgSsCp1ar2UQ76ungD
 2AgVL6/Pi93THupBBYvEUMbAjuSxHrcleTa8Ez5PLFNJ1gtLxhEk6UBP97kqHwAnuqd607zuN
 ddJ4rgls5YDLIrS9hj8vSjb62AtYZozQ1TgGeji1iAjK2ozcH0dW5MwOTqSJDjrvmhauZRqZG
 2eVpqOmtYQ==
X-Spam-Status: No, score=-106.4 required=5.0 tests=BAYES_00, GIT_PATCH_0,
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
X-List-Received-Date: Mon, 19 Oct 2020 11:49:50 -0000

On Oct 16 14:46, Jon Turney wrote:
> In autogen.sh, use 'aclocal --system-acdir' rather than 'aclocal --acdir'.
> 
> '--acdir' was deprecated in automake 1.11 and removed in automake 1.13.
> ---
>  winsup/cygserver/autogen.sh | 2 +-
>  winsup/cygwin/autogen.sh    | 2 +-
>  winsup/utils/autogen.sh     | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/winsup/cygserver/autogen.sh b/winsup/cygserver/autogen.sh
> index 87a0d9c06..dc2c8b70a 100755
> --- a/winsup/cygserver/autogen.sh
> +++ b/winsup/cygserver/autogen.sh
> @@ -1,4 +1,4 @@
>  #!/bin/sh -e
> -/usr/bin/aclocal --acdir=..
> +/usr/bin/aclocal --system-acdir=..
>  /usr/bin/autoconf -f
>  exec /bin/rm -rf autom4te.cache
> diff --git a/winsup/cygwin/autogen.sh b/winsup/cygwin/autogen.sh
> index 87a0d9c06..dc2c8b70a 100755
> --- a/winsup/cygwin/autogen.sh
> +++ b/winsup/cygwin/autogen.sh
> @@ -1,4 +1,4 @@
>  #!/bin/sh -e
> -/usr/bin/aclocal --acdir=..
> +/usr/bin/aclocal --system-acdir=..
>  /usr/bin/autoconf -f
>  exec /bin/rm -rf autom4te.cache
> diff --git a/winsup/utils/autogen.sh b/winsup/utils/autogen.sh
> index 87a0d9c06..dc2c8b70a 100755
> --- a/winsup/utils/autogen.sh
> +++ b/winsup/utils/autogen.sh
> @@ -1,4 +1,4 @@
>  #!/bin/sh -e
> -/usr/bin/aclocal --acdir=..
> +/usr/bin/aclocal --system-acdir=..
>  /usr/bin/autoconf -f
>  exec /bin/rm -rf autom4te.cache
> -- 
> 2.28.0

+1


Corinna
