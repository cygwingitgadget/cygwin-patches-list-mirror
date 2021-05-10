Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
 by sourceware.org (Postfix) with ESMTPS id E172C3938C1E
 for <cygwin-patches@cygwin.com>; Mon, 10 May 2021 08:09:09 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org E172C3938C1E
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MPK73-1lsKnh1r6T-00PfKU for <cygwin-patches@cygwin.com>; Mon, 10 May 2021
 10:09:08 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id E1E73A80E05; Mon, 10 May 2021 10:09:07 +0200 (CEST)
Date: Mon, 10 May 2021 10:09:07 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 3/2] Get rid of relative include paths in strace.cc
Message-ID: <YJjqIx1AylDxmEiF@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210502152537.32312-1-jon.turney@dronecode.org.uk>
 <20210509150939.64863-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210509150939.64863-1-jon.turney@dronecode.org.uk>
X-Provags-ID: V03:K1:SsSfQP7E5JnEWNqn7U+XSi+mQ4DSJymKhd7r8jXXcgIXScZvj9p
 j3A+ProvWL9kLIOkWGvpjCQ7jnwlyoQsvCa2BV0GPNuITRskDp9up060XFgTgw8wtT26iy0
 ZEDGzvO50v/KiYGhr/XiW4+VZThYK/qXS0fTkT6o8cAkr+O1Tf0Ef1AIfyFKij8kAs1i3pO
 ZyPMNuz2YVzY2jbt1vSRg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oht268LET7I=:dkj6cmjW1TVrgb9Xs/H0lN
 Xae/vW6IlAUs7YfLsaBM+gusPlyBkDf/2YVcwgsmpHsQFWjE55mMF7YKmKEP3ZY6HkUPxQIEO
 O4sqgLmWgswUNcL7wCtbOEtpszeYoIitSAcpCjaC7tHrN5eHNAmNYXb7n468imxTcT3a3Xov9
 RBDPGxSrs/aKIqESuRs1o8XKi+nAGJshQAZhgumAqK055ZwA3eImKxYfjy8xpJy1Zxve2mB4P
 uT+gXEsVTtlPYsgZfrHrb6erJk+NrWVKp1Ccn8islqwVB/wOmpKowf9QasxfVNoffod9rP4KB
 pi3hjBzfTWGU3Xj1Yl1yQBYCqnkYxGYaPJ1t29kzFJgXNpujQsXlSvp3O647+VFWnzfXczNo0
 v7rB6p3vlkHjjBRrlf/kIlkCJ7SbXyHhMmVWqbYoUN4tgNZfgf+tTF9p35jhSQ9q2cf9imFY5
 f6tHzoHSmyDGSTHDdkzB5q0KbZjKFtimm+WJNZLqIKyBG+iOeKP5KHCgXZJUiRb3A5sUIzjjI
 a/we9756heGDQKqUoGpSxw=
X-Spam-Status: No, score=-106.3 required=5.0 tests=BAYES_00, GIT_PATCH_0,
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
X-List-Received-Date: Mon, 10 May 2021 08:09:11 -0000

On May  9 16:09, Jon Turney wrote:
> ---
>  winsup/utils/mingw/Makefile.am |  2 +-
>  winsup/utils/mingw/strace.cc   | 10 +++++-----
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/winsup/utils/mingw/Makefile.am b/winsup/utils/mingw/Makefile.am
> index 73abc4264..874dce512 100644
> --- a/winsup/utils/mingw/Makefile.am
> +++ b/winsup/utils/mingw/Makefile.am
> @@ -39,7 +39,7 @@ ldh_SOURCES = ldh.cc
>  strace_SOURCES = \
>  	path.cc \
>  	strace.cc
> -strace_CPPFLAGS=-I$(srcdir)/..
> +strace_CPPFLAGS=-I$(srcdir)/.. -idirafter ${top_srcdir}/cygwin -idirafter ${top_srcdir}/cygwin/include
>  strace_LDADD = -lntdll
>  
>  noinst_PROGRAMS = path-testsuite
> diff --git a/winsup/utils/mingw/strace.cc b/winsup/utils/mingw/strace.cc
> index a7797600c..d8a095fb6 100644
> --- a/winsup/utils/mingw/strace.cc
> +++ b/winsup/utils/mingw/strace.cc
> @@ -21,11 +21,11 @@ details. */
>  #include <time.h>
>  #include <signal.h>
>  #include <errno.h>
> -#include "../../cygwin/include/sys/strace.h"
> -#include "../../cygwin/include/sys/cygwin.h"
> -#include "../../cygwin/include/cygwin/version.h"
> -#include "../../cygwin/cygtls_padsize.h"
> -#include "../../cygwin/gcc_seh.h"
> +#include "sys/strace.h"
> +#include "sys/cygwin.h"
> +#include "cygwin/version.h"
> +#include "cygtls_padsize.h"
> +#include "gcc_seh.h"
>  #include "path.h"
>  #undef cygwin_internal
>  #include "loadlib.h"
> -- 
> 2.31.1

Great, please push.

Thanks,
Corinna
